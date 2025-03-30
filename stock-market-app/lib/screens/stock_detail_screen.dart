import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:stocks_app/services/stock_price_service.dart';

class StockDetailScreen extends StatefulWidget {
  final String symbol;
  final String name;

  StockDetailScreen({required this.symbol, required this.name});

  @override
  _StockDetailScreenState createState() => _StockDetailScreenState();
}

class CandleData {
  final DateTime time;
  final double open;
  final double high;
  final double low;
  final double close;

  CandleData(this.time, this.open, this.high, this.low, this.close);
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  final _moneyController = TextEditingController();
  final _unitsController = TextEditingController();

  bool _isLoading = false;
  double _currentPrice = 0.0;
  List<CandleData> _candleData = [];
  Timer? _timer;
  Stock? _currentStock;

  // Track which field is actively being edited
  bool _editingMoney = false;
  bool _editingUnits = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _startRealTimeSimulation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _moneyController.dispose();
    _unitsController.dispose();
    super.dispose();
  }

  void _initializeData() {
    final stockService = Provider.of<StockPriceService>(context, listen: false);
    _currentStock = stockService.getStock(widget.symbol);

    if (_currentStock != null) {
      _currentPrice = _currentStock!.price;
      _initializeCandleData();
    } else {
      // Fallback if stock not found
      _currentPrice = 100.0;
      _initializeCandleData();
    }
  }

  void _initializeCandleData() {
    final now = DateTime.now();
    final Random random = Random();
    final basePrice = _currentPrice;

    for (int i = 20; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      // Generate plausible historical data around current price
      final dayVariation =
          random.nextDouble() * (basePrice * 0.1) - (basePrice * 0.05);
      final open = basePrice + dayVariation;
      final close =
          open + random.nextDouble() * (basePrice * 0.04) - (basePrice * 0.02);
      final high = max(open, close) + random.nextDouble() * (basePrice * 0.02);
      final low = min(open, close) - random.nextDouble() * (basePrice * 0.02);

      _candleData.add(CandleData(date, open, high, low, close));
    }

    // Make sure the last close price matches the current price
    _candleData.last = CandleData(
      now,
      _candleData.last.open,
      max(_currentPrice, _candleData.last.high),
      min(_currentPrice, _candleData.last.low),
      _currentPrice,
    );
  }

  void _startRealTimeSimulation() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (!mounted) return;

      // Get the updated price from the service
      final stockService = Provider.of<StockPriceService>(
        context,
        listen: false,
      );
      final updatedStock = stockService.getStock(widget.symbol);

      if (updatedStock != null && updatedStock.price != _currentPrice) {
        setState(() {
          _currentPrice = updatedStock.price;
          _updateCandleData();

          // Only update the field that is NOT being edited
          if (_editingMoney && _moneyController.text.isNotEmpty) {
            // If editing money field, update only units field
            _updateUnitsFromMoney();
          } else if (_editingUnits && _unitsController.text.isNotEmpty) {
            // If editing units field, update only money field
            _updateMoneyFromUnits();
          } else if (_moneyController.text.isNotEmpty) {
            // Neither field is being actively edited, but money has a value
            _updateUnitsFromMoney();
          } else if (_unitsController.text.isNotEmpty) {
            // Neither field is being actively edited, but units has a value
            _updateMoneyFromUnits();
          }
        });
      }
    });
  }

  void _updateCandleData() {
    final Random random = Random();
    final lastClose = _candleData.last.close;
    final now = DateTime.now();

    // Create variation that tends toward the current price
    final close = _currentPrice;
    final open = lastClose;
    final high =
        max(open, close) + random.nextDouble() * (_currentPrice * 0.01);
    final low = min(open, close) - random.nextDouble() * (_currentPrice * 0.01);

    _candleData.add(CandleData(now, open, high, low, close));

    if (_candleData.length > 30) {
      _candleData.removeAt(0);
    }
  }

  // Update units field based on money amount without triggering listeners
  void _updateUnitsFromMoney() {
    if (_moneyController.text.isEmpty) return;

    try {
      final money = double.parse(_moneyController.text);
      if (money > 0 && _currentPrice > 0) {
        final units = money / _currentPrice;
        _unitsController.text = units.toStringAsFixed(4);
      }
    } catch (e) {
      // Handle parse error
    }
  }

  // Update money field based on units without triggering listeners
  void _updateMoneyFromUnits() {
    if (_unitsController.text.isEmpty) return;

    try {
      final units = double.parse(_unitsController.text);
      if (units > 0) {
        final money = units * _currentPrice;
        _moneyController.text = money.toStringAsFixed(2);
      }
    } catch (e) {
      // Handle parse error
    }
  }

  void _showBuyConfirmation() {
    if (_unitsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter the number of units to buy')),
      );
      return;
    }

    final units = int.tryParse(_unitsController.text) ?? 0;
    if (units <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid number of units')),
      );
      return;
    }

    final totalCost = units * _currentPrice;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Confirm Purchase'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('You are about to buy:'),
                SizedBox(height: 8),
                Text(
                  '$units units of ${widget.symbol} at \$${_currentPrice.toStringAsFixed(2)} per unit',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Total cost: \$${totalCost.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text('Do you want to proceed with this purchase?'),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text('Confirm Purchase'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _buyStock();
                },
              ),
            ],
          ),
    );
  }

  void _showSellConfirmation() {
    if (_unitsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter the number of units to sell')),
      );
      return;
    }

    final units = int.tryParse(_unitsController.text) ?? 0;
    if (units <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid number of units')),
      );
      return;
    }

    final stockService = Provider.of<StockPriceService>(context, listen: false);
    final portfolioStocks = stockService.portfolioStocks;

    // Find the owned stock safely
    int ownedUnits = 0;
    for (final item in portfolioStocks) {
      if (item['symbol'] == widget.symbol) {
        ownedUnits = (item['units'] as int?) ?? 0;
        break;
      }
    }

    if (units > ownedUnits) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You only own $ownedUnits units of ${widget.symbol}'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final totalValue = units * _currentPrice;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Confirm Sale'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('You are about to sell:'),
                SizedBox(height: 8),
                Text(
                  '$units units of ${widget.symbol} at \$${_currentPrice.toStringAsFixed(2)} per unit',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Total value: \$${totalValue.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text('Do you want to proceed with this sale?'),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Confirm Sale'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _sellStock();
                },
              ),
            ],
          ),
    );
  }

  void _buyStock() {
    if (_unitsController.text.isNotEmpty) {
      final units = int.tryParse(_unitsController.text);

      if (units != null && units > 0) {
        try {
          // Use the same service as in stocks_screen
          final stockService = Provider.of<StockPriceService>(
            context,
            listen: false,
          );

          // Make sure the stock exists
          final stock = stockService.getStock(widget.symbol);
          if (stock == null) {
            throw Exception("Stock not found");
          }

          print("Buying $units units of ${widget.symbol}");
          stockService.buyStock(widget.symbol, units);

          // Success notification
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Successfully bought $units units of ${widget.symbol}',
              ),
              backgroundColor: Colors.green,
            ),
          );

          // Clear input fields
          _moneyController.clear();
          _unitsController.clear();

          // Force UI to update
          setState(() {});
        } catch (e) {
          print("Error buying stock: $e");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error buying stock: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  void _sellStock() {
    if (_unitsController.text.isNotEmpty) {
      final units = int.tryParse(_unitsController.text);

      if (units != null && units > 0) {
        try {
          final stockService = Provider.of<StockPriceService>(
            context,
            listen: false,
          );

          // Check if user owns enough units
          final portfolioStocks = stockService.portfolioStocks;

          // Find the owned stock safely
          int ownedUnits = 0;
          for (final item in portfolioStocks) {
            if (item['symbol'] == widget.symbol) {
              ownedUnits = (item['units'] as int?) ?? 0;
              break;
            }
          }

          if (ownedUnits >= units) {
            // Use the service to sell
            print("Selling $units units of ${widget.symbol}");
            stockService.sellStock(widget.symbol, units);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Successfully sold $units units of ${widget.symbol}',
                ),
                backgroundColor: Colors.orange,
              ),
            );

            _moneyController.clear();
            _unitsController.clear();

            // Force UI to update
            setState(() {});
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'You only own $ownedUnits units of ${widget.symbol}',
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        } catch (e) {
          print("Error selling stock: $e");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error selling stock: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  List<FlSpot> _createDummyChartData() {
    return _candleData.asMap().entries.map((entry) {
      final index = entry.key.toDouble();
      final data = entry.value;
      return FlSpot(index, data.close);
    }).toList();
  }

  Widget _buildCandlestickChart() {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: _createDummyChartData(),
            isCurved: false,
            color: Colors.white,
            barWidth: 2,
            dotData: FlDotData(show: false),
          ),
        ],
        minY: _findMinClose() - 5,
        maxY: _findMaxClose() + 5,
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: Colors.white10, strokeWidth: 1);
          },
          getDrawingVerticalLine: (value) {
            return FlLine(color: Colors.white10, strokeWidth: 1);
          },
        ),
      ),
    );
  }

  double _findMinClose() {
    double min = double.infinity;
    for (var candle in _candleData) {
      if (candle.low < min) min = candle.low;
    }
    return min;
  }

  double _findMaxClose() {
    double max = 0;
    for (var candle in _candleData) {
      if (candle.high > max) max = candle.high;
    }
    return max;
  }

  @override
  Widget build(BuildContext context) {
    // Use Consumer to get real-time price updates
    return Consumer<StockPriceService>(
      builder: (context, stockService, child) {
        // Calculate price change
        final previousClose =
            _candleData.isNotEmpty && _candleData.length >= 2
                ? _candleData[_candleData.length - 2].close
                : _currentPrice;
        final priceChange = _currentPrice - previousClose;
        final isPositiveChange = priceChange >= 0;

        // Get portfolio data for this stock safely
        int ownedUnits = 0;
        final portfolioStocks = stockService.portfolioStocks;

        // Find the owned stock safely using iteration instead of firstWhere
        for (final item in portfolioStocks) {
          if (item['symbol'] == widget.symbol) {
            ownedUnits = (item['units'] as int?) ?? 0;
            break;
          }
        }

        return Scaffold(
          appBar: AppBar(title: Text('${widget.name} (${widget.symbol})')),
          body:
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.name} (${widget.symbol})',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      'Current Price: \$${_currentPrice.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            isPositiveChange
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      isPositiveChange
                                          ? Icons.arrow_upward
                                          : Icons.arrow_downward,
                                      color:
                                          isPositiveChange
                                              ? Colors.green
                                              : Colors.red,
                                      size: 16,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '${isPositiveChange ? "+" : ""}${priceChange.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color:
                                            isPositiveChange
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                if (ownedUnits > 0)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      'You own $ownedUnits units of this stock',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          flex: 2,
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _buildCandlestickChart(),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          flex: 2,
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Trade',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Focus(
                                          onFocusChange: (hasFocus) {
                                            setState(() {
                                              _editingMoney = hasFocus;
                                            });
                                          },
                                          child: TextField(
                                            controller: _moneyController,
                                            decoration: InputDecoration(
                                              labelText: 'Amount (\$)',
                                              border: OutlineInputBorder(),
                                            ),
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                  decimal: true,
                                                ),
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                _updateUnitsFromMoney();
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Focus(
                                          onFocusChange: (hasFocus) {
                                            setState(() {
                                              _editingUnits = hasFocus;
                                            });
                                          },
                                          child: TextField(
                                            controller: _unitsController,
                                            decoration: InputDecoration(
                                              labelText: 'Units',
                                              border: OutlineInputBorder(),
                                            ),
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                  decimal: true,
                                                ),
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                _updateMoneyFromUnits();
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: _showBuyConfirmation,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            padding: EdgeInsets.symmetric(
                                              vertical: 16,
                                            ),
                                          ),
                                          child: Text(
                                            'Buy',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed:
                                              ownedUnits > 0
                                                  ? _showSellConfirmation
                                                  : null,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            padding: EdgeInsets.symmetric(
                                              vertical: 16,
                                            ),
                                            // Disable the button if user doesn't own any units
                                            disabledBackgroundColor:
                                                Colors.grey,
                                          ),
                                          child: Text(
                                            'Sell',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
        );
      },
    );
  }
}
