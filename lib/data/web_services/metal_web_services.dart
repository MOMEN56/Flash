import 'package:dio/dio.dart';
import 'package:flash/data/models/matal_model.dart';

class WebService {
  final Dio dio = Dio();

  // الدالة لجلب بيانات المعادن من الـ API
  Future<MetalModel> fetchMetalPrices() async {
    final url = 'https://api.metals.dev/v1/latest?api_key=MAI8G7L3NZL8T5XK6Y9B261XK6Y9B&currency=USD&unit=toz';
    
    try {
      final response = await dio.get(url);

      // التحقق من الاستجابة
      if (response.statusCode == 200) {
        // استخراج البيانات الخاصة بالمعادن فقط وتحويل القيم إلى double
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

        // إعادة الكائن MetalModel مع بيانات المعادن
        return MetalModel(metalData);
      } else {
        throw Exception('Failed to load metal prices');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
