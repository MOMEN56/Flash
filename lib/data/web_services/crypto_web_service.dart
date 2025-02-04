import 'package:dio/dio.dart';
import 'package:flash/data/models/cyrpto_model.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:convert';

class CryptoWebService {
  final Dio _dio;
  final String baseCryptoUrl;

  CryptoWebService(this.baseCryptoUrl) : _dio = Dio();

  Future<List<CryptoModel>> fetchCryptos() async {
    final cacheManager = DefaultCacheManager();
    final cachedData = await cacheManager.getFileFromCache(baseCryptoUrl);

    // إذا كانت البيانات موجودة في الكاش
    if (cachedData != null) {
      print('Data loaded from cache');
      final data =
          cachedData.file.readAsStringSync(); // قراءة البيانات من الكاش
      List<dynamic> jsonList = json.decode(data);

      // تصفية "Lido Staked Ether" من البيانات
      jsonList.removeWhere(
          (cryptoJson) => cryptoJson['name'] == 'Lido Staked Ether');

      return jsonList
          .map((cryptoJson) => CryptoModel.fromJson(cryptoJson))
          .toList();
    } else {
      try {
        // إذا لم تكن البيانات موجودة في الكاش، قم بتحميلها من الخادم
        final response = await _dio.get(baseCryptoUrl);

        if (response.statusCode == 200) {
          List<dynamic> data = response.data;

          // تصفية "Lido Staked Ether" من البيانات
          // حفظ البيانات في الكاش
          cacheManager.putFile(baseCryptoUrl, utf8.encode(json.encode(data)));

          // إرجاع البيانات المحملة
          return data
              .map((cryptoJson) => CryptoModel.fromJson(cryptoJson))
              .toList();
        } else {
          throw Exception('Failed to load cryptocurrencies');
        }
      } catch (e) {
        throw Exception('Failed to load cryptocurrencies: $e');
      }
    }
  }
}
