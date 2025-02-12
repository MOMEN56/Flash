import 'package:flash/crypto_translations.dart';
import 'package:flash/data/models/currency_converter_model.dart';
import 'package:flash/generated/l10n.dart';
import 'package:flash/presentation/screens/crypto_rates_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash/presentation/widgets/custom_app_bar.dart';
import 'package:flash/presentation/widgets/custom_bottom_navigation_bar.dart'; // Import here
import 'package:flash/data/web_services/currency_flag_web_services.dart';

class CurrencyConverterScreen extends StatefulWidget {
  final CurrencyConverterModel model;

  const CurrencyConverterScreen({super.key, required this.model});

  @override
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  bool isSwapped = false;
  final TextEditingController _amountController = TextEditingController();
  double result = 1.0;
  double temp = 0.0; // Temporary variable to store the swapped value

  void _swapCurrencies() {
    setState(() {
      // Swap only the rates using temp variable
      // Toggle the swap flag
      isSwapped = !isSwapped;
      result = 0.0;
      _amountController.clear();
    });
  }

  void _calculateResult() {
    double enteredAmount = double.tryParse(_amountController.text) ?? 0.0;
    setState(() {
      result = isSwapped
          ? enteredAmount * widget.model.comparisonCurrencyRate/ widget.model.selectedCurrencyRate
          : enteredAmount * widget.model.selectedCurrencyRate;
    });
  }

Widget buildCurrencyContainer(
  String currencyCode,
  double rate,
  String flagUrl,
  bool isComparisonCurrency,
  double heightRatio,
) {
  String translatedCurrencyName = getTranslatedCurrencyName(currencyCode, Localizations.localeOf(context));
  
  // تحديد إذا كانت اللغة هي العربية
  Locale currentLocale = Localizations.localeOf(context);
  bool isArabic = currentLocale.languageCode == 'ar';

  return Container(
    height: 200.h * heightRatio,
    margin: EdgeInsets.symmetric(vertical: 15.h),
    decoration: BoxDecoration(
      color: const Color(0xFF5d6d7e),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: flagUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 3.0,
                ),
              ),
              child: CircleAvatar(
                radius: 40.h,
                backgroundImage: imageProvider,
              ),
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          SizedBox(width: 8.w),
          Text(
            translatedCurrencyName,
            style: TextStyle(
              color: Colors.black,
              fontSize: isArabic ? 12.sp : (translatedCurrencyName.length > 5 ? 14.sp : 20.sp), // هنا قمنا بتحديد حجم الخط حسب اللغة
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          if (isComparisonCurrency)
            !isSwapped
                ? SizedBox(
                    width: isArabic? 100.h:130.h,
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: S.of(context).Amount,
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: const Color(0xFF5d6d7e),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.black,
                      ),
                      onChanged: (value) {
                        _calculateResult();
                      },
                    ),
                  )
                : Text(
                    result.toStringAsFixed(2).length > 12
                        ? "${result.toStringAsFixed(2).substring(0, 10)}..."
                        : result.toStringAsFixed(2),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: result.toStringAsFixed(2).length > 7
                          ? 14.sp
                          : 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          if (!isComparisonCurrency)
            isSwapped
                ? SizedBox(
                    width: isArabic? 100.h:130.h,
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: S.of(context).Amount,
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: const Color(0xFF5d6d7e),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.black,
                      ),
                      onChanged: (value) {
                        _calculateResult();
                      },
                    ),
                  )
                : Text(
                    result.toStringAsFixed(2).length > 12
                        ? "${result.toStringAsFixed(2).substring(0, 10)}..."
                        : result.toStringAsFixed(2),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: result.toStringAsFixed(2).length > 7
                          ? 14.sp
                          : 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )
        ],
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final keyboardHeight = mediaQuery.viewInsets.bottom;
    final availableHeight = screenHeight - keyboardHeight;
    final heightRatio = availableHeight / screenHeight;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(showSearchIcon: false, titlePaddingLeft: 30.h, rightPadding: 50,),
      body: Padding(
        padding:
            EdgeInsets.only(right: 12.h, left: 12.h, bottom: 50, top: 10.h),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: isSwapped ? 350.h * heightRatio : 0,
              left: 12.w,
              right: 12.w,
              child: buildCurrencyContainer(
                widget.model.comparisonCurrency,
                widget.model.comparisonCurrencyRate,
                widget.model.comparisonCurrencyFlagUrl,
                true,
                heightRatio,
              ),
            ),
            Center(
              child: IconButton(
                icon: Icon(
                  Icons.swap_vert,
                  size: 50.w,
                  color: Colors.white,
                ),
                onPressed: _swapCurrencies, // Call the swap method
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: isSwapped ? 0 : 350.h * heightRatio,
              left: 12.w,
              right: 12.w,
              child: buildCurrencyContainer(
                widget.model.selectedCurrency,
                widget.model.selectedCurrencyRate,
                widget.model.selectedCurrencyFlagUrl,
                false,
                heightRatio,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
