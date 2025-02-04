import 'package:flash/constants.dart';
import 'package:flash/presentation/screens/crypto_rates_screen.dart';
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
        // استخدام PageRouteBuilder فقط عند الضغط على "crypto"
        if (index == 1) {
          // الانتقال إلى شاشة CryptoRatesScreen باستخدام PageRouteBuilder
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => CryptoRatesScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // تخصيص الحركة بين الشاشات باستخدام SlideTransition
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
          onTap(index); // إذا كان العنصر ليس "crypto"، ننفذ الدالة الأصلية
        }
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(kPrimaryColor), // العودة للون الذي كان مستخدمًا
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money, size: 22),
          label: 'currency',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.currency_bitcoin, size: 22),
          label: 'crypto',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/images/img.icons8.png"),
            size: 22,
          ),
          label: 'metals',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite, size: 22),
          label: 'favorite',
        ),
      ],
    );
  }
}
