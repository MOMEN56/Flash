import 'package:dio/dio.dart';

class CurrencyFlag {
  final Dio dio;
  Map<String, String?> _cachedFlags = {}; // كاش الصور

  CurrencyFlag({required this.dio});

  Future<String?> fetchFlagByCurrency(String currencyCode) async {
    // التحقق إذا كانت الصورة موجودة في الكاش بالفعل
    if (_cachedFlags.containsKey(currencyCode)) {
      return _cachedFlags[currencyCode]; // إرجاع الرابط من الكاش
    }

    try {
      // إذا كانت العملة هي USD أو EUR، نرجع الرابط مباشرة
      if (currencyCode == 'USD') {
        return 'https://flagcdn.com/w320/us.png';
      }
      if (currencyCode == 'EUR') {
        return 'https://flagcdn.com/w320/eu.png';
      }

      // طلب البيانات من API الدول
      final response = await dio.get('https://restcountries.com/v3.1/all');
      if (response.statusCode == 200) {
        final List<dynamic> countries = response.data;

        for (var country in countries) {
          if (country['currencies'] != null && country['currencies'][currencyCode] != null) {
            String flagUrl = country['flags']['png'];
            _cachedFlags[currencyCode] = flagUrl; // حفظ الرابط في الكاش
            return flagUrl;
          }
        }
        throw Exception('Currency not found in any country');
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
