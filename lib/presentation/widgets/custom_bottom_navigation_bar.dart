import 'package:flash/constants.dart';
import 'package:flash/presentation/screens/crypto_rates_screen.dart';
import 'package:flash/presentation/screens/currencies_rates_screen.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        // الانتقال إلى CurrenciesRatesScreen عند الضغط على "currency"
        if (index == 0) {
          // الانتقال إلى شاشة CurrenciesRatesScreen باستخدام PageRouteBuilder
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  CurrenciesRatesScreen(), // قم بتبديل هذا مع شاشة العملات
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0); // الانتقال من الجهة اليمنى
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child); // حركة انزلاقية
              },
            ),
          );
        } else if (index == 1) {
          // الانتقال إلى شاشة CryptoRatesScreen باستخدام PageRouteBuilder
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  CryptoRatesScreen(), // الشاشة الخاصة بالـ Crypto
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0); // الانتقال من الجهة اليمنى
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child); // حركة انزلاقية
              },
            ),
          );
        } else {
          onTap(index); // إذا كان العنصر ليس "currency" أو "crypto"، ننفذ الدالة الأصلية
        }
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(kPrimaryColor), // العودة للون الذي كان مستخدمًا
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      selectedFontSize: 12, // تقليل حجم الخط للـ selected item
      unselectedFontSize: 12, // تقليل حجم الخط للـ unselected item
      iconSize: 20, // تقليل حجم الأيقونات
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money, size: 20), // حجم الأيقونة
          label: 'currency',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.currency_bitcoin, size: 20), // حجم الأيقونة
          label: 'crypto',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/images/img.icons8.png"),
            size: 20, // حجم الأيقونة
          ),
          label: 'metals',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite, size: 20), // حجم الأيقونة
          label: 'favorite',
        ),
      ],
    );
  }
}
