import 'package:flutter/material.dart';

class LoadingErrorWidget extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;

  const LoadingErrorWidget({
    Key? key,
    required this.isLoading,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator()); // عرض مؤشر التحميل
    } else if (errorMessage != null && errorMessage!.isNotEmpty) {
      return Center(
        child: Text(
          errorMessage!, 
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      ); // عرض رسالة الخطأ
    } else {
      return const SizedBox.shrink(); // في حالة عدم وجود تحميل أو خطأ
    }
  }
}
