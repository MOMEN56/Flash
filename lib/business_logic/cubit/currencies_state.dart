part of 'currencies_cubit.dart';

@immutable
abstract class CurrenciesState {}

class CurrenciesInitial extends CurrenciesState {}

class CurrenciesLoading extends CurrenciesState {}

class CurrenciesLoaded extends CurrenciesState {
  final List<CurrencyModel> currencies;

  CurrenciesLoaded(this.currencies);
}

class CurrenciesError extends CurrenciesState {
  final String message;

  CurrenciesError(this.message);
}
