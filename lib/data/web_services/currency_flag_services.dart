import 'package:dio/dio.dart';

class CurrencyFlag {
  final Dio dio;

  CurrencyFlag({required this.dio});

  // جلب رابط علم الدولة بناءً على العملة
  Future<String?> fetchFlagByCurrency(String currencyCode) async {
    try {
      // إذا كانت العملة هي USD، نرجع رابط علم الولايات المتحدة مباشرة
      if (currencyCode == 'USD') {
        return 'https://flagcdn.com/w320/us.png'; // رابط علم الولايات المتحدة
      }

      // إذا كانت العملة هي EUR (اليورو)، نرجع رابط علم الاتحاد الأوروبي
      if (currencyCode == 'EUR') {
        return 'https://flagcdn.com/w320/eu.png'; // رابط علم الاتحاد الأوروبي
      }

      // طلب البيانات من API الدول
      final response = await dio.get('https://restcountries.com/v3.1/all');
      if (response.statusCode == 200) {
        // تحليل البيانات
        final List<dynamic> countries = response.data;

        // البحث عن الدولة التي تحتوي على العملة المطلوبة
        for (var country in countries) {
          if (country['currencies'] != null && country['currencies'][currencyCode] != null) {
            // جلب رابط صورة العلم
            return country['flags']['png'];
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
