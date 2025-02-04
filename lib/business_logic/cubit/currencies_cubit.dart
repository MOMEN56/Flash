import 'package:flash/constants.dart';
import 'package:flash/data/models/currency_model.dart';
import 'package:flash/data/web_services/currencies_web_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'currencies_state.dart'; // تحديد الجزء المرتبط بالمكتبة

class CurrenciesCubit extends Cubit<CurrenciesState> {
  final CurrenciesWebService currenciesService; // استخدام CurrenciesService بدلاً من CurrenciesRepository
  String baseCurrency = "USD";  // العملة الأساسية (يمكنك تعديلها حسب الحاجة)

  CurrenciesCubit(this.currenciesService) : super(CurrenciesInitial());

  // دالة لجلب العملات باستخدام baseCurrency
  Future<void> fetchCurrencies() async {
    try {
      emit(CurrenciesLoading());
      final url = "$baseUrl$baseCurrency";
      final rates = await currenciesService.fetchRates(url);  // جلب البيانات باستخدام CurrenciesService مع baseCurrency المحددة

      // تحويل البيانات إلى نماذج CurrencyModel
      final currenciesModel = rates.keys.map((currency) {
        return CurrencyModel(
          result: 'success', // استبدال القيمة الثابتة هنا حسب الحاجة
          conversionRates: {currency: rates[currency]}, // إنشاء conversionRates باستخدام العملة
        );
      }).toList();

      emit(CurrenciesLoaded(currenciesModel)); // إرسال البيانات المحملة إلى الحالة
    } catch (e) {
      emit(CurrenciesError('حدث خطأ أثناء جلب العملات: $e'));
    }
  }

  // دالة لتحديث baseCurrency عند تغيير العملة
  void updateBaseCurrency(String newCurrency) {
    baseCurrency = newCurrency;
    fetchCurrencies(); // جلب العملات بعد تحديث العملة الأساسية
  }
}
