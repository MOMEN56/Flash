import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:vibration/vibration.dart';

import 'package:flash/presentation/screens/currency_converter_screen.dart';
import 'package:flash/presentation/widgets/error_message_widget.dart';
import 'package:flash/presentation/widgets/currency_search_widget.dart';
import 'package:flash/presentation/widgets/custom_app_bar.dart';
import 'package:flash/constants.dart';
import 'package:flash/data/web_services/currencies_web_services.dart';
import 'package:flash/data/web_services/currency_flag_services.dart';

class CurrenciesRatesScreen extends StatefulWidget {
  const CurrenciesRatesScreen({super.key});

  @override
  _CurrenciesRatesScreenState createState() => _CurrenciesRatesScreenState();
}

class _CurrenciesRatesScreenState extends State<CurrenciesRatesScreen> {
  int currentIndex = 0;
  Map<String, dynamic>? rates;
  bool isLoading = true;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  String errorMessage = '';
  final List<String> currencyList = [];
  final List<String> filteredCurrencyList = [];
  final ScrollController _scrollController = ScrollController();
  String url = "$baseCurrencyUrl$comparisonCurrency";
  Map<String, bool> favoriteCurrencies = {};
  final CurrenciesWebService _currenciesWebService =
      CurrenciesWebService(dio: Dio());
  final CurrencyFlag _currencyFlag = CurrencyFlag(dio: Dio());
  final CacheManager _cacheManager = CacheManager(Config('customCacheKey',
      stalePeriod: Duration(days: 30), maxNrOfCacheObjects: 180));

  // إضافة متغير لتخزين روابط الأعلام
  Map<String, String?> currencyFlags = {};

  @override
  void initState() {
    super.initState();
    fetchRates();
  }

  Future<void> fetchRates() async {
    try {
      final fetchedRates = await _currenciesWebService.fetchRates(url);
      setState(() {
        rates = fetchedRates;
        isLoading = false;
        currencyList.clear();
        currencyList.addAll(rates!.keys);
        filteredCurrencyList.clear();
        filteredCurrencyList.addAll(currencyList);

        // جلب روابط الأعلام وتخزينها
        _loadFlags();
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load data. Please try again later.';
      });
    }
  }

  // دالة لجلب روابط الأعلام
  Future<void> _loadFlags() async {
    for (var currency in currencyList) {
      final flagUrl = await _currencyFlag.fetchFlagByCurrency(currency);
      setState(() {
        currencyFlags[currency] = flagUrl;
      });
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
    });
  }

  void _stopSearching() {
    setState(() {
      _isSearching = false;
      _searchTextController.clear();
      addSearchedForCurrencyToSearchedList('');
    });
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  Future<void> _onCurrencyTap(String currency) async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100);
    }

    setState(() {
      _isSearching = false;
      comparisonCurrency = currency;
      url = "$baseCurrencyUrl$comparisonCurrency";
      filteredCurrencyList.remove(currency);
      filteredCurrencyList.insert(0, currency);
    });

    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    fetchRates();
  }

  void _onConvertPressed(String currency, double rate) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CurrencyConverterScreen(
          comparisonCurrency: comparisonCurrency,
          selectedCurrency: currency,
          comparisonCurrencyRate: rates![comparisonCurrency].toDouble(),
          selectedCurrencyRate: rate,
          comparisonCurrencyFlagUrl: currencyFlags[comparisonCurrency] ?? "",
          selectedCurrencyFlagUrl: currencyFlags[currency] ?? "",
        ),
      ),
    );
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
          : CustomAppBar(onSearchPressed: _startSearch, showBackButton: false),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? ErrorMessageWidget(errorMessage: errorMessage)
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: filteredCurrencyList.length,
                  itemBuilder: (context, index) {
                    final currency = filteredCurrencyList[index];
                    final rate = rates![currency];

                    return GestureDetector(
                      onTap: () => _onCurrencyTap(currency),
                      child: Container(
                        height: 72.5.h,
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
                            contentPadding: EdgeInsets.only(left: 8.h),
                            leading: currencyFlags.containsKey(currency)
                                ? CachedNetworkImage(
                                    imageUrl: currencyFlags[currency]!,
                                    cacheManager: _cacheManager,
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      radius: 28.h,
                                      backgroundImage: imageProvider,
                                    ),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  )
                                : const Icon(Icons.flag),
                            title: Row(
                              children: [
                                Text(
                                  currency,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (currency != comparisonCurrency) ...[
                                  Spacer(flex: 10),
                                  Text(
                                    rate.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.favorite,
                                      size: 20.w,
                                      color:
                                          favoriteCurrencies[currency] ?? false
                                              ? Colors.red
                                              : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        favoriteCurrencies[currency] =
                                            !(favoriteCurrencies[currency] ??
                                                false);
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.currency_exchange,
                                      size: 22.w,
                                    ),
                                    onPressed: () {
                                      _onConvertPressed(currency, rate);
                                    },
                                  ),
                                  Spacer(),
                                ] else ...[
                                  Spacer(flex: 1),
                                  Text(
                                    'Comparison Currency',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.favorite,
                                      size: 20.w,
                                      color:
                                          favoriteCurrencies[currency] ?? false
                                              ? Colors.red
                                              : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        favoriteCurrencies[currency] =
                                            !(favoriteCurrencies[currency] ??
                                                false);
                                      });
                                    },
                                  ),
                                  Spacer(flex: 1),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}