import 'package:flash/constants.dart';
import 'package:flash/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onSearchPressed;
  final bool showSearchIcon;
  final double titlePaddingLeft;
  final double rightPadding; // متغير إلزامي
  final bool showBackButton;

  CustomAppBar({
    super.key,
    required this.rightPadding, // اجعله مطلوبًا
    this.onSearchPressed,
    this.showSearchIcon = true,
    this.titlePaddingLeft = 100,
    this.showBackButton = true,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    bool isArabic = currentLocale.languageCode == 'ar';

    return AppBar(
      backgroundColor: const Color(kPrimaryColor),
      iconTheme: const IconThemeData(color: Colors.white),
      title: Padding(
        padding: EdgeInsets.only(
          right: isArabic? rightPadding.h:0.h, // استخدم المتغير الإجباري
          left: isArabic? 0.h.h:titlePaddingLeft.h, // استخدم المتغير الإجباري
        ),
        child: Row(
          children: [
            Text(
              S.of(context).AppBarTitle,
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
          : null,
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
