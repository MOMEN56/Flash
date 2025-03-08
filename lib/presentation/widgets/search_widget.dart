import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flash/constants.dart'; 

class CurrencySearchWidget extends StatelessWidget {
  final TextEditingController searchTextController;
  final Function(String) addSearchedForCurrencyToSearchedList;
  final VoidCallback onBackPressed;
  final String searchHint; 

  const CurrencySearchWidget({
    super.key,
    required this.searchTextController,
    required this.addSearchedForCurrencyToSearchedList,
    required this.onBackPressed,
    required this.searchHint, 
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(kPrimaryColor),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: onBackPressed,
      ),
      title: TextField(
        controller: searchTextController,
        onChanged: addSearchedForCurrencyToSearchedList,
        style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.height * 0.022),
        decoration: InputDecoration(
          hintText: searchHint, 
          hintStyle: TextStyle(
            color: Colors.white70,
            fontSize: MediaQuery.of(context).size.height * 0.02,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
