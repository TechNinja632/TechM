import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stocks_app/screens/stock_detail_screen.dart';
import 'package:stocks_app/services/stock_price_service.dart';

class WatchlistScreen extends StatefulWidget {
  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Consumer<StockPriceService>(
              builder: (context, stockService, child) {
                final watchlistStocks = stockService.watchlistStocks;

                if (watchlistStocks.isEmpty) {
                  return _buildEmptyState();
                }

                return ListView.builder(
                  itemCount: watchlistStocks.length,
                  itemBuilder: (context, index) {
                    final stock = watchlistStocks[index];
                    final bool isPositive = stock.change >= 0;

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
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
                                      isPositive
                                          ? Icons.arrow_upward
                                          : Icons.arrow_downward,
                                      color:
                                          isPositive
                                              ? Colors.green
                                              : Colors.red,
                                      size: 12,
                                    ),
                                    Text(
                                      '${isPositive ? '+' : ''}${stock.change.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color:
                                            isPositive
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.delete_outline),
                              tooltip: 'Remove from watchlist',
                              onPressed:
                                  () => _removeFromWatchlist(stock.symbol),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _removeFromWatchlist(String symbol) {
    try {
      // Show immediate feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Removing $symbol from watchlist...'),
          duration: Duration(milliseconds: 500),
        ),
      );

      // Remove from watchlist service - this is instant
      Provider.of<StockPriceService>(
        context,
        listen: false,
      ).removeFromWatchlist(symbol);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$symbol removed from watchlist')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error removing stock from watchlist')),
      );
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star_border, size: 60, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Your watchlist is empty',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Add stocks from the market view',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
