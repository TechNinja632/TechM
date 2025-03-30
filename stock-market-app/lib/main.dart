import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stocks_app/screens/login_screen.dart';
import 'package:stocks_app/screens/main_navigation_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:stocks_app/services/stock_price_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Get the saved locale from SharedPreferences
Future<Locale> _getSavedLocale() async {
  final prefs = await SharedPreferences.getInstance();
  final languageCode = prefs.getString('language_code');

  if (languageCode != null &&
      (languageCode == 'en' || languageCode == 'hi' || languageCode == 'ta')) {
    return Locale(languageCode);
  }

  return Locale('en'); // Default to English
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize EasyLocalization first
  await EasyLocalization.ensureInitialized();
  final savedLocale = await _getSavedLocale();

  try {
    print("Starting Firebase initialization");

    if (kIsWeb) {
      // Web-specific initialization
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: "xxxxxxxx",
          authDomain: "stockmarketapp-cdd95.firebaseapp.com",
          projectId: "xxxxxx",
          storageBucket: "xxxxx",
          messagingSenderId: "xxxxxx",
          appId: "xxxxxxx",
          measurementId: "xxxxxx",
        ),
      );
    } else {
      // Android, iOS initialization (uses google-services.json)
      await Firebase.initializeApp();
    }

    print("Firebase initialized successfully");
  } catch (e) {
    print("Firebase initialization error: $e");
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('hi'), Locale('ta')],
      path: 'assets/language', // Path updated to work with web
      fallbackLocale: const Locale('en'),
      startLocale: savedLocale,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => StockPriceService()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'app_name'.tr(),
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              return LoginScreen();
            }
            return MainNavigationScreen();
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
