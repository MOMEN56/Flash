// currency_converter_model.dart

class CurrencyConverterModel {
  final String comparisonCurrency;
  final String selectedCurrency;
  final double comparisonCurrencyRate;
  final double selectedCurrencyRate;
  final String comparisonCurrencyFlagUrl;
  final String selectedCurrencyFlagUrl;

  CurrencyConverterModel({
    required this.comparisonCurrency,
    required this.selectedCurrency,
    required this.comparisonCurrencyRate,
    required this.selectedCurrencyRate,
    required this.comparisonCurrencyFlagUrl,
    required this.selectedCurrencyFlagUrl,
  });
}
