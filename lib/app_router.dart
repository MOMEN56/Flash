import 'package:flash/presentation/screens/currencies_rates_screen.dart';
import 'package:flash/presentation/screens/no_connection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash/presentation/screens/home_screen.dart'; // تأكد من استيراد شاشة HomeScreen
import 'package:flash/presentation/screens/splash_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/homeScreen': // اسم الشاشة الثانية هو HomeScreen
        return MaterialPageRoute(builder: (_) => HomeScreen()); // استبدل بـ HomeScreen الفعلي
      case '/NoConnectionScreen': // اسم الشاشة الثانية هو HomeScreen
        return MaterialPageRoute(builder: (_) => NoConnectionScreen()); // استبدل بـ HomeScreen الفعلي
      case '/CurrenciesRatesScreen': // اسم الشاشة الثانية هو HomeScreen
        return MaterialPageRoute(builder: (_) => CurrenciesRatesScreen()); // استبدل بـ HomeScreen الفعلي
      default:
        return null;
    }
  }
}
