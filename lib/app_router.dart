import 'package:flutter/material.dart';
import 'package:flash/presentation/screens/home_screen.dart'; // تأكد من استيراد شاشة HomeScreen
import 'package:flash/presentation/screens/splash_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/homeScreen': // اسم الشاشة الثانية هو HomeScreen
        return MaterialPageRoute(builder: (_) =>  HomeScreen()); // استبدل بـ HomeScreen الفعلي
      default:
        return null;
    }
  }
}
