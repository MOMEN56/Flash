import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flash/presentation/widgets/currency_search_widget.dart';
import 'package:flash/data/web_services/currencies_web_services.dart';
import 'package:flash/data/web_services/currency_flag_services.dart';
import 'package:dio/dio.dart';
import 'package:flash/presentation/widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? rates;
  bool isLoading = true;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  String errorMessage = '';
  final List<String> currencyList = [];
  final List<String> filteredCurrencyList = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  final CurrenciesWebService _currenciesWebService =
      CurrenciesWebService(dio: Dio());
  final CurrencyFlag _currencyFlag = CurrencyFlag(dio: Dio());

  Future<void> fetchRates() async {
    try {
      final fetchedRates = await _currenciesWebService.fetchRates();
      setState(() {
        rates = fetchedRates;
        isLoading = false;
        currencyList.clear();
        currencyList.addAll(rates!.keys);
        filteredCurrencyList.clear();  // تأكد من إضافة جميع العملات للفلترة
        filteredCurrencyList.addAll(currencyList);
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
    // تأكد من أن الفهرس ضمن نطاق القوائم
    for (int i = 0; i < filteredCurrencyList.length; i++) {
      if (i < filteredCurrencyList.length) {
        _listKey.currentState?.insertItem(i);
      }
    }
  }

  void addSearchedForCurrencyToSearchedList(String searchedCurrency) {
    setState(() {
      if (searchedCurrency.isEmpty) {
        filteredCurrencyList.clear();
        filteredCurrencyList.addAll(currencyList);
      } else {
        filteredCurrencyList.clear();
        filteredCurrencyList.addAll(currencyList
            .where((currency) =>
                currency.toLowerCase().startsWith(searchedCurrency.toLowerCase()))
            .toList());
      }
      errorMessage = filteredCurrencyList.isEmpty
          ? 'No currencies found for your search!'
          : '';
      _insertItems();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchRates();  // استدعاء البيانات فورًا عند بدء الصفحة
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    setState(() {
      _isSearching = false;
      _searchTextController.clear();
      addSearchedForCurrencyToSearchedList('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isSearching
          ? PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: CurrencySearchWidget(
                searchTextController: _searchTextController,
                addSearchedForCurrencyToSearchedList:
                    addSearchedForCurrencyToSearchedList,
                onBackPressed: _stopSearching,
              ),
            )
          : CustomAppBar(onSearchPressed: _startSearch),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error,
                        color: Colors.white,
                        size: 32.sp, // حجم الأيقونة
                      ),
                      SizedBox(width: 8.w), // مساحة بين الأيقونة والنص
                      Text(
                        errorMessage,
                        style: TextStyle(
                          color: Colors.white, // اللون الأبيض
                          fontSize: 24.sp, // حجم الخط أكبر
                          fontWeight: FontWeight.bold, // جعل الخط عريضًا
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: AnimatedList(
                        key: _listKey,
                        initialItemCount: filteredCurrencyList.length,
                        itemBuilder: (context, index, animation) {
                          // تأكد من أن الفهرس ضمن نطاق القائمة
                          if (index < filteredCurrencyList.length) {
                            final currency = filteredCurrencyList[index];
                            final rate = rates![currency];

                            return SlideTransition(
                              position: animation.drive(Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: const Offset(0, 0))),
                              child: Container(
                                height: 72.h,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 12.w),
                                decoration: BoxDecoration(
                                  color: Color(0xFF5d6d7e),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: ListTile(
                                    leading: FutureBuilder<String?>(
                                      future: _currencyFlag
                                          .fetchFlagByCurrency(currency),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return const Icon(Icons.error);
                                        } else if (snapshot.hasData) {
                                          return CircleAvatar(
                                            radius: 32,
                                            backgroundImage:
                                                NetworkImage(snapshot.data!),
                                          );
                                        } else {
                                          return const Icon(Icons.flag);
                                        }
                                      },
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          currency,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          rate.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
