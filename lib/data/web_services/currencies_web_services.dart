import 'package:dio/dio.dart';
import 'package:flash/constants.dart';
import 'package:flash/data/models/currency_model.dart';

class CurrenciesWebServices {
  late Dio dio;

  CurrenciesWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl, // عنوان الـ API
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(options);
  }

  // دالة لجلب العملات
  Future<List<CurrencyModel>> getAllCurrencies(String currency) async {
    try {
      // هنا يتم استخدام العملة في الرابط بدلاً من تحديد "USD" بشكل ثابت
      Response response = await dio.get(currency);
      print('Response: ${response.data}');

      if (response.statusCode == 200) {
        var data = response.data;

        // تحقق من أن البيانات صحيحة قبل البدء في معالجتها
        if (data != null &&
            data.containsKey('result') &&
            data.containsKey('conversion_rates')) {
          var conversionRates =
              data['conversion_rates'] as Map<String, dynamic>;

          Map<String, double> conversionRatesMap = {};
          conversionRates.forEach((key, value) {
            conversionRatesMap[key] = double.tryParse(value.toString()) ?? 0.0;
          });

          // الآن نعيد كائن من نوع CurrencyModel مع البيانات المناسبة
          return [
            CurrencyModel(
              result: data['result'],
              conversionRates: conversionRatesMap,
            ),
          ];
        } else {
          throw Exception("البيانات غير صحيحة");
        }
      } else {
        throw Exception('Failed to load currencies');
      }
    } catch (e) {
      throw Exception('Error fetching currencies: $e');
    }
  }
}
