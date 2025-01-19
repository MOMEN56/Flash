import 'package:dio/dio.dart';
import 'package:flash/data/models/currency_model.dart';
import 'package:flash/data/web_services/currencies_web_services.dart';

class CurrenciesRepository {
  final Dio _dio = Dio();

  CurrenciesRepository(CurrenciesWebServices currenciesWebServices);

  Future<List<CurrencyModel>> getAllCurrencies() async {
    // تعديل النوع
    try {
      final response = await _dio.get(
          'https://v6.exchangerate-api.com/v6/cece996ffe0a030451cb4f5a/latest/USD');
      if (response.statusCode == 200) {
        final data = response.data;
        List<CurrencyModel> currencies =
            parseCurrencies(data); // التأكد من استخدام النوع الموحد
        return currencies;
      } else {
        throw Exception('Failed to load currencies');
      }
    } catch (e) {
      throw Exception('Error fetching currencies: $e');
    }
  }

  List<CurrencyModel> parseCurrencies(Map<String, dynamic> data) {
    return data['conversion_rates'].entries.map<CurrencyModel>((entry) {
      return CurrencyModel(result: entry.key, conversionRates: entry.value);
    }).toList();
  }
}
