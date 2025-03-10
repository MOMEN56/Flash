import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String errorMessage; 

  const ErrorMessageWidget({super.key, required this.errorMessage}); 

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.error,
            color: Colors.red,
            size: 36.w,
          ),
        ],
      ),
    );
  }
}
