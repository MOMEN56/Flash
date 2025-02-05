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
  int _currentIndex = 0;
  bool isConnected = true;

  final List<Widget> _screens = [
    const CurrenciesRatesScreen(),
    const CryptoRatesScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _checkInitialConnection();
    // Listen for connectivity changes
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
      // Check if there's any non-ConnectivityResult.none
      isConnected = resultList.isNotEmpty && resultList.first != ConnectivityResult.none;
      if (!isConnected) {
        _currentIndex = -1; // Set to the "No Connection" screen
      } else if (_currentIndex == -1) {
        _currentIndex = 0; // Switch back to the default screen when connection is restored
      }
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
          :  NoConnectionScreen(), // Show the "No Connection" screen
    );
  }
}