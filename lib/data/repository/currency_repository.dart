import 'package:flash/data/models/currency_model.dart';
import 'package:flash/data/web_services/currencies_web_services.dart';

class CurrenciesRepository {
  final CurrenciesWebServices _currenciesWebServices;

  CurrenciesRepository(this._currenciesWebServices); // تهيئة الويب سرفيس

  Future<List<CurrencyModel>> getAllCurrencies() async {
    try {
      // استدعاء دالة getAllCurrencies بدون الحاجة لتمرير العملة
      final response = await _currenciesWebServices.getAllCurrencies("USD"); 
      
      if (response.isNotEmpty) {
        return response;
      } else {
        throw Exception('Failed to load currencies');
      }
    } catch (e) {
      throw Exception('Error fetching currencies: $e');
    }
  }
}
