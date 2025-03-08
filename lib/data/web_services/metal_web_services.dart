import 'package:dio/dio.dart';
import 'package:flash/constants.dart';
import 'package:flash/data/models/matal_model.dart';

class WebService {
  final Dio dio = Dio();

  
  Future<MetalModel> fetchMetalPrices(String unit) async {
    final urlMetal = '$baseMetal$unit';  

    try {
      final response = await dio.get(urlMetal);

      
      if (response.statusCode == 200) {
        
        final metalData = {
          "gold": (response.data['metals']['gold'] as num).toDouble(),
          "silver": (response.data['metals']['silver'] as num).toDouble(),
          "platinum": (response.data['metals']['platinum'] as num).toDouble(),
          "palladium": (response.data['metals']['palladium'] as num).toDouble(),
          "copper": (response.data['metals']['copper'] as num).toDouble(),
          "aluminum": (response.data['metals']['aluminum'] as num).toDouble(),
          "lead": (response.data['metals']['lead'] as num).toDouble(),
          "nickel": (response.data['metals']['nickel'] as num).toDouble(),
          "zinc": (response.data['metals']['zinc'] as num).toDouble(),
        };

        
        return MetalModel(metalData);
      } else {
        throw Exception('Failed to load metal prices');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e',);
    }
  }
}
