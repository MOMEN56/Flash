import 'package:flash/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBar({Key? key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(kPrimaryColor),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
          Icon(
            Icons.flash_on,
            size: 55.w,
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}
