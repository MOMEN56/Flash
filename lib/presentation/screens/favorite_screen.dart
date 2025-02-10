import 'package:flutter/material.dart';
import 'package:flash/presentation/widgets/search_widget.dart'; // تأكد من استيراد هذا
import 'package:flash/presentation/widgets/custom_app_bar.dart'; // تأكد من استيراد هذا
import 'package:flash/data/models/cyrpto_model.dart'; // تأكد من استيراد نموذج العملات

class FavoriteScreen extends StatefulWidget {
  final Map<String, bool> favoriteCryptos; // نقل البيانات من الشاشة الأخرى

  const FavoriteScreen({super.key, required this.favoriteCryptos});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  final List<CryptoModel> filteredFavoriteCryptos = [];

  @override
  void initState() {
    super.initState();
    // تصفية العملات المفضلة بناءً على البحث
    filteredFavoriteCryptos.addAll(widget.favoriteCryptos.entries
        .where((entry) => entry.value) // فقط العملات المفضلة
        .map((entry) => CryptoModel(
          id: entry.key, // ضع معرّف العملة إذا كان متاحًا
          symbol: '',  // استبدل بالقيمة الصحيحة إن وجدت
          name: entry.key,
          image: '',  // استبدل بالصورة إن وجدت
          currentPrice: 0.0,  // استبدل بالقيمة المناسبة
          marketCap: 0.0,  // استبدل بالقيمة المناسبة
          marketCapRank: 0.0,  // استبدل بالقيمة المناسبة
          fullyDilutedValuation: 0.0, // استبدل بالقيمة المناسبة
          totalVolume: 0.0, // استبدل بالقيمة المناسبة
          high24h: 0.0, // استبدل بالقيمة المناسبة
          low24h: 0.0, // استبدل بالقيمة المناسبة
          priceChange24h: 0.0, // استبدل بالقيمة المناسبة
          priceChangePercentage24h: 0.0, // استبدل بالقيمة المناسبة
          marketCapChange24h: 0.0, // استبدل بالقيمة المناسبة
          marketCapChangePercentage24h: 0.0, // استبدل بالقيمة المناسبة
          circulatingSupply: 0.0, // استبدل بالقيمة المناسبة
          totalSupply: 0.0, // استبدل بالقيمة المناسبة
          maxSupply: null, // استبدل بالقيمة المناسبة إن وجدت
          ath: 0.0, // استبدل بالقيمة المناسبة
          athChangePercentage: 0.0, // استبدل بالقيمة المناسبة
          athDate: '', // استبدل بالقيمة المناسبة
          atl: 0.0, // استبدل بالقيمة المناسبة
          atlChangePercentage: 0.0, // استبدل بالقيمة المناسبة
          atlDate: '', // استبدل بالقيمة المناسبة
          lastUpdated: '', // استبدل بالقيمة المناسبة
        ))
        .toList());
  }

  void addSearchedForCryptoToSearchedList(String searchedCrypto) {
    setState(() {
      if (searchedCrypto.isEmpty) {
        filteredFavoriteCryptos.clear();
        filteredFavoriteCryptos.addAll(widget.favoriteCryptos.entries
            .where((entry) => entry.value) // فقط العملات المفضلة
            .map((entry) => CryptoModel(
              id: entry.key, 
              symbol: '', 
              name: entry.key,
              image: '',
              currentPrice: 0.0,
              marketCap: 0.0,
              marketCapRank: 0.0,
              fullyDilutedValuation: 0.0,
              totalVolume: 0.0,
              high24h: 0.0,
              low24h: 0.0,
              priceChange24h: 0.0,
              priceChangePercentage24h: 0.0,
              marketCapChange24h: 0.0,
              marketCapChangePercentage24h: 0.0,
              circulatingSupply: 0.0,
              totalSupply: 0.0,
              maxSupply: null,
              ath: 0.0,
              athChangePercentage: 0.0,
              athDate: '',
              atl: 0.0,
              atlChangePercentage: 0.0,
              atlDate: '',
              lastUpdated: '',
            ))
            .toList());
      } else {
        filteredFavoriteCryptos.clear();
        filteredFavoriteCryptos.addAll(widget.favoriteCryptos.entries
            .where((entry) =>
                entry.value &&
                entry.key.toLowerCase().startsWith(searchedCrypto.toLowerCase())) // البحث في المفضلة
            .map((entry) => CryptoModel(
              id: entry.key, 
              symbol: '', 
              name: entry.key,
              image: '',
              currentPrice: 0.0,
              marketCap: 0.0,
              marketCapRank: 0.0,
              fullyDilutedValuation: 0.0,
              totalVolume: 0.0,
              high24h: 0.0,
              low24h: 0.0,
              priceChange24h: 0.0,
              priceChangePercentage24h: 0.0,
              marketCapChange24h: 0.0,
              marketCapChangePercentage24h: 0.0,
              circulatingSupply: 0.0,
              totalSupply: 0.0,
              maxSupply: null,
              ath: 0.0,
              athChangePercentage: 0.0,
              athDate: '',
              atl: 0.0,
              atlChangePercentage: 0.0,
              atlDate: '',
              lastUpdated: '',
            ))
            .toList());
      }
    });
  }

  void _stopSearching() {
    setState(() {
      _isSearching = false;
      _searchTextController.clear();
      addSearchedForCryptoToSearchedList('');
    });
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
                searchHint: "Search a favorite item",
                searchTextController: _searchTextController,
                addSearchedForCurrencyToSearchedList:
                    addSearchedForCryptoToSearchedList,
                onBackPressed: _stopSearching,
              ),
            )
          : CustomAppBar(onSearchPressed: _startSearch, showBackButton: true),
      body: ListView.builder(
        itemCount: filteredFavoriteCryptos.length,
        itemBuilder: (context, index) {
          final crypto = filteredFavoriteCryptos[index];
          return ListTile(
            title: Text(crypto.name),
            // عرض المزيد من التفاصيل حسب الحاجة
          );
        },
      ),
    );
  }
}
