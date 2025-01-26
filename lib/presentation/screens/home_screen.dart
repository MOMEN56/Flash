import 'package:flash/constants.dart';
import 'package:flash/data/web_services/currencies_web_services.dart';
import 'package:flash/data/web_services/currency_flag_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:flash/presentation/widgets/custom_app_bar.dart'; // تأكد من استيراد AppBar الخاص بك

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? rates;
  bool isLoading = true;
  String errorMessage = '';
  final List<String> currencyList = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  final CurrenciesWebService _currenciesWebService =
      CurrenciesWebService(dio: Dio());
  final CurrencyFlag _currencyFlag = CurrencyFlag(dio: Dio());

  // جلب البيانات من الـ API
  Future<void> fetchRates() async {
    try {
      final fetchedRates = await _currenciesWebService.fetchRates();
      setState(() {
        rates = fetchedRates;
        isLoading = false;
        currencyList.clear(); // مسح القائمة القديمة
        currencyList.addAll(rates!.keys); // إضافة العملات الجديدة للقائمة
        _insertItems();
      });
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred: $e';
        isLoading = false;
      });
    }
  }

  void _insertItems() {
    for (int i = 0; i < currencyList.length; i++) {
      _listKey.currentState?.insertItem(i);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRates(); // جلب البيانات عند تحميل الشاشة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // إعادة إضافة الـ AppBar كما في الكود الأصلي
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // مؤشر تحميل أثناء جلب البيانات
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage)) // في حالة حدوث خطأ
              : Column(
                  children: [
                    Expanded(
                      child: AnimatedList(
                        key: _listKey,
                        initialItemCount: currencyList.length,
                        itemBuilder: (context, index, animation) {
                          final currency = currencyList[index];
                          final rate = rates![currency];

                          return SlideTransition(
                            position: animation.drive(Tween<Offset>(
                                begin: const Offset(1, 0),
                                end: const Offset(0, 0))),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.h, horizontal: 16.w),
                              decoration: BoxDecoration(
                                color: Color(0xFF5d6d7e),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: FutureBuilder<String?>(
                                  future: _currencyFlag.fetchFlagByCurrency(currency),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return const Icon(Icons.error); // في حالة حدوث خطأ في تحميل العلم
                                    } else if (snapshot.hasData) {
                                      return CircleAvatar(
                                        backgroundImage: NetworkImage(snapshot.data!),
                                      );
                                    } else {
                                      return const Icon(Icons.flag); // في حالة عدم وجود علم
                                    }
                                  },
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      currency, // اسم العملة
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      rate.toString(), // سعر العملة
                                      style: TextStyle(
                                        color: const Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
