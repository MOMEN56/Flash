import 'package:flash/presentation/widgets/custom_app_bar.dart';
import 'package:flash/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyConverterScreen extends StatefulWidget {
  final String comparisonCurrency;
  final String selectedCurrency;
  final double comparisonRate;
  final double selectedRate;

  const CurrencyConverterScreen({
    super.key,
    required this.comparisonCurrency,
    required this.selectedCurrency,
    required this.comparisonRate,
    required this.selectedRate,
  });

  @override
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  bool isSwapped = false; // Flag to check if the containers have been swapped

  // بناء الكونتينر للعملة
  Widget buildCurrencyContainer(String currencyName, double rate) {
    return Container(
      height: 200.h,
      margin: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: Color(0xFF5d6d7e),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              currencyName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$rate',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showSearchIcon: false, titlePaddingLeft: 28.h),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: Stack(
          children: [
            // الكونتينر الأول (يتم تحريكه بين الأعلى والأسفل مع مسافة)
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              top: isSwapped ? 320.h : 0, // المسافة بين الكونتينرات
              left: 12.w,
              right: 12.w,
              child: buildCurrencyContainer(
                widget.comparisonCurrency,
                widget.comparisonRate,
              ),
            ),

            // الأيقونة بين الكونتينرين
            Center(
              child: IconButton(
                icon: Icon(
                  Icons.swap_vert,
                  size: 50.w,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isSwapped = !isSwapped; // تبديل حالة الكونتينر
                  });
                },
              ),
            ),

            // الكونتينر الثاني (يتم تحريكه بين الأعلى والأسفل مع مسافة)
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              top: isSwapped ? 0 : 320.h, // المسافة بين الكونتينرات
              left: 12.w,
              right: 12.w,
              child: buildCurrencyContainer(
                widget.selectedCurrency,
                widget.selectedRate,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context); // Go back when the first item is tapped
          }
        },
      ),
    );
  }
}
