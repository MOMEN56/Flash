import 'package:flash/constants.dart';
import 'package:flash/generated/l10n.dart';
import 'package:flash/presentation/screens/metal_rates_screen.dart';
import 'package:flash/presentation/screens/crypto_rates_screen.dart';
import 'package:flash/presentation/screens/currencies_rates_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Function(int) onScreenChange; 

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onScreenChange, 
  });

  @override
  Widget build(BuildContext context) {
    double MediaQueryHeight = MediaQuery.of(context).size.height;
    double MediaQueryWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
        color:
            Color(kPrimaryColor), 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0, -1),
            blurRadius: 8,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            index: 0,
            icon: Icons.attach_money,
            label: S.of(context).currency,
            onTap: () {
              onScreenChange(0); 
            },
          ),
          _buildNavItem(
            index: 1,
            icon: Icons.currency_bitcoin,
            label: S.of(context).cyrpto,
            onTap: () {
              onScreenChange(1); 
            },
          ),
          _buildNavItem(
            index: 2,
            icon: Icons.precision_manufacturing,
            label: S.of(context).metal,
            onTap: () {
              onScreenChange(2); 
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    bool isSelected = index == currentIndex;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24.sp,
            color: isSelected ? Colors.white : Colors.grey,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ),
          SizedBox(height: 4.h),
          
          Container(
            height: 2.h,
            width: 25.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
