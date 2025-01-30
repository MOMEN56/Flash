import 'package:flash/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      backgroundColor: Color(kPrimaryColor), // يمكنك تغيير اللون هنا
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: onBackPressed,
      ),
      title: TextField(
        controller: searchTextController,
        onChanged: addSearchedForCurrencyToSearchedList,
        style: TextStyle(
          color: Colors.white, // اللون الأبيض للنص
          fontSize: 18.sp, // حجم الخط للنص المكتوب
        ),
        decoration: InputDecoration(
          hintText: "Search currencies",
          hintStyle: TextStyle(
            color: Colors.white, // تغيير اللون إلى الأبيض
            fontSize: 18.sp, // تغيير حجم الخط
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
