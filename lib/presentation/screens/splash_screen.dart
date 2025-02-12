import 'package:flash/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// إضافة AppRouter

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacityText = 0;
  double _opacityIcon = 0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _opacityText = 1;
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _opacityIcon = 1;
      });
    });

    // التوجيه بعد 3 ثواني
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
          context, '/homeScreen'); // التوجيه إلى HomeScreen
    });
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    bool isArabic = currentLocale.languageCode == 'ar';

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _opacityText,
              duration: const Duration(seconds: 1),
              child: Text(
                S.of(context).AppBarTitle,
                style: TextStyle(
                  fontFamily: isArabic ? 'Lalezar' : 'PassionOne',
                  color: Colors.white,
                  fontSize: 80.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: _opacityIcon,
              duration: const Duration(seconds: 1),
              child: Icon(
                Icons.flash_on,
                size: 95.w,
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
