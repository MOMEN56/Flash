import 'package:dio/dio.dart';

class CurrencyFlag {
  final Dio dio;
  final Map<String, String?> _cachedFlags = {}; 
  CurrencyFlag({required this.dio});

  Future<String?> fetchFlagByCurrency(String currencyCode) async {
    if (_cachedFlags.containsKey(currencyCode)) {
      return _cachedFlags[currencyCode]; 
    }

    if (currencyCode == 'USD') {
      return 'https://flagcdn.com/w320/us.png';
    }
    if (currencyCode == 'EUR') {
      return 'https://flagcdn.com/w320/eu.png';
    }

    final response = await dio.get('https://restcountries.com/v3.1/all');
    if (response.statusCode == 200) {
      final List<dynamic> countries = response.data;

      for (var country in countries) {
        if (country['currencies'] != null &&
            country['currencies'][currencyCode] != null) {
          String flagUrl = country['flags']['png'];
          _cachedFlags[currencyCode] = flagUrl; 
          return flagUrl;
        }
      }
    }
    return null;
  }
}
