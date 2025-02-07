import 'package:flash/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flash/presentation/screens/crypto_rates_screen.dart';
import 'package:flash/presentation/screens/no_connection_screen.dart';
import 'package:flash/presentation/screens/currencies_rates_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isConnected = true;
  int _currentIndex = 0; // لتحديد الشاشة المختارة في الشريط السفلي

  @override
  void initState() {
    super.initState();
    _checkInitialConnection();
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
      isConnected = resultList.isNotEmpty && resultList.first != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isConnected
          ? IndexedStack(
              index: _currentIndex, // عرض الشاشة المختارة بناءً على _currentIndex
              children: const [
                 CurrenciesRatesScreen(),
                 CryptoRatesScreen(),
                
                
              ],
            )
          :  NoConnectionScreen(), // عرض شاشة "لا يوجد اتصال" عند انقطاع الاتصال
      bottomNavigationBar: isConnected
          ? CustomBottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
                // التنقل باستخدام Navigator.pushReplacementNamed
                if (index == 0) {
                  Navigator.pushReplacementNamed(context, '/currenciesRates');
                } else if (index == 1) {
                  Navigator.pushReplacementNamed(context, '/cryptoRates');
                }
              },
            )
          : null,
    );
  }
}
