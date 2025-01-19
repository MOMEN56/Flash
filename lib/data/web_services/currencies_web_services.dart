import 'package:dio/dio.dart';
import 'package:flash/data/models/currency_model.dart';
import 'package:flash/constants.dart';
import 'package:flutter/widgets.dart'; // تأكد من المسار الصحيح

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
  Future<List<CurrencyModel>> getAllCurrencies() async {
    try {
      Response response = await dio.get(baseCurrency); // استخدام baseUrl مع العملة
      var data = response.data;

      // طباعة البيانات التي تم إرجاعها من الـ API
      debugPrint('Response Data: $data'); // تحقق من محتوى البيانات

      if (data != null && data.containsKey('result') && data.containsKey('conversion_rates')) {
        var conversionRates = data['conversion_rates'] as Map<String, dynamic>;

        // طباعة محتويات conversionRates للتأكد
        debugPrint('Conversion Rates: $conversionRates');

        List<CurrencyModel> currencies = [];
        conversionRates.forEach((key, value) {
          currencies.add(CurrencyModel(result: data['result'], conversionRates: {key: value.toDouble()}));
        });

        return currencies;
      } else {
        throw Exception("البيانات المفقودة من الـ API");
      }
    } catch (e) {
      // طباعة الخطأ لمساعدتك في تحديد المشكلة
      debugPrint('حدث خطأ أثناء جلب البيانات: $e');
      throw Exception('حدث خطأ أثناء جلب البيانات: $e');
    }
  }
}
