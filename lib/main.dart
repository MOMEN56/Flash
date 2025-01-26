import 'package:dio/dio.dart';
import 'package:flash/business_logic/cubit/currencies_cubit.dart';
import 'package:flash/constants.dart';
import 'package:flash/data/web_services/currencies_web_services.dart';
import 'package:flash/presentation/screens/home_screen.dart';
import 'package:flash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // استيراد BlocProvider
import 'package:flash/app_router.dart';

void main() {
  runApp(const Flash());
}

class Flash extends StatelessWidget {
  const Flash({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 760),
      minTextAdapt: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => CurrenciesCubit(CurrenciesWebService(dio: Dio())),
          child: MaterialApp(
            theme: ThemeData().copyWith(
              scaffoldBackgroundColor: const Color(kPrimaryColor),
            ),
            onGenerateRoute: AppRouter().generateRoute, // ربط التوجيه مع AppRouter
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
