import 'package:dio/dio.dart';
import 'package:flash/data/models/cyrpto_model.dart';

class CryptoWebService {
  final Dio _dio;
  final String baseCryptoUrl;

  CryptoWebService(this.baseCryptoUrl) : _dio = Dio();

  // دالة لتحميل قائمة العملات الرقمية
  Future<List<CryptoModel>> fetchCryptos() async {
    try {
      // استدعاء الـ API باستخدام Dio مع الرابط الثابت
      final response = await _dio.get(baseCryptoUrl);

      // التحقق من حالة الاستجابة
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((cryptoJson) => CryptoModel.fromJson(cryptoJson)).toList();
      } else {
        throw Exception('Failed to load cryptocurrencies');
      }
    } catch (e) {
      throw Exception('Failed to load cryptocurrencies: $e');
    }
  }
}
