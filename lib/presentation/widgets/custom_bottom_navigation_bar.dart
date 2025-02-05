import 'package:flash/constants.dart';
import 'package:flash/presentation/screens/crypto_rates_screen.dart';
import 'package:flash/presentation/screens/currencies_rates_screen.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index != currentIndex) {
          switch (index) {
            case 0:
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => CurrenciesRatesScreen()),
                (route) => false, // لحذف الشاشات السابقة
              );
              break;
            case 1:
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => CryptoRatesScreen()),
                (route) => false, // لحذف الشاشات السابقة
              );
              break;
            case 2:
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => CurrenciesRatesScreen()),
                (route) => false, // لحذف الشاشات السابقة
              );
              break;
            case 3:
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => CurrenciesRatesScreen()),
                (route) => false, // لحذف الشاشات السابقة
              );
              break;
          }
        }
      },
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
          label: 'currency',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.currency_bitcoin, size: 20),
          label: 'crypto',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.widgets, size: 20),
          label: 'metals',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite, size: 20),
          label: 'favorite',
        ),
      ],
    );
  }
}
