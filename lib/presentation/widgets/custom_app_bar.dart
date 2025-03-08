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
    this.titlePaddingLeft = 0,
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
title: Center(
  child: Row(
    mainAxisSize: MainAxisSize.min, 
    children: [
      Text(
        S.of(context).AppBarTitle,
        style: TextStyle(
          fontFamily: isArabic ? 'Lalezar' : 'PassionOne',
          color: Colors.white,
          fontSize:isArabic?MediaQuery.of(context).size.height * 0.045:MediaQuery.of(context).size.height * 0.06,
          fontWeight: FontWeight.bold,
        ),
      ),
      Icon(Icons.flash_on, size: MediaQuery.of(context).size.height * 0.07, color: Colors.yellow),
    ],
  ),
),
      leading: showLanguageIcon
          ? GestureDetector(
              onTap: () {
                context
                    .read<LocaleCubit>()
                    .toggleLocale(); 
              },
              child: Padding(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.015,right: isArabic? MediaQuery.of(context).size.width * 0.03:MediaQuery.of(context).size.width * 0.00,left: isArabic?MediaQuery.of(context).size.width * 0.03 :MediaQuery.of(context).size.width * 0.03),
                child: Container(
                  child: BlocBuilder<LocaleCubit, Locale>(
                    builder: (context, locale) {
                      return Text(
                        S.of(context).current_language,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:MediaQuery.of(context).size.width * 0.035,
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
                color: Colors.white, size: 28.w), 
            onPressed: onSearchPressed,
          ),
      ],
    );
  }
}
