class CurrencyModel {
  final String result;
  final Map<String, double> conversionRates;

  CurrencyModel({required this.result, required this.conversionRates});
}
class CurrencyInfo {
  final String name;
  final String flagUrl;
  final double rate;

  CurrencyInfo({
    required this.name,
    required this.flagUrl,
    required this.rate,
  });
}
