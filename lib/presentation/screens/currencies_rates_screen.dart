import 'package:dio/dio.dart';
import 'package:flash/crypto_translations.dart';
import 'package:flash/data/models/currency_converter_model.dart';
import 'package:flash/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:vibration/vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flash/presentation/screens/currency_converter_screen.dart';
import 'package:flash/presentation/widgets/error_message_widget.dart';
import 'package:flash/presentation/widgets/search_widget.dart';
import 'package:flash/presentation/widgets/custom_app_bar.dart';
import 'package:flash/constants.dart';
import 'package:flash/data/web_services/currencies_web_services.dart';
import 'package:flash/data/web_services/currency_flag_web_services.dart';

class CurrenciesRatesScreen extends StatefulWidget {
  const CurrenciesRatesScreen({super.key});

  @override
  _CurrenciesRatesScreenState createState() => _CurrenciesRatesScreenState();
}

class _CurrenciesRatesScreenState extends State<CurrenciesRatesScreen> {
  String comparisonCurrency = "USD"; // العملة الافتراضية
  int currentIndex = 0;
  Map<String, dynamic>? rates;
  bool isLoading = true;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  String errorMessage = '';
  final List<String> currencyList = [];
  final List<String> filteredCurrencyList = [];
  final ScrollController _scrollController = ScrollController();
  Map<String, bool> favoriteCurrencies = {};
  final CurrenciesWebService _currenciesWebService =
      CurrenciesWebService(dio: Dio());
  final CurrencyFlag _currencyFlag = CurrencyFlag(dio: Dio());
  final CacheManager _cacheManager = CacheManager(Config('customCacheKey',
      stalePeriod: Duration(days: 30), maxNrOfCacheObjects: 200));

  Map<String, String?> currencyFlags = {};

  @override
  void initState() {
    super.initState();
    _initializeCurrencies();
  }

  Future<void> _initializeCurrencies() async {
    await _loadDefaultCurrency();
    fetchRates();
  }

  Future<void> _loadDefaultCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      comparisonCurrency = prefs.getString('comparisonCurrency') ?? "USD";
    });
  }

  Future<void> _saveComparisonCurrency(String currency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('comparisonCurrency', currency);
  }

  Future<void> fetchRates() async {
    final url = "$baseCurrencyUrl$comparisonCurrency";
    try {
      final fetchedRates = await _currenciesWebService.fetchRates(url);
      setState(() {
        rates = fetchedRates;
        isLoading = false;
        currencyList.clear();
        currencyList.addAll(rates!.keys);
        filteredCurrencyList.clear();
        filteredCurrencyList.addAll(currencyList);
        _loadFlags();
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load data. Please try again later.';
      });
    }
  }

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
      errorMessage =
          filteredCurrencyList.isEmpty ? S.of(context).NoCurrenciesFound : '';
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
      filteredCurrencyList.remove(currency);
      filteredCurrencyList.insert(0, currency);
    });

    _saveComparisonCurrency(currency); // تخزين العملة المختارة

    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    fetchRates();
  }

  void _onConvertPressed(String currency, double rate) {
    CurrencyConverterModel model = CurrencyConverterModel(
      comparisonCurrency: comparisonCurrency,
      selectedCurrency: currency,
      comparisonCurrencyRate: rates![comparisonCurrency].toDouble(),
      selectedCurrencyRate: rate,
      comparisonCurrencyFlagUrl: currencyFlags[comparisonCurrency] ?? "",
      selectedCurrencyFlagUrl: currencyFlags[currency] ?? "",
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CurrencyConverterScreen(
          model: model,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    bool isArabic = currentLocale.languageCode == 'ar';

    return Scaffold(
      appBar: _isSearching
          ? PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: CurrencySearchWidget(
                searchHint: S.of(context).SearchForACurrency,
                searchTextController: _searchTextController,
                addSearchedForCurrencyToSearchedList:
                    addSearchedForCurrencyToSearchedList,
                onBackPressed: _stopSearching,
              ),
            )
          : CustomAppBar(
              onSearchPressed: _startSearch,
              showBackButton: false,
              rightPadding: 50,
              showLanguageIcon: true),
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
                    final translatedCurrency = getTranslatedCurrencyName(
                        currency, Localizations.localeOf(context));

                    return GestureDetector(
                      onTap: () => _onCurrencyTap(currency),
                      child: Container(
                        height: 72.5.h,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 12.h),
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
                          padding: EdgeInsets.symmetric(horizontal: 8.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  currencyFlags.containsKey(currency)
                                      ? CachedNetworkImage(
                                          imageUrl: currencyFlags[currency]!,
                                          cacheManager: _cacheManager,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: CircleAvatar(
                                              radius: 28.h,
                                              backgroundImage: imageProvider,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        )
                                      : const Icon(
                                          Icons.flag,
                                          color: Colors.grey,
                                        ),
                                  SizedBox(width: 8.h),
                                  Text(
                                    translatedCurrency,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    currency == comparisonCurrency
                                        ? S.of(context).comparison_currency
                                        : rate.toString(),
                                    style: TextStyle(
                                      color: currency == comparisonCurrency
                                          ? Colors.grey
                                          : Colors.black,
                                      fontSize: isArabic
                                          ? currency == comparisonCurrency
                                              ? 16.sp
                                              : 16.sp
                                          : currency == comparisonCurrency
                                              ? 14.sp
                                              : 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (currency != comparisonCurrency)
                                    IconButton(
                                      icon: Icon(
                                        Icons.currency_exchange,
                                        size: 22.w,
                                      ),
                                      onPressed: () {
                                        _onConvertPressed(currency, rate);
                                      },
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
