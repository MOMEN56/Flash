// currencies_web_service.dart
import 'package:dio/dio.dart';
import 'package:flash/constants.dart';

class CurrenciesWebService {
  final Dio dio;

  CurrenciesWebService({required this.dio});

  // دالة لجلب العملات
  Future<Map<String, dynamic>> fetchRates() async {
    try {
      final response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        return response.data['conversion_rates'];
      } else {
        throw Exception('Failed to load rates');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
