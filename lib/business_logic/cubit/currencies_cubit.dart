library currencies_cubit;

import 'package:flash/data/models/currency_model.dart';
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
      emit(CurrenciesLoaded(currencies)); // تصدر حالة العملات المحملة
    } catch (e) {
      emit(CurrenciesError('حدث خطأ أثناء جلب العملات: $e')); // تصدر حالة الخطأ
    }
  }
}
