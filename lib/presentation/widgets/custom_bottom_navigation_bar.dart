import 'package:flash/constants.dart';
import 'package:flash/presentation/screens/metal_rates_screen.dart';
import 'package:flash/presentation/screens/crypto_rates_screen.dart';
import 'package:flash/presentation/screens/currencies_rates_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Function(int) onScreenChange; // تابع لإخبار الشاشة بالتغيير

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onScreenChange, // إضافة تابع التغيير
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
        color: Color(kPrimaryColor), // تغيير اللون أو جعله dynamic بناءً على الكود
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
            label: 'Currency',
            onTap: () {
              onScreenChange(0); // استدعاء التغيير باستخدام onScreenChange
            },
          ),
          _buildNavItem(
            index: 1,
            icon: Icons.currency_bitcoin,
            label: 'Crypto',
            onTap: () {
              onScreenChange(1); // استدعاء التغيير باستخدام onScreenChange
            },
          ),
          _buildNavItem(
            index: 2,
            icon: Icons.precision_manufacturing,
            label: 'Metal',
            onTap: () {
              onScreenChange(2); // استدعاء التغيير باستخدام onScreenChange
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
            size: 25.w,
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
          // الخط التحتاني للإشارة إلى العنصر المحدد
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
