class CurrenciesModel {
  late final String currency;
  late final String country;

  CurrenciesModel({
    required this.currency,
    required this.country,
  });

  static List<CurrenciesModel> fromMap(Map<String, dynamic> map) {
    List<CurrenciesModel> currencies = [];
    map.forEach((currency, country) {
      currencies.add(CurrenciesModel(currency: currency, country: country));
    });
    return currencies;
  }

  @override
  String toString() => 'CurrenciesModel(currency: $currency, country: $country)';
}
