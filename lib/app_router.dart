import 'package:flutter/material.dart';
import 'package:flash/presentation/screens/home_screen.dart'; // تأكد من استيراد شاشة HomeScreen
import 'package:flash/presentation/screens/splash_screen.dart';
import 'package:flash/presentation/screens/test_screen.dart'; // استيراد شاشة TestScreen

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/homeScreen': // اسم الشاشة الثانية هو HomeScreen
        return MaterialPageRoute(builder: (_) => HomeScreen()); // استبدل بـ HomeScreen الفعلي
      case '/testScreen': // مسار الشاشة الجديدة
        return MaterialPageRoute(builder: (_) => TestScreen()); // استبدل بـ TestScreen الفعلي
      default:
        return null;
    }
  }
}
