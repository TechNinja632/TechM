import 'package:flutter/material.dart';
import 'package:stocks_app/screens/stock_detail_screen.dart';
import 'package:stocks_app/services/stock_price_service.dart';
import 'package:provider/provider.dart';

class StocksScreen extends StatefulWidget {
  @override
  _StocksScreenState createState() => _StocksScreenState();
}

class _StocksScreenState extends State<StocksScreen> {
  final _searchController = TextEditingController();
  List<Stock> _filteredStocks = [];
  List<Stock> _allStocks = [];

  // Track stocks being added to watchlist for UI feedback
  Set<String> _addingToWatchlist = {};

  @override
  void initState() {
    super.initState();
    // Add listener to search controller
    _searchController.addListener(_onSearchChanged);

    // Initial stocks load
    final stockService = Provider.of<StockPriceService>(context, listen: false);
    _allStocks = stockService.allStocks;
    _filteredStocks = _allStocks;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final stockService = Provider.of<StockPriceService>(context, listen: false);
    if (_allStocks != stockService.allStocks) {
      setState(() {
        _allStocks = stockService.allStocks;
        _updateFilteredStocks();
      });
    }
  }

  void _onSearchChanged() {
    _updateFilteredStocks();
  }

  void _updateFilteredStocks() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredStocks =
          _allStocks
              .where(
                (stock) =>
                    stock.symbol.toLowerCase().contains(query) ||
                    stock.name.toLowerCase().contains(query),
              )
              .toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  // Much simpler watchlist method - just adds to the service
  void _addToWatchlist(String symbol, String name) {
    // Show immediate visual feedback
    setState(() {
      _addingToWatchlist.add(symbol);
    });

    // Simple and immediate operation
    final stockService = Provider.of<StockPriceService>(context, listen: false);
    stockService.addToWatchlist(symbol);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$symbol added to watchlist'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );

    // Remove loading state
    setState(() {
      _addingToWatchlist.remove(symbol);
    });
  }

  // New method for buying stocks
  void _showBuyDialog(Stock stock) {
    int buyUnits = 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Buy ${stock.symbol}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current price: \$${stock.price.toStringAsFixed(2)} per unit',
              ),
              SizedBox(height: 16),
              Text('How many units do you want to buy?'),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  buyUnits = int.tryParse(value) ?? 0;
                },
                decoration: InputDecoration(hintText: 'Enter number of units'),
              ),
              SizedBox(height: 8),
              Text(
                'Total cost: \$${((buyUnits) * stock.price).toStringAsFixed(2)}',
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
                _buyStock(stock, buyUnits);
                Navigator.of(context).pop();
              },
              child: Text('Buy'),
            ),
          ],
        );
      },
    );
  }

  // Method to handle stock purchase - simplified
  void _buyStock(Stock stock, int units) {
    if (units <= 0) return;

    try {
      // Simply add to the service
      final stockService = Provider.of<StockPriceService>(
        context,
        listen: false,
      );
      stockService.buyStock(stock.symbol, units);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bought $units units of ${stock.symbol}'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: Failed to buy stock'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error buying stock: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StockPriceService>(
      builder: (context, stockService, child) {
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search Stocks',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    suffixIcon:
                        _searchController.text.isNotEmpty
                            ? IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                              },
                            )
                            : null,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredStocks.length,
                  itemBuilder: (context, index) {
                    final stock = _filteredStocks[index];
                    final bool isPositiveChange = stock.change >= 0;
                    final bool isAddingToWatchlist = _addingToWatchlist
                        .contains(stock.symbol);
                    final bool isInWatchlist = stockService.isInWatchlist(
                      stock.symbol,
                    );

                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: ListTile(
                        title: Text(
                          stock.symbol,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(stock.name),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$${stock.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      isPositiveChange
                                          ? Icons.arrow_upward
                                          : Icons.arrow_downward,
                                      color:
                                          isPositiveChange
                                              ? Colors.green
                                              : Colors.red,
                                      size: 12,
                                    ),
                                    Text(
                                      '${isPositiveChange ? '+' : ''}${stock.change.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color:
                                            isPositiveChange
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Buy button
                            IconButton(
                              icon: Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.green,
                              ),
                              tooltip: 'Buy',
                              onPressed: () => _showBuyDialog(stock),
                            ),
                            // Watchlist button with loading indicator or checkmark if already in watchlist
                            isAddingToWatchlist
                                ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor,
                                    ),
                                  ),
                                )
                                : IconButton(
                                  icon: Icon(
                                    isInWatchlist
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: isInWatchlist ? Colors.amber : null,
                                  ),
                                  tooltip:
                                      isInWatchlist
                                          ? 'In watchlist'
                                          : 'Add to watchlist',
                                  onPressed:
                                      isInWatchlist
                                          ? null // Already in watchlist
                                          : () => _addToWatchlist(
                                            stock.symbol,
                                            stock.name,
                                          ),
                                ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => StockDetailScreen(
                                    symbol: stock.symbol,
                                    name: stock.name,
                                  ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
