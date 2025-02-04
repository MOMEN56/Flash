import 'package:flash/presentation/widgets/error_message_widget.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash/constants.dart';
import 'package:flash/presentation/widgets/currency_search_widget.dart';
import 'package:flash/presentation/widgets/custom_app_bar.dart';
import 'package:flash/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flash/data/web_services/currencies_web_services.dart';
import 'package:flash/data/web_services/currency_flag_services.dart';
import 'package:dio/dio.dart';
import 'package:vibration/vibration.dart';

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
  final ScrollController _scrollController =
      ScrollController(); // إضافة ScrollController
  String url = "$baseCurrencyUrl$comparisonCurrency";
  Map<String, bool> favoriteCurrencies = {};

  final CurrenciesWebService _currenciesWebService =
      CurrenciesWebService(dio: Dio());
  final CurrencyFlag _currencyFlag = CurrencyFlag(dio: Dio());

  int _currentIndex = 0;
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
      _listKey.currentState?.insertItem(i);
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

  void _stopSearching() {
    setState(() {
      _isSearching = false;
      _searchTextController.clear();
      addSearchedForCurrencyToSearchedList('');
    });
  }

  @override
  void initState() {
    super.initState();
    fetchRates();
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  // دالة عند الضغط على عملة: تنفذ اهتزازًا، تُعيد ترتيب القائمة وتُحدث العملة للمقارنة،
  // بالإضافة إلى ضبط _isSearching لتصبح false.
  Future<void> _onCurrencyTap(String currency) async {
    // اهتزاز الهاتف
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100);
    }

    setState(() {
      _isSearching = false; // عند الضغط نجعل _isSearching = false
      comparisonCurrency = currency; // تعيين العملة للمقارنة
      url = "$baseCurrencyUrl$comparisonCurrency";

      // إعادة ترتيب القائمة: إزالة العملة ثم إدراجها في البداية
      filteredCurrencyList.remove(currency);
      filteredCurrencyList.insert(0, currency);
    });

    // تمرير الصفحة إلى الأعلى (Animated)
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    fetchRates();
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
              ? ErrorMessageWidget(errorMessage: errorMessage)
              : Column(
                  children: [
                    Expanded(
                      child: AnimatedList(
                        controller: _scrollController,
                        key: _listKey,
                        initialItemCount: filteredCurrencyList.length,
                        itemBuilder: (context, index, animation) {
                          if (index < filteredCurrencyList.length) {
                            final currency = filteredCurrencyList[index];
                            final rate = rates![currency];
                            return GestureDetector(
                              onTap: () => _onCurrencyTap(currency),
                              child: SlideTransition(
                                position: animation.drive(
                                  Tween<Offset>(
                                      begin: const Offset(1, 0),
                                      end: const Offset(0, 0)),
                                ),
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
                                      contentPadding: EdgeInsets.only(left: 4.h),
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
                                            return CachedNetworkImage(
                                              imageUrl: snapshot.data!,
                                              cacheManager: CacheManager(
                                                Config(
                                                  'customCacheKey',
                                                  stalePeriod:
                                                      const Duration(days: 30),
                                                  maxNrOfCacheObjects: 180,
                                                ),
                                              ),
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      CircleAvatar(
                                                radius: 28.h,
                                                backgroundImage: imageProvider,
                                              ),
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            );
                                          } else {
                                            return const Icon(Icons.flag);
                                          }
                                        },
                                      ),
                                      title: Row(
                                        children: [
                                          // اسم العملة
                                          Text(
                                            currency,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          if (currency !=
                                              comparisonCurrency) ...[
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
                                                color: favoriteCurrencies[
                                                            currency] ??
                                                        false
                                                    ? Colors.red
                                                    : Colors.grey,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  favoriteCurrencies[currency] =
                                                      !(favoriteCurrencies[
                                                              currency] ??
                                                          false);
                                                });
                                              },
                                            ),
                                            Icon(Icons.currency_exchange,
                                                size: 22.w),
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
                                            // في حالة العملة المقارنة نعرض أيقونة المفضلة فقط
                                            IconButton(
                                              icon: Icon(
                                                Icons.favorite,
                                                size: 20.w,
                                                color: favoriteCurrencies[
                                                            currency] ??
                                                        false
                                                    ? Colors.red
                                                    : Colors.grey,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  favoriteCurrencies[currency] =
                                                      !(favoriteCurrencies[
                                                              currency] ??
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
                              ),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ),
                    CustomBottomNavigationBar(
                      currentIndex: _currentIndex,
                      onTap: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ],
                ),
    );
  }
}
