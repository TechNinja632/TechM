import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';

class Stock {
  final String symbol;
  final String name;
  double price;
  double change;

  Stock({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
  });
}

class PortfolioItem {
  final String symbol;
  final String name;
  int units;
  final double purchasePrice;
  double currentPrice;

  PortfolioItem({
    required this.symbol,
    required this.name,
    required this.units,
    required this.purchasePrice,
    required this.currentPrice,
  });

  @override
  String toString() {
    return 'PortfolioItem{symbol: $symbol, units: $units, purchasePrice: $purchasePrice, currentPrice: $currentPrice}';
  }
}

class StockPriceService extends ChangeNotifier {
  final List<Stock> _stocks = [
    Stock(symbol: 'AAPL', name: 'Apple Inc.', price: 185.92, change: 0.67),
    Stock(symbol: 'GOOGL', name: 'Alphabet Inc.', price: 142.65, change: -1.23),
    Stock(symbol: 'AMZN', name: 'Amazon.com Inc.', price: 178.22, change: 2.15),
    Stock(
      symbol: 'MSFT',
      name: 'Microsoft Corporation',
      price: 417.88,
      change: 1.25,
    ),
    Stock(symbol: 'TSLA', name: 'Tesla Inc.', price: 177.35, change: -2.84),
    Stock(
      symbol: 'META',
      name: 'Meta Platforms Inc.',
      price: 472.75,
      change: 0.89,
    ),
    Stock(symbol: 'NFLX', name: 'Netflix Inc.', price: 624.31, change: 3.56),
    Stock(symbol: 'DIS', name: 'Walt Disney Co', price: 111.45, change: -0.32),
    Stock(
      symbol: 'NVDA',
      name: 'NVIDIA Corporation',
      price: 950.02,
      change: 15.75,
    ),
    Stock(
      symbol: 'AMD',
      name: 'Advanced Micro Devices',
      price: 176.71,
      change: -1.25,
    ),
  ];

  // Maintain a local watchlist
  final Set<String> _watchlist = {};

  // User's portfolio - symbol to portfolio item
  final Map<String, PortfolioItem> _portfolio = {};

  Timer? _timer;
  final Random _random = Random();

  StockPriceService() {
    _startPriceUpdates();

    // Add some initial portfolio items for testing
    // Comment these out in production
    /*
    buyStock('AAPL', 5);
    buyStock('MSFT', 3);
    buyStock('GOOGL', 2);
    */
  }

  List<Stock> get allStocks => List.unmodifiable(_stocks);

  // Get watchlist stocks
  List<Stock> get watchlistStocks =>
      _stocks.where((s) => _watchlist.contains(s.symbol)).toList();

  // Get portfolio stocks as map list for easy UI display
  // Changed return type to List<Map<String, Object>> for better type safety
  List<Map<String, Object>> get portfolioStocks {
    List<Map<String, Object>> result = [];

    _portfolio.values.forEach((item) {
      // Update current price
      final currentStock = getStock(item.symbol);
      if (currentStock != null) {
        item.currentPrice = currentStock.price;
      }

      result.add({
        'symbol': item.symbol,
        'name': item.name,
        'units': item.units,
        'purchasePrice': item.purchasePrice,
        'currentPrice': item.currentPrice,
      });
    });

    return result;
  }

  // Debug method to print portfolio contents
  void debugPrintPortfolio() {
    print("Current portfolio contents:");
    _portfolio.forEach((symbol, item) {
      print(
        "$symbol: ${item.units} units at \$${item.purchasePrice} (Current: \$${item.currentPrice})",
      );
    });
  }

  Stock? getStock(String symbol) {
    try {
      return _stocks.firstWhere((stock) => stock.symbol == symbol);
    } catch (_) {
      return null;
    }
  }

  // Add to watchlist - instant operation
  void addToWatchlist(String symbol) {
    _watchlist.add(symbol);
    notifyListeners();
  }

  // Remove from watchlist - instant operation
  void removeFromWatchlist(String symbol) {
    _watchlist.remove(symbol);
    notifyListeners();
  }

  // Check if stock is in watchlist
  bool isInWatchlist(String symbol) {
    return _watchlist.contains(symbol);
  }

  // Check if stock is in portfolio and get units
  int getPortfolioUnits(String symbol) {
    if (_portfolio.containsKey(symbol)) {
      return _portfolio[symbol]!.units;
    }
    return 0;
  }

  // Buy stock - instant operation
  void buyStock(String symbol, int units) {
    print("buyStock called: $symbol, $units units");

    if (units <= 0) {
      print("Error: Cannot buy $units units");
      return;
    }

    final stock = getStock(symbol);
    if (stock == null) {
      print("Error: Stock $symbol not found");
      return;
    }

    if (_portfolio.containsKey(symbol)) {
      // Update existing holding (average down/up)
      final existing = _portfolio[symbol]!;
      final totalOldValue = existing.units * existing.purchasePrice;
      final totalNewValue = units * stock.price;
      final newTotalUnits = existing.units + units;
      final averagePrice = (totalOldValue + totalNewValue) / newTotalUnits;

      print(
        "Updating existing holding: $symbol from ${existing.units} to $newTotalUnits units",
      );

      _portfolio[symbol] = PortfolioItem(
        symbol: symbol,
        name: stock.name,
        units: newTotalUnits,
        purchasePrice: averagePrice,
        currentPrice: stock.price,
      );
    } else {
      // Add new stock to portfolio
      print(
        "Adding new stock to portfolio: $symbol, $units units at ${stock.price}",
      );

      _portfolio[symbol] = PortfolioItem(
        symbol: symbol,
        name: stock.name,
        units: units,
        purchasePrice: stock.price,
        currentPrice: stock.price,
      );
    }

    debugPrintPortfolio();
    notifyListeners();
  }

  // Sell stock - instant operation
  void sellStock(String symbol, int units) {
    print("sellStock called: $symbol, $units units");

    if (!_portfolio.containsKey(symbol)) {
      print("Error: $symbol not in portfolio");
      return;
    }

    if (units <= 0) {
      print("Error: Cannot sell $units units");
      return;
    }

    final item = _portfolio[symbol]!;

    if (units > item.units) {
      print("Error: Cannot sell $units units, only have ${item.units}");
      return;
    }

    if (units >= item.units) {
      // Sell all units - remove from portfolio
      print(
        "Removing $symbol from portfolio (selling all ${item.units} units)",
      );
      _portfolio.remove(symbol);
    } else {
      // Partial sell - update units
      print(
        "Reducing $symbol from ${item.units} to ${item.units - units} units",
      );
      item.units -= units;
    }

    debugPrintPortfolio();
    notifyListeners();
  }

  void _startPriceUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      for (var stock in _stocks) {
        // Random price change between -1.5% and +1.5%
        double changePercentage = (_random.nextDouble() * 3) - 1.5;
        stock.price *= (1 + changePercentage / 100);
        stock.change = changePercentage;
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
