import 'package:flash/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSearchPressed;

  CustomAppBar({super.key, required this.onSearchPressed})
      : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(kPrimaryColor),
      title: Padding(
        padding: EdgeInsets.only(left: 70.w),  // إضافة مساحة خفيفة نحو اليمين
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Flash",
              style: TextStyle(
                fontFamily: 'PassionOne',
                color: Colors.white,
                fontSize: 50.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.flash_on, size: 55.w, color: Colors.yellow),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Colors.white, size: 32.w),
          onPressed: onSearchPressed,
        ),
      ],
    );
  }
}
