import 'package:flash/constants.dart';
import 'package:flash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const Flash());
}

class Flash extends StatelessWidget {
  const Flash({super.key});

  @override
  Widget build(BuildContext context) {
    // تهيئة ScreenUtilInit قبل بناء واجهة المستخدم
    return ScreenUtilInit(
      designSize:const Size(360, 760), // حجم التصميم الأساسي (مثال: iPhone 8)
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData().copyWith(
            scaffoldBackgroundColor: const Color(kPrimaryColor),
          ),
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
