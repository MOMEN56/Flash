import 'package:dio/dio.dart';

class CurrencyRepository {
  final Dio _dio = Dio();

  Future<List<Currency>> getCurrencies() async {
    try {
      final response = await _dio.get('https://v6.exchangerate-api.com/v6/cece996ffe0a030451cb4f5a/latest/USD');
      if (response.statusCode == 200) {
        // تأكد من معالجة البيانات بشكل صحيح
        final data = response.data;
        List<Currency> currencies = parseCurrencies(data);
        return currencies;
      } else {
        throw Exception('Failed to load currencies');
      }
    } catch (e) {
      throw Exception('Error fetching currencies: $e');
    }
  }

  List<Currency> parseCurrencies(Map<String, dynamic> data) {
    // استخرج البيانات المناسبة من API
    return data['conversion_rates'].entries.map<Currency>((entry) {
      return Currency(result: entry.key, conversionRates: entry.value);
    }).toList();
  }
}

class Currency {
  final String result;
  final double conversionRates;

  Currency({required this.result, required this.conversionRates});
}
