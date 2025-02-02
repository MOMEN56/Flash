import 'package:flash/data/models/currency_model.dart';
import 'package:flash/data/web_services/currencies_web_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'currencies_state.dart'; // تحديد الجزء المرتبط بالمكتبة

class CurrenciesCubit extends Cubit<CurrenciesState> {
  final CurrenciesWebService currenciesService; // استخدام CurrenciesService بدلاً من CurrenciesRepository
  String baseCurrency = "USD";  // العملة الأساسية (يمكنك تعديلها حسب الحاجة)

  CurrenciesCubit(this.currenciesService) : super(CurrenciesInitial());

  // دالة لتقريب الأرقام إلى 7 أرقام بعد الفاصلة
  double roundTo7Digits(double number) {
    // التأكد من أن العدد أكبر من 7 أرقام
    if (number.toString().length > 7) {
      return double.parse(number.toStringAsFixed(7));  // تقريبه إلى 7 أرقام بعد الفاصلة
    } else {
      return number;  // إذا كانت الأرقام أقل أو تساوي 7، نتركه كما هو
    }
  }

  // دالة لجلب العملات باستخدام baseCurrency
  Future<void> fetchCurrencies() async {
    try {
      emit(CurrenciesLoading());
      final baseUrl = "https://v6.exchangerate-api.com/v6/cece996ffe0a030451cb4f5a/latest/$baseCurrency";
      final rates = await currenciesService.fetchRates(baseUrl);  // جلب البيانات باستخدام CurrenciesService مع baseCurrency المحددة

      // تحويل البيانات إلى نماذج CurrencyModel
      final currenciesModel = rates.keys.map((currency) {
        // تطبيق التقريب على السعر
        final rate = roundTo7Digits(rates[currency].toDouble());

        return CurrencyModel(
          result: 'success', // استبدال القيمة الثابتة هنا حسب الحاجة
          conversionRates: {currency: rate}, // إنشاء conversionRates باستخدام العملة
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
