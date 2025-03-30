import 'package:flutter/material.dart';
import 'package:stocks_app/screens/stocks_screen.dart';
import 'package:stocks_app/screens/watchlist_screen.dart';
import 'package:stocks_app/screens/portfolio_screen.dart';
import 'package:stocks_app/screens/profile_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    StocksScreen(),
    WatchlistScreen(),
    PortfolioScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Use localized titles
    final List<String> _titles = [
      'navigation.stocks'.tr(),
      'navigation.watchlist'.tr(),
      'navigation.portfolio'.tr(),
      'navigation.profile'.tr(),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(_titles[_currentIndex])),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'navigation.stocks'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'navigation.watchlist'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'navigation.portfolio'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'navigation.profile'.tr(),
          ),
        ],
      ),
    );
  }
}
