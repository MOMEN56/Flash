import 'package:flash/constants.dart';
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
          label: 'currency',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.currency_bitcoin, size: 20),
          label: 'crypto',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/images/img.icons8.png"),
            size: 20,
          ),
          label: 'metals', // ستكون غير مفعلة حالياً
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite, size: 20),
          label: 'favorite', // ستكون غير مفعلة حالياً
        ),
      ],
    );
  }
}
