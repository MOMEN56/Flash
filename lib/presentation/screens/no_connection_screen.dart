import 'package:flash/presentation/widgets/custom_app_bar.dart';
import 'package:flash/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class NoConnectionScreen extends StatefulWidget {
  @override
  _NoConnectionScreenState createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
  int _currentIndex = 0; // حفظ حالة العنصر المحدد في الشريط السفلي

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onSearchPressed: () {
          // يمكنك إضافة الكود هنا لعمل شيء عند الضغط على زر البحث إذا كنت تريد
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/undraw_signal-searching_yod3__1_-removebg-preview.png'),
            // الصورة التي توضح عدم الاتصال
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex, // تم تمرير currentIndex هنا
        onTap: (index) {
          setState(() {
            _currentIndex = index; // تحديث قيمة currentIndex
          });
        },
      ),
    );
  }
}
