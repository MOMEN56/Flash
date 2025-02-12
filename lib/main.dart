import 'package:dio/dio.dart';
import 'package:flash/business_logic/cubit/currencies_cubit.dart';
import 'package:flash/business_logic/cubit/locale_cubit.dart';
import 'package:flash/constants.dart';
import 'package:flash/data/web_services/currencies_web_services.dart';
import 'package:flash/presentation/screens/home_screen.dart';
import 'package:flash/presentation/screens/no_connection_screen.dart';
import 'package:flash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flash/app_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flash/generated/l10n.dart';

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
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => CurrenciesCubit(CurrenciesWebService(dio: Dio()))),
            BlocProvider(create: (context) => LocaleCubit()), // ✅ إضافة LocaleCubit
          ],
          child: BlocBuilder<LocaleCubit, Locale>( // ✅ ربط الحالة بالتطبيق
            builder: (context, locale) {
              return MaterialApp(
                theme: ThemeData().copyWith(
                  scaffoldBackgroundColor: const Color(kPrimaryColor),
                ),
                locale: locale, // ✅ جعل اللغة ديناميكية
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', 'US'),
                  Locale('ar', 'AE'),
                ],
                onGenerateRoute: AppRouter().generateRoute,
                home: HomeScreen(),
                debugShowCheckedModeBanner: false,
              );
            },
          ),
        );
      },
    );
  }
}
