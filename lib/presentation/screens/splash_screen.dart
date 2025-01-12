import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacityText = 0; // البداية ستكون صفر (غير مرئي)
  double _opacityIcon = 0; // البداية ستكون صفر (غير مرئي)

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  // بدء الأنيميشن بعد تأخير
  void _startAnimation() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _opacityText = 1; // النص يظهر بعد 1 ثانية
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _opacityIcon = 1; // الأيقونة تظهر بعد 2 ثانية
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedOpacity(
              opacity: _opacityText,
              duration: const Duration(seconds: 1), // مدة الأنيميشن
              child: Text(
                "Flash",
                style: TextStyle(
                  fontFamily: 'PassionOne',
                  color: Colors.white,
                  fontSize: 110
                      .sp, // استخدام flutter_screenutil لضبط الحجم بناءً على الشاشة
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: _opacityIcon,
              duration: const Duration(seconds: 1), // مدة الأنيميشن
              child: Icon(
                Icons.flash_on,
                size: 110
                    .sp, // استخدام flutter_screenutil لضبط حجم الأيقونة بناءً على الشاشة
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
