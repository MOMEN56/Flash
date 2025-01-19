class CurrencyModel {
  final String result;
  final Map<String, double> conversionRates;

  CurrencyModel({required this.result, required this.conversionRates});

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      result: json['result'],
      conversionRates: Map<String, double>.from(json['conversion_rates']),
    );
  }
}
