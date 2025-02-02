import 'package:flutter/material.dart';
import 'package:flash/constants.dart';

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
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.currency_bitcoin),
          label: 'crypto',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          label: 'currency',
        ),
      ],
      selectedItemColor: Colors.white, // اللون المختار للأيقونة
      unselectedItemColor: Colors.grey, // اللون للأيقونات غير المحددة
      backgroundColor: Color(kPrimaryColor), // خلفية الشريط
    );
  }
}
