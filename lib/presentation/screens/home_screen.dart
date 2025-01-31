import 'package:flash/presentation/screens/no_connection_screen.dart';  // استيراد شاشة عدم الاتصال
import 'package:flash/presentation/screens/currencies_rates_screen.dart';  // استيراد شاشة أسعار العملات
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';  // استيراد مكتبة الاتصال بالإنترنت

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isConnected = true; // حالة الاتصال بالإنترنت

  @override
  void initState() {
    super.initState();
    _checkConnection();
    // إضافة مستمع لحالة الاتصال عند التغيير
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      _updateConnectionStatus(results);  // التعامل مع النتيجة كـ List<ConnectivityResult>
    });
  }

  // التحقق من الاتصال بالإنترنت
  Future<void> _checkConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  // تحديث حالة الاتصال بناءً على النتيجة
  void _updateConnectionStatus(List<ConnectivityResult> results) {
    setState(() {
      isConnected = results.any((result) => result != ConnectivityResult.none);
    });
  }

  @override
  Widget build(BuildContext context) {
    // إذا كان هناك اتصال بالإنترنت نعرض شاشة أسعار العملات، وإذا لا نعرض شاشة عدم الاتصال
    return isConnected ? const CurrenciesRatesScreen() : NoConnectionScreen();
  }
}