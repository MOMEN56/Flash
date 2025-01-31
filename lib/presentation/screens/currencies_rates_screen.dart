import 'package:flash/presentation/widgets/currency_search_widget.dart';
import 'package:flash/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flash/data/web_services/currencies_web_services.dart';
import 'package:flash/data/web_services/currency_flag_services.dart';
import 'package:dio/dio.dart';

class CurrenciesRatesScreen extends StatefulWidget {
  const CurrenciesRatesScreen({super.key});

  @override
  _CurrenciesRatesScreenState createState() => _CurrenciesRatesScreenState();
}

class _CurrenciesRatesScreenState extends State<CurrenciesRatesScreen> {
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
        filteredCurrencyList.clear();
        filteredCurrencyList.addAll(currencyList);
        _insertItems();
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _insertItems() {
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
            .where((currency) => currency
                .toLowerCase()
                .startsWith(searchedCurrency.toLowerCase()))
            .toList());
      }
      errorMessage = filteredCurrencyList.isEmpty ? 'No currencies found' : '';
      _insertItems();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchRates(); // استدعاء البيانات فورًا عند بدء الصفحة
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
                      Text(
                        errorMessage,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 36.sp,
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
                                  boxShadow: const [
                                    BoxShadow(
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
