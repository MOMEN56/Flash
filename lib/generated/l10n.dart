// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Flash`
  String get AppBarTitle {
    return Intl.message('Flash', name: 'AppBarTitle', desc: '', args: []);
  }

  /// `Currencies`
  String get currency {
    return Intl.message('Currencies', name: 'currency', desc: '', args: []);
  }

  /// `Crypto`
  String get cyrpto {
    return Intl.message('Crypto', name: 'cyrpto', desc: '', args: []);
  }

  /// `Metals`
  String get metal {
    return Intl.message('Metals', name: 'metal', desc: '', args: []);
  }

  /// `Gram`
  String get gram {
    return Intl.message('Gram', name: 'gram', desc: '', args: []);
  }

  /// `Ounce`
  String get Ounce {
    return Intl.message('Ounce', name: 'Ounce', desc: '', args: []);
  }

  /// `Kilogram`
  String get kilo {
    return Intl.message('Kilogram', name: 'kilo', desc: '', args: []);
  }

  /// `Tonne`
  String get tonne {
    return Intl.message('Tonne', name: 'tonne', desc: '', args: []);
  }

  /// `ID`
  String get id {
    return Intl.message('ID', name: 'id', desc: '', args: []);
  }

  /// `Symbol`
  String get symbol {
    return Intl.message('Symbol', name: 'symbol', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Image`
  String get image {
    return Intl.message('Image', name: 'image', desc: '', args: []);
  }

  /// `Current Price`
  String get currentPrice {
    return Intl.message(
      'Current Price',
      name: 'currentPrice',
      desc: '',
      args: [],
    );
  }

  /// `Market Cap`
  String get marketCap {
    return Intl.message('Market Cap', name: 'marketCap', desc: '', args: []);
  }

  /// `Market Cap Rank`
  String get marketCapRank {
    return Intl.message(
      'Market Cap Rank',
      name: 'marketCapRank',
      desc: '',
      args: [],
    );
  }

  /// `Fully Diluted Valuation`
  String get fullyDilutedValuation {
    return Intl.message(
      'Fully Diluted Valuation',
      name: 'fullyDilutedValuation',
      desc: '',
      args: [],
    );
  }

  /// `Total Volume`
  String get totalVolume {
    return Intl.message(
      'Total Volume',
      name: 'totalVolume',
      desc: '',
      args: [],
    );
  }

  /// `High 24h`
  String get high24h {
    return Intl.message('High 24h', name: 'high24h', desc: '', args: []);
  }

  /// `Low 24h`
  String get low24h {
    return Intl.message('Low 24h', name: 'low24h', desc: '', args: []);
  }

  /// `Price Change 24h`
  String get priceChange24h {
    return Intl.message(
      'Price Change 24h',
      name: 'priceChange24h',
      desc: '',
      args: [],
    );
  }

  /// `Price Change Percentage 24h`
  String get priceChangePercentage24h {
    return Intl.message(
      'Price Change Percentage 24h',
      name: 'priceChangePercentage24h',
      desc: '',
      args: [],
    );
  }

  /// `Market Cap Change 24h`
  String get marketCapChange24h {
    return Intl.message(
      'Market Cap Change 24h',
      name: 'marketCapChange24h',
      desc: '',
      args: [],
    );
  }

  /// `Market Cap Change Percentage 24h`
  String get marketCapChangePercentage24h {
    return Intl.message(
      'Market Cap Change Percentage 24h',
      name: 'marketCapChangePercentage24h',
      desc: '',
      args: [],
    );
  }

  /// `Circulating Supply`
  String get circulatingSupply {
    return Intl.message(
      'Circulating Supply',
      name: 'circulatingSupply',
      desc: '',
      args: [],
    );
  }

  /// `Total Supply`
  String get totalSupply {
    return Intl.message(
      'Total Supply',
      name: 'totalSupply',
      desc: '',
      args: [],
    );
  }

  /// `Max Supply`
  String get maxSupply {
    return Intl.message('Max Supply', name: 'maxSupply', desc: '', args: []);
  }

  /// `All-Time High`
  String get ath {
    return Intl.message('All-Time High', name: 'ath', desc: '', args: []);
  }

  /// `ATH Change Percentage`
  String get athChangePercentage {
    return Intl.message(
      'ATH Change Percentage',
      name: 'athChangePercentage',
      desc: '',
      args: [],
    );
  }

  /// `ATH Date`
  String get athDate {
    return Intl.message('ATH Date', name: 'athDate', desc: '', args: []);
  }

  /// `All-Time Low`
  String get atl {
    return Intl.message('All-Time Low', name: 'atl', desc: '', args: []);
  }

  /// `ATL Change Percentage`
  String get atlChangePercentage {
    return Intl.message(
      'ATL Change Percentage',
      name: 'atlChangePercentage',
      desc: '',
      args: [],
    );
  }

  /// `ATL Date`
  String get atlDate {
    return Intl.message('ATL Date', name: 'atlDate', desc: '', args: []);
  }

  /// `Last Updated`
  String get lastUpdated {
    return Intl.message(
      'Last Updated',
      name: 'lastUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Search for a metal...`
  String get SearchForAMetal {
    return Intl.message(
      'Search for a metal...',
      name: 'SearchForAMetal',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get Amount {
    return Intl.message('Amount', name: 'Amount', desc: '', args: []);
  }

  /// `Search for a currency...`
  String get SearchForACurrency {
    return Intl.message(
      'Search for a currency...',
      name: 'SearchForACurrency',
      desc: '',
      args: [],
    );
  }

  /// `Search for a crypto...`
  String get SearchForACrypto {
    return Intl.message(
      'Search for a crypto...',
      name: 'SearchForACrypto',
      desc: '',
      args: [],
    );
  }

  /// `No cryptocurrencies found`
  String get NoCryptoFound {
    return Intl.message(
      'No cryptocurrencies found',
      name: 'NoCryptoFound',
      desc: '',
      args: [],
    );
  }

  /// `No metals found`
  String get NoMetalsFound {
    return Intl.message(
      'No metals found',
      name: 'NoMetalsFound',
      desc: '',
      args: [],
    );
  }

  /// `No currencies found`
  String get NoCurrenciesFound {
    return Intl.message(
      'No currencies found',
      name: 'NoCurrenciesFound',
      desc: '',
      args: [],
    );
  }

  /// `{currency}`
  String currency_name(Object currency) {
    return Intl.message(
      '$currency',
      name: 'currency_name',
      desc: '',
      args: [currency],
    );
  }

  /// `    comparison currency`
  String get comparison_currency {
    return Intl.message(
      '    comparison currency',
      name: 'comparison_currency',
      desc: '',
      args: [],
    );
  }

  /// `عربي`
  String get current_language {
    return Intl.message('عربي', name: 'current_language', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
