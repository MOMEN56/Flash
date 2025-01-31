import 'package:flash/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class NoConnectionScreen extends StatelessWidget {
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
    );
  }
}
