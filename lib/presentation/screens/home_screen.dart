import 'package:flash/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flash/constants.dart';
import 'package:flash/presentation/screens/crypto_rates_screen.dart';
import 'package:flash/presentation/screens/no_connection_screen.dart';
import 'package:flash/presentation/screens/currencies_rates_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool isConnected = true;

  final List<Widget> _screens = [
    const CurrenciesRatesScreen(),
    const CryptoRatesScreen(),
    // لن نضيف شاشات المعدن والمفضلة حالياً
  ];

  @override
  void initState() {
    super.initState();
    _checkConnection();
    Connectivity().onConnectivityChanged.listen((event) {
      setState(() {
        isConnected = event != ConnectivityResult.none;
      });
    });
  }

  Future<void> _checkConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      isConnected = connectivityResult != ConnectivityResult.none;
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
          :  NoConnectionScreen(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index != 2 && index != 3) {  // منع تغيير الشاشة عند الضغط على "المعادن" أو "المفضلة"
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }
}
