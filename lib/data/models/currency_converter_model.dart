// currency_converter_model.dart

class CurrencyConverterModel {
   String comparisonCurrency;
   String selectedCurrency;
   double comparisonCurrencyRate;
   double selectedCurrencyRate;
   String comparisonCurrencyFlagUrl;
   String selectedCurrencyFlagUrl;
  CurrencyConverterModel({
    required this.comparisonCurrency,
    required this.selectedCurrency,
    required this.comparisonCurrencyRate,
    required this.selectedCurrencyRate,
    required this.comparisonCurrencyFlagUrl,
    required this.selectedCurrencyFlagUrl,
  });
}
