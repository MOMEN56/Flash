import 'package:flash/constants.dart';
import 'package:flash/crypto_translations.dart';
import 'package:flash/generated/l10n.dart';
import 'package:flash/presentation/widgets/search_widget.dart';
import 'package:flash/presentation/widgets/error_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flash/data/web_services/crypto_web_service.dart';
import 'package:flash/data/models/cyrpto_model.dart';
import 'package:flash/presentation/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibration/vibration.dart';
import 'crypto_info_screen.dart';

class CryptoRatesScreen extends StatefulWidget {
  final Function(CryptoModel)? onCryptoSelected;

  const CryptoRatesScreen({super.key, this.onCryptoSelected});

  @override
  _CryptoRatesScreenState createState() => _CryptoRatesScreenState();
}

class _CryptoRatesScreenState extends State<CryptoRatesScreen> {
  bool _isSearching = false;
  String errorMessage = '';
  final _searchTextController = TextEditingController();
  final List<String> cryptoList = [];
  final List<String> filteredCryptoList = [];
  final CryptoWebService cryptoWebService = CryptoWebService(baseCyrptoUrl);
  Map<String, bool> favoriteCryptos = {};

  int currentIndex = 0;
  CryptoModel? selectedCrypto;
  List<CryptoModel> cryptos = [];

  Future<void> fetchCryptos() async {
    try {
      final fetchedCryptos = await cryptoWebService.fetchCryptos();
      Locale currentLocale = Localizations.localeOf(context);
      setState(() {
        cryptos = fetchedCryptos;
        cryptoList.clear();

        // تخزين الأسماء بناءً على اللغة
        cryptoList.addAll(
          cryptos.map((crypto) => getTranslatedCryptoName(crypto.name, currentLocale)).toList(),
        );

        filteredCryptoList.clear();
        filteredCryptoList.addAll(cryptoList);
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching data';
      });
    }
  }

  void addSearchedForCryptoToSearchedList(String searchedCrypto) {
    setState(() {
      if (searchedCrypto.isEmpty) {
        filteredCryptoList.clear();
        filteredCryptoList.addAll(cryptoList);
      } else {
        filteredCryptoList.clear();
        filteredCryptoList.addAll(
          cryptoList.where(
            (crypto) => crypto.toLowerCase().contains(searchedCrypto.toLowerCase()),
          ).toList(),
        );
      }
      errorMessage = filteredCryptoList.isEmpty ? S.of(context).NoCryptoFound : '';
    });
  }

  void _stopSearching() {
    setState(() {
      _isSearching = false;
      _searchTextController.clear();
      addSearchedForCryptoToSearchedList('');
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCryptos();
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

    return Scaffold(
      appBar: _isSearching
          ? PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: CurrencySearchWidget(
                searchHint: S.of(context).SearchForACrypto,
                searchTextController: _searchTextController,
                addSearchedForCurrencyToSearchedList: addSearchedForCryptoToSearchedList,
                onBackPressed: _stopSearching,
              ),
            )
          : CustomAppBar(onSearchPressed: _startSearch, showBackButton: false, rightPadding: 100),
      body: errorMessage.isNotEmpty
          ? ErrorMessageWidget(errorMessage: errorMessage)
          : cryptos.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: filteredCryptoList.length,
                  itemBuilder: (context, index) {
                    var crypto = cryptos.firstWhere((c) => 
                      getTranslatedCryptoName(c.name, currentLocale) == filteredCryptoList[index]);
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          selectedCrypto = crypto;
                        });

                        if (await Vibration.hasVibrator() ?? false) {
                          Vibration.vibrate(duration: 100);
                        }

                        if (widget.onCryptoSelected != null) {
                          widget.onCryptoSelected!(crypto);
                        }

                        if (selectedCrypto != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CryptoInfoScreen(crypto: selectedCrypto!),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 72.5.h,
                        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: Image.network(
                                      crypto.image ?? 'https://example.com/placeholder.png',
                                      width: 40.h,
                                      height: 40.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    getTranslatedCryptoName(crypto.name, currentLocale),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: crypto.name.length > 10 ? 10.sp : 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Row(
                                children: [
                                  Text(
                                    '${crypto.currentPrice.toString()}\$',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: crypto.currentPrice.toString().length > 7
                                          ? 14.sp
                                          : 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
