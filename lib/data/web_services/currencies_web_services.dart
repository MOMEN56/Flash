import 'package:dio/dio.dart';

class CurrenciesWebService {
  final Dio dio;

  CurrenciesWebService({required this.dio});

  
  Future<Map<String, dynamic>> fetchRates(String baseUrl) async {
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
