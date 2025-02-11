import 'package:flash/presentation/widgets/custom_app_bar.dart';
import 'package:flash/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoConnectionScreen extends StatefulWidget {
  const NoConnectionScreen({super.key});

  @override
  _NoConnectionScreenState createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showSearchIcon: false,titlePaddingLeft: 0.h,showBackButton: false, rightPadding: 100,),
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
