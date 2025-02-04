import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flash/constants.dart';  // Ensure the constants file is imported

class CurrencySearchWidget extends StatelessWidget {
  final TextEditingController searchTextController;
  final Function(String) addSearchedForCurrencyToSearchedList;
  final VoidCallback onBackPressed;

  const CurrencySearchWidget({
    super.key,
    required this.searchTextController,
    required this.addSearchedForCurrencyToSearchedList,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(kPrimaryColor),  // Customize your primary color
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: onBackPressed,
      ),
      title: TextField(
        controller: searchTextController,
        onChanged: addSearchedForCurrencyToSearchedList,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.sp,
        ),
        decoration: InputDecoration(
          hintText: "Search currencies",
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
