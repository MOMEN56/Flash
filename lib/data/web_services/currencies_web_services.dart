import 'package:dio/dio.dart';

class CurrenciesWebService {
  final Dio dio;

  CurrenciesWebService({required this.dio});

  // دالة لجلب العملات بناءً على baseUrl
  Future<Map<String, dynamic>> fetchRates(String baseUrl) async {
    try {
      final response = await dio.get(baseUrl);  // استخدم الـ baseUrl الذي يتم تمريره
      if (response.statusCode == 200) {
        return response.data['conversion_rates'];  // العودة بمعدل التحويل
      } else {
        throw Exception('Failed to load rates');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
