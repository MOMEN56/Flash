import 'package:flash/constants.dart';
import 'package:flash/presentation/screens/crypto_info_screen.dart';
import 'package:flash/presentation/screens/crypto_rates_screen.dart';
import 'package:flash/presentation/screens/currencies_rates_screen.dart';
import 'package:flash/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash/data/models/cyrpto_model.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(kPrimaryColor),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      iconSize: 20,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money, size: 20),
          label: 'Currency',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.currency_bitcoin, size: 20),
          label: 'Crypto',
        ),
      ],
    );
  }
}
