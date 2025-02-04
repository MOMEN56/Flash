import 'package:flash/constants.dart';
import 'package:flash/presentation/widgets/currency_search_widget.dart';
import 'package:flash/presentation/widgets/error_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flash/data/web_services/crypto_web_service.dart';
import 'package:flash/data/models/cyrpto_model.dart';
import 'package:flash/presentation/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'crypto_info_screen.dart';

class CryptoRatesScreen extends StatefulWidget {
  const CryptoRatesScreen({super.key});

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

  Future<void> fetchCryptos() async {
    try {
      final cryptos = await cryptoWebService.fetchCryptos();
      setState(() {
        cryptoList.clear();
        cryptoList.addAll(cryptos.map((crypto) => crypto.name).toList());
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
        filteredCryptoList.addAll(cryptoList
            .where((crypto) =>
                crypto.toLowerCase().startsWith(searchedCrypto.toLowerCase()))
            .toList());
      }
      errorMessage = filteredCryptoList.isEmpty ? 'No crypto found' : '';
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
    return Scaffold(
      appBar: _isSearching
          ? PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: CurrencySearchWidget(
                searchTextController: _searchTextController,
                addSearchedForCurrencyToSearchedList:
                    addSearchedForCryptoToSearchedList,
                onBackPressed: _stopSearching,
              ),
            )
          : CustomAppBar(onSearchPressed: _startSearch),
      body: errorMessage.isNotEmpty
          ? ErrorMessageWidget(errorMessage: errorMessage)
          : FutureBuilder<List<CryptoModel>>(
              future: cryptoWebService.fetchCryptos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  List<CryptoModel> cryptos = snapshot.data!;

                  return ListView.builder(
                    itemCount: filteredCryptoList.length,
                    itemBuilder: (context, index) {
                      var crypto = cryptos.firstWhere(
                          (c) => c.name == filteredCryptoList[index]);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CryptoInfoScreen(
                                crypto: crypto,
                              ),
                            ),
                          );
                        },
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: Row(
                                  children: [
                                    ClipOval(
                                      child: Image.network(
                                        crypto.image,
                                        width: 40.h,
                                        height: 40.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      crypto.name,
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
                                        fontSize: crypto.currentPrice.toString().length > 7 ? 14.sp : 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        size: 18.w,
                                        color: favoriteCryptos[crypto.name] ??
                                                false
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          favoriteCryptos[crypto.name] =
                                              !(favoriteCryptos[crypto.name] ??
                                                  false);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
    );
  }
}
