import 'package:flash/business_logic/cubit/custom_bottom_navigation_cubit.dart';
import 'package:flash/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flash/constants.dart';
import 'package:flash/presentation/screens/crypto_info_screen.dart';
import 'package:flash/presentation/screens/crypto_rates_screen.dart';
import 'package:flash/presentation/screens/currencies_rates_screen.dart';
import 'package:flash/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash/data/models/cyrpto_model.dart';

class BottomNavigationState extends State<HomeScreen> {
  int currentIndex = 0;
  CryptoModel? selectedCrypto;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const CurrenciesRatesScreen(),
      CryptoRatesScreen(onCryptoSelected: (crypto) {
        setState(() {
          selectedCrypto = crypto;
          currentIndex = 1; // انتقل إلى CryptoRatesScreen
        });
      }),
      if (selectedCrypto != null) CryptoInfoScreen(crypto: selectedCrypto!),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          // تأكد من أن index في نطاق العناصر المتاحة
          setState(() {
            if (index < 0 || index >= screens.length) {
              return; // تجنب تعيين index خارج النطاق
            }
            currentIndex = index;

            // إعادة تعيين العملة المحددة عند الانتقال إلى Currency
            if (index == 0) {
              selectedCrypto = null;
            }
          });
        },
      ),
    );
  }
}
