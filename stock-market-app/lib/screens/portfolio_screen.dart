import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stocks_app/services/stock_price_service.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Added Scaffold to ensure proper sizing
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<StockPriceService>(
          builder: (context, stockService, child) {
            final portfolioStocks = stockService.portfolioStocks;

            // Show empty state if portfolio is empty
            if (portfolioStocks.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 60,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Your portfolio is empty',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Buy some stocks to get started!',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            // Calculate portfolio summary
            double totalInvestment = 0;
            double totalPortfolioValue = 0;

            for (var item in portfolioStocks) {
              final investment =
                  ((item['purchasePrice'] as num?) ?? 0.0) *
                  ((item['units'] as num?) ?? 0);
              final currentValue =
                  ((item['currentPrice'] as num?) ?? 0.0) *
                  ((item['units'] as num?) ?? 0);

              totalInvestment += investment;
              totalPortfolioValue += currentValue;
            }

            // Calculate profit/loss
            final totalProfitLoss = totalPortfolioValue - totalInvestment;
            final profitLossPercentage =
                totalInvestment > 0
                    ? (totalProfitLoss / totalInvestment * 100)
                    : 0;
            final isOverallProfit = totalProfitLoss >= 0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Portfolio Summary Card
                Card(
                  color: Colors.blueGrey[900],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Portfolio Summary',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Current Value:'),
                            Text(
                              '\$${totalPortfolioValue.toStringAsFixed(2)}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Invested:'),
                            Text('\$${totalInvestment.toStringAsFixed(2)}'),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Profit/Loss:'),
                            Text(
                              '${isOverallProfit ? "+" : ""}\$${totalProfitLoss.toStringAsFixed(2)} (${isOverallProfit ? "+" : ""}${profitLossPercentage.toStringAsFixed(2)}%)',
                              style: TextStyle(
                                color:
                                    isOverallProfit ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Your Holdings',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: portfolioStocks.length,
                    itemBuilder: (context, index) {
                      final item = portfolioStocks[index];
                      final symbol = item['symbol'] as String;
                      final name = item['name'] as String;
                      final units = item['units'] as int;
                      final purchasePrice = item['purchasePrice'] as double;
                      final currentPrice = item['currentPrice'] as double;

                      final investment = purchasePrice * units;
                      final currentValue = currentPrice * units;
                      final profitLoss = currentValue - investment;
                      final profitLossPercentage =
                          investment > 0 ? (profitLoss / investment * 100) : 0;
                      final isProfit = profitLoss >= 0;

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    // Added Expanded to prevent overflow
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          symbol,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          name,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed:
                                        () =>
                                            _showSellDialog(item, stockService),
                                    child: Text('SELL'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('$units units'),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '\$${currentPrice.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${isProfit ? "+" : ""}\$${profitLoss.toStringAsFixed(2)} (${isProfit ? "+" : ""}${profitLossPercentage.toStringAsFixed(2)}%)',
                                        style: TextStyle(
                                          color:
                                              isProfit
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showSellDialog(
    Map<String, dynamic> item,
    StockPriceService stockService,
  ) {
    int sellUnits = 0;
    final maxUnits = item['units'] as int;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          // Added StatefulBuilder for interactive dialog
          builder: (context, setState) {
            // Calculate the total value based on current selection
            final currentPrice = item['currentPrice'] as double;
            final totalValue = sellUnits * currentPrice;

            return AlertDialog(
              title: Text('Sell ${item['symbol']}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'You own $maxUnits units at \$${(item['purchasePrice'] as double).toStringAsFixed(2)} per unit.',
                  ),
                  Text(
                    'Current price: \$${currentPrice.toStringAsFixed(2)} per unit.',
                  ),
                  SizedBox(height: 16),
                  Text('How many units do you want to sell?'),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        sellUnits = int.tryParse(value) ?? 0;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter number of units',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Total value: \$${totalValue.toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    _sellStock(item, sellUnits, stockService);
                    Navigator.of(context).pop();
                  },
                  child: Text('Sell'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _sellStock(
    Map<String, dynamic> item,
    int sellUnits,
    StockPriceService stockService,
  ) {
    final symbol = item['symbol'] as String;
    final maxUnits = item['units'] as int;

    if (sellUnits <= 0 || sellUnits > maxUnits) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Invalid quantity to sell')));
      return;
    }

    try {
      // Sell stock using the service
      stockService.sellStock(symbol, sellUnits);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sold $sellUnits units of $symbol'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error selling stock: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
