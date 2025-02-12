import 'package:flash/crypto_translations.dart';
import 'package:flash/data/models/matal_model.dart';
import 'package:flash/data/web_services/metal_web_services.dart';
import 'package:flash/generated/l10n.dart';
import 'package:flash/presentation/widgets/comparison_unit_container.dart';
import 'package:flash/presentation/widgets/custom_app_bar.dart';
import 'package:flash/presentation/widgets/error_message_widget.dart';
import 'package:flash/presentation/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flash/constants.dart'; // Ensure the constants file is imported
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flash/business_logic/cubit/locale_cubit.dart';

class MetalRatesScreen extends StatefulWidget {
  @override
  _MetalRatesScreenState createState() => _MetalRatesScreenState();
}

class _MetalRatesScreenState extends State<MetalRatesScreen> {
  late Future<MetalModel> futureMetalPrices;
  bool _isSearching = false;
  final TextEditingController _searchTextController = TextEditingController();
  List<String> metalList = [];
  List<String> filteredMetalList = [];
  String errorMessage = '';
  Map<String, bool> favoriteMetals = {};
  Locale? _currentLocale;

  @override
  void initState() {
    super.initState();
    futureMetalPrices = WebService().fetchMetalPrices(unit);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_currentLocale == null) {
      _currentLocale = Localizations.localeOf(context);
      fetchMetalPrices();
    }
  }

  Future<void> fetchMetalPrices() async {
    try {
      final metalModel = await WebService().fetchMetalPrices(unit);
      if (!mounted) return;

      setState(() {
        final prices = metalModel.getMetalPrices();
        metalList = prices.keys
            .map((metal) => getTranslatedMetalName(metal, _currentLocale!))
            .toList();
        filteredMetalList.clear();
        filteredMetalList.addAll(metalList);
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = 'Error fetching data';
      });
    }
  }

  void addSearchedForMetalToSearchedList(String searchedMetal) {
    setState(() {
      if (searchedMetal.isEmpty) {
        filteredMetalList.clear();
        filteredMetalList.addAll(metalList);
        errorMessage = '';
      } else {
        filteredMetalList.clear();
        filteredMetalList.addAll(
          metalList
              .where(
                (metal) =>
                    metal.toLowerCase().contains(searchedMetal.toLowerCase()),
              )
              .toList(),
        );
        errorMessage =
            filteredMetalList.isEmpty ? S.of(context).NoMetalsFound : '';
      }
    });
  }

  void _stopSearching() {
    setState(() {
      _isSearching = false;
      _searchTextController.clear();
      addSearchedForMetalToSearchedList('');
    });
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    bool isArabic = currentLocale.languageCode == 'ar';

    return BlocListener<LocaleCubit, Locale>(
      listener: (context, locale) {
        if (_currentLocale != locale) {
          _currentLocale = locale;
          fetchMetalPrices(); // إعادة جلب البيانات عند تغيير اللغة
        }
      },
      child: Scaffold(
        appBar: _isSearching
            ? PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: CurrencySearchWidget(
                  searchTextController: _searchTextController,
                  addSearchedForCurrencyToSearchedList:
                      addSearchedForMetalToSearchedList,
                  onBackPressed: _stopSearching,
                  searchHint: S.of(context).SearchForAMetal,
                ),
              )
            : CustomAppBar(
                onSearchPressed: _startSearch,
                showSearchIcon: true,
                showBackButton: false,
                rightPadding: 50,
                showLanguageIcon: true),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 24.0.h),
                  child: ComparisonUnitContainer(
                    unit: unit,
                    onUnitSelected: (selectedUnit) {
                      setState(() {
                        unit = selectedUnit;
                        futureMetalPrices = WebService().fetchMetalPrices(unit);
                      });
                    },
                  ),
                ),
              ),
            ];
          },
          body: FutureBuilder<MetalModel>(
            future: futureMetalPrices,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return ErrorMessageWidget(
                    errorMessage: 'Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final prices = snapshot.data!.getMetalPrices();
                metalList = prices.keys
                    .map((metal) =>
                        getTranslatedMetalName(metal, _currentLocale!))
                    .toList();

                if (filteredMetalList.isEmpty) {
                  filteredMetalList.addAll(metalList);
                }

                if (errorMessage.isNotEmpty) {
                  return ErrorMessageWidget(errorMessage: errorMessage);
                }

                return ListView.builder(
                  itemCount: filteredMetalList.length,
                  itemBuilder: (context, index) {
                    final translatedMetal = filteredMetalList[index];
                    final originalMetal = prices.keys.firstWhere(
                      (key) =>
                          getTranslatedMetalName(key, _currentLocale!) ==
                          translatedMetal,
                      orElse: () => '',
                    );

                    if (originalMetal.isEmpty) {
                      return SizedBox.shrink();
                    }

                    final price = prices[originalMetal];

                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 72.5.h,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 12.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5d6d7e),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.h),
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: Container(
                                      width: 48.h,
                                      height: 48.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2.0,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/images.jpg',
                                          width: 40.h,
                                          height: 40.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.h),
                                  Text(
                                    translatedMetal,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(right: 12.h),
                                    child: Text(
                                      '${price?.toStringAsFixed(2)}\$',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: (price != null &&
                                                price
                                                        .toStringAsFixed(2)
                                                        .length >
                                                    7)
                                            ? 14.sp
                                            : 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                SizedBox(width: isArabic ? 8.h : 0.h),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return ErrorMessageWidget(errorMessage: 'No data available');
              }
            },
          ),
        ),
      ),
    );
  }
}
