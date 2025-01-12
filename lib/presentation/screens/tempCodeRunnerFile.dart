import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,  // توسيط العناصر أفقيًا
          crossAxisAlignment: CrossAxisAlignment.center,  // توسيط العناصر عموديًا
          children: [
            // إضافة الخط المخصص للنص
            Text(
              "Flash",
              style: TextStyle(
                fontFamily: 'PassionOne',  // استخدام الخط المخصص
                color: Colors.white,
                fontSize: 90,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.flash_on,
              size: 100,  // حجم الأيقونة
              color: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}
