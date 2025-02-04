import 'package:flash/presentation/screens/crypto_info_screen.dart';
import 'package:flash/presentation/screens/crypto_rates_screen.dart';
import 'package:flash/presentation/screens/currencies_rates_screen.dart';
import 'package:flash/presentation/screens/no_connection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash/presentation/screens/home_screen.dart';
import 'package:flash/presentation/screens/splash_screen.dart';
import 'package:flash/data/models/cyrpto_model.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/homeScreen':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/NoConnectionScreen':
        return MaterialPageRoute(builder: (_) => NoConnectionScreen());
      case '/CurrenciesRatesScreen':
        return MaterialPageRoute(builder: (_) => CurrenciesRatesScreen());
      case '/CryptoRatesScreen':
        return MaterialPageRoute(builder: (_) => CryptoRatesScreen());
      case '/CryptoInfoScreen':
        if (settings.arguments is CryptoModel) {
          final crypto = settings.arguments as CryptoModel;
          return MaterialPageRoute(
            builder: (_) => CryptoInfoScreen(crypto: crypto),
          );
        }
    }
  }
}
