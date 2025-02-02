import 'package:flutter/material.dart';
import 'package:flash/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      items:  [
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite,size: 22.w),
          label: 'favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.currency_bitcoin,size: 22.w),
          label: 'crypto',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money,size: 22.w),
          label: 'currency',
        ),
      ],
      selectedItemColor: Colors.white, // اللون المختار للأيقونة
      unselectedItemColor: Colors.grey, // اللون للأيقونات غير المحددة
      backgroundColor: Color(kPrimaryColor), // خلفية الشريط
    );
  }
}
