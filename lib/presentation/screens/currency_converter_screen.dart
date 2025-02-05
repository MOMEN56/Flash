import 'package:dio/dio.dart';
import 'package:flash/presentation/widgets/custom_app_bar.dart';
import 'package:flash/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flash/data/web_services/currency_flag_services.dart'; // Import CurrencyFlag service

class CurrencyConverterScreen extends StatefulWidget {
  final String comparisonCurrency;
  final String selectedCurrency;
  final double comparisonCurrencyRate;
  final double selectedCurrencyRate;
  final String comparisonCurrencyFlagUrl;
  final String selectedCurrencyFlagUrl;

  const CurrencyConverterScreen({
    super.key,
    required this.comparisonCurrency,
    required this.selectedCurrency,
    required this.comparisonCurrencyRate,
    required this.selectedCurrencyRate,
    required this.comparisonCurrencyFlagUrl,
    required this.selectedCurrencyFlagUrl,
  });

  @override
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  bool isSwapped = false;
  final CurrencyFlag _currencyFlag = CurrencyFlag(dio: Dio());
  final TextEditingController _amountController = TextEditingController();
  double result = 1.0;

  @override
  void initState() {
    super.initState();
  }

  Future<String?> _fetchFlag(String currencyCode) async {
    return await _currencyFlag.fetchFlagByCurrency(currencyCode);
  }

  void _calculateResult() {
    double enteredAmount = double.tryParse(_amountController.text) ?? 0.0;
    setState(() {
      result = enteredAmount * widget.selectedCurrencyRate;
    });
  }

  Widget buildCurrencyContainer(
    String currencyName,
    double rate,
    String flagUrl,
    bool isComparisonCurrency,
    double heightRatio,
  ) {
    return Container(
      height: 220.h * heightRatio,
      margin: EdgeInsets.symmetric(vertical: 15.h),
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
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder<String?>(
              future: _fetchFlag(currencyName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Icon(Icons.error);
                } else if (snapshot.hasData) {
                  return CircleAvatar(
                    radius: 40.h,
                    backgroundImage: NetworkImage(snapshot.data!),
                    backgroundColor: Colors.transparent,
                  );
                } else {
                  return const Icon(Icons.flag);
                }
              },
            ),
            SizedBox(width: 8.w),
            Text(
              currencyName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            if (isComparisonCurrency)
              !isSwapped
                  ? Container(
                      width: 120.w,
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Amount",
                          hintStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Color(0xFF5d6d7e),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
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
                      '${result.toStringAsFixed(2).length > 12 ? result.toStringAsFixed(2).substring(0, 10) + "..." : result.toStringAsFixed(2)}',
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
                  ? Container(
                      width: 120.w,
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Amount",
                          hintStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Color(0xFF5d6d7e),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          _calculateResult();
                        },
                      ),
                    )
                  : Text(
                      '${result.toStringAsFixed(2).length > 12 ? result.toStringAsFixed(2).substring(0, 10) + "..." : result.toStringAsFixed(2)}',
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
      appBar: CustomAppBar(showSearchIcon: false, titlePaddingLeft: 28.h),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              top: isSwapped ? 320.h * heightRatio : 0,
              left: 12.w,
              right: 12.w,
              child: buildCurrencyContainer(
                widget.comparisonCurrency,
                widget.comparisonCurrencyRate,
                widget.comparisonCurrencyFlagUrl,
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
                onPressed: () {
                  setState(() {
                    isSwapped = !isSwapped;
                  });
                },
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              top: isSwapped ? 0 : 320.h * heightRatio,
              left: 12.w,
              right: 12.w,
              child: buildCurrencyContainer(
                widget.selectedCurrency,
                widget.selectedCurrencyRate,
                widget.selectedCurrencyFlagUrl,
                false,
                heightRatio,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
