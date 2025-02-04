import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextInfoTextInCryptoInfoScreenWidget extends StatelessWidget {
  final String label;
  final String value;
  final double fontSize;

  const TextInfoTextInCryptoInfoScreenWidget({
    Key? key,
    required this.label,
    required this.value,
    this.fontSize = 15.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              '$value',
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
