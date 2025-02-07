import 'package:flash/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onSearchPressed;
  final bool showSearchIcon;
  final double titlePaddingLeft;
  final bool showBackButton; // خاصية جديدة لتحديد إذا كانت الأيقونة تظهر أم لا

  CustomAppBar({
    super.key,
    this.onSearchPressed,
    this.showSearchIcon = true,
    this.titlePaddingLeft = 80, // تعيين قيمة افتراضية 70
    this.showBackButton = true, // تعيين قيمة افتراضية true لعرض الأيقونة
  }) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(kPrimaryColor),
      iconTheme: IconThemeData(color: Colors.white), // لون أيقونة الباك
      title: Padding(
        padding: EdgeInsets.only(
            left: titlePaddingLeft.h), // استخدام البادينج المحدد
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
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 32.w),
              onPressed: () => Navigator.pop(context),
            )
          : null, // إذا كانت الخاصية showBackButton غير مفعلة، لا تظهر أيقونة الرجوع
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
