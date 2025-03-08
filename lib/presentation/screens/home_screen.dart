import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flash/presentation/screens/metal_rates_screen.dart';
import 'package:flash/presentation/screens/crypto_rates_screen.dart';
import 'package:flash/presentation/screens/currencies_rates_screen.dart';
import 'package:flash/presentation/screens/no_connection_screen.dart';
import 'package:flash/presentation/widgets/custom_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
      if (!isConnected) {
        _currentIndex = -1; 
      } else if (_currentIndex == -1) {
        _currentIndex = 0; 
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
          : NoConnectionScreen(), 
      bottomNavigationBar: isConnected
          ? CustomBottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              onScreenChange: _onScreenChange, 
            )
          : null, 
    );
  }
}