import 'package:flash/business_logic/cubit/locale_cubit.dart';
import 'package:flash/constants.dart';
import 'package:flash/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onSearchPressed;
  final bool showSearchIcon;
  final double titlePaddingLeft;
  final double rightPadding;
  final bool showBackButton;
  final bool showLanguageIcon;

  CustomAppBar({
    super.key,
    required this.rightPadding,
    this.onSearchPressed,
    this.showSearchIcon = true,
    this.titlePaddingLeft = 30,
    this.showBackButton = true,
    this.showLanguageIcon = false,
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
          right: isArabic ? rightPadding.h : 0.h,
          left: isArabic ? 20.h : titlePaddingLeft.h,
        ),
        child: Row(
          children: [
            Text(
              S.of(context).AppBarTitle,
              style: TextStyle(
                fontFamily: isArabic ? 'Lalezar' : 'PassionOne',
                color: Colors.white,
                fontSize: isArabic ? 40.sp : 50.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.flash_on, size: 55.w, color: Colors.yellow),
          ],
        ),
      ),
      leading: showLanguageIcon
          ? GestureDetector(
              onTap: () {
                context
                    .read<LocaleCubit>()
                    .toggleLocale(); // تغيير اللغة عند الضغط
              },
              child: Padding(
                padding: EdgeInsets.only(top: 4.w),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.w,
                    vertical: 4.h,
                  ),
                  child: BlocBuilder<LocaleCubit, Locale>(
                    builder: (context, locale) {
                      return Text(
                        S.of(context).current_language,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          : null,
      actions: [
        if (showSearchIcon)
          IconButton(
            icon: Icon(Icons.search,
                color: Colors.white, size: 28.w), // تأكيد الحجم الثابت
            onPressed: onSearchPressed,
          ),
      ],
    );
  }
}
