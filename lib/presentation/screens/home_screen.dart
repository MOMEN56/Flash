import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flash/presentation/screens/metal_rates_screen.dart';
import 'package:flash/presentation/screens/crypto_rates_screen.dart';
import 'package:flash/presentation/screens/currencies_rates_screen.dart';
import 'package:flash/presentation/screens/no_connection_screen.dart';
import 'package:flash/presentation/widgets/custom_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool isConnected = true;

  final List<Widget> _screens = [
    CurrenciesRatesScreen(),
    CryptoRatesScreen(),
    MetalRatesScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _checkInitialConnection();
    // الاستماع لتغييرات الاتصال
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> resultList) {
      _updateConnectionStatus(resultList);
    });
  }

  Future<void> _checkInitialConnection() async {
    final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  void _updateConnectionStatus(List<ConnectivityResult> resultList) {
    setState(() {
      // التحقق من وجود اتصال
      isConnected = resultList.isNotEmpty && resultList.first != ConnectivityResult.none;
      if (!isConnected) {
        _currentIndex = -1; // الانتقال إلى شاشة "لا يوجد اتصال"
      } else if (_currentIndex == -1) {
        _currentIndex = 0; // العودة إلى الشاشة الرئيسية عند استعادة الاتصال
      }
    });
  }

  void _onScreenChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isConnected
          ? IndexedStack(
              index: _currentIndex,
              children: _screens,
            )
          : NoConnectionScreen(), // عرض شاشة "لا يوجد اتصال"
      bottomNavigationBar: isConnected
          ? CustomBottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              onScreenChange: _onScreenChange, // إرسال تابع التغيير
            )
          : null, // إخفاء الـ BottomNavigationBar عند عدم وجود اتصال
    );
  }
}