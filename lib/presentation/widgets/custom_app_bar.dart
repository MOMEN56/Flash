import 'package:flash/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onSearchPressed;
  final bool showSearchIcon;
  final double titlePaddingLeft;

  CustomAppBar({
    super.key,
    this.onSearchPressed,
    this.showSearchIcon = true,
    this.titlePaddingLeft = 80.0,  // تعيين قيمة افتراضية 70
  }) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(kPrimaryColor),
      iconTheme: IconThemeData(color: Colors.white), // لون أيقونة الباك
      title: Padding(
        padding: EdgeInsets.only(left: titlePaddingLeft.h), // استخدام البادينج المحدد
        child: Row(
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
      actions: showSearchIcon
          ? [
              IconButton(
                icon: Icon(Icons.search, color: Colors.white, size: 32.w),
                onPressed: onSearchPressed,
              ),
            ]
          : [],
    );
  }
}
