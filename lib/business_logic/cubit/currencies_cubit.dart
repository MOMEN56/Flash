import 'package:flash/constants.dart';
import 'package:flash/data/models/currency_model.dart';
import 'package:flash/data/web_services/currencies_web_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'currencies_state.dart';

class CurrenciesCubit extends Cubit<CurrenciesState> {
  final CurrenciesWebService currenciesService;
  String baseCurrency = "USD";

  // تخزين البيانات المحملة للحفاظ عليها عند التنقل
  Map<String, CurrencyModel> cachedRates = {};

  CurrenciesCubit(this.currenciesService) : super(CurrenciesInitial());

  Future<void> fetchCurrencies() async {
    // التحقق من وجود بيانات مخزنة لتجنب إعادة الجلب
    if (cachedRates.containsKey(baseCurrency)) {
      emit(CurrenciesLoaded([cachedRates[baseCurrency]!]));
      return;
    }

    try {
      emit(CurrenciesLoading());
      final url = "$baseCurrencyUrl$baseCurrency";
      final rates =
          (await currenciesService.fetchRates(url));

      final sanitizedRates = rates.map(
        (key, value) => MapEntry(key, (value as num).toDouble()),
      );

      final currencyModel = CurrencyModel(
        result: 'success',
        conversionRates: sanitizedRates,
      );
      // تخزين البيانات في الكاش
      cachedRates[baseCurrency] = currencyModel;

      emit(CurrenciesLoaded([currencyModel]));
    } catch (e) {
      emit(CurrenciesError('حدث خطأ أثناء جلب العملات: $e'));
    }
  }

  void updateBaseCurrency(String newCurrency) {
    baseCurrency = newCurrency;
    fetchCurrencies(); // جلب العملات إذا لم تكن موجودة في الكاش
  }
}
