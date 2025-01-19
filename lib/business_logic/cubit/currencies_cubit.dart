import 'package:flash/data/models/currency_model.dart';
import 'package:flash/data/repository/currency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'currencies_state.dart'; // تحديد الجزء المرتبط بالمكتبة

class CurrenciesCubit extends Cubit<CurrenciesState> {
  final CurrenciesRepository currenciesRepository;

  CurrenciesCubit(this.currenciesRepository) : super(CurrenciesInitial());

  Future<void> fetchCurrencies() async {
    try {
      emit(CurrenciesLoading());
      final currencies = await currenciesRepository.getAllCurrencies();
      // تحويل العملات إلى النوع المتوقع
      final currenciesModel = currencies.map((currency) {
        return CurrencyModel(
          result: currency.result,
          conversionRates: currency.conversionRates,
        );
      }).toList();
      emit(CurrenciesLoaded(currenciesModel));
    } catch (e) {
      emit(CurrenciesError('حدث خطأ أثناء جلب العملات: $e'));
    }
  }
}
