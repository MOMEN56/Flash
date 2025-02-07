class MetalModel {
  final Map<String, double> metals;

  MetalModel(this.metals);

  // دالة لإرجاع أسعار المعادن
  Map<String, double> getMetalPrices() {
    return metals;
  }
}
