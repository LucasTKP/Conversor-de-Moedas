// ignore_for_file: public_member_api_docs, sort_constructors_first
class CurrencyModel {
  double? valueConverted;
  CurrencyModel({required this.valueConverted});
  CurrencyModel.fromJson(Map json) {
    final list = json.values.toList();
    valueConverted = list.first;
  }

  @override
  String toString() => 'CurrencyModel(valueConverted: $valueConverted)';
}
