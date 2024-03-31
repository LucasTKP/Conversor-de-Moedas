

import 'package:currency_converter/models/currencies.dart';

class SingtonService {
  static SingtonService? _instance;
  SingtonService._();
  factory SingtonService() {
    _instance ??= SingtonService._();
    return _instance!;
  }

  List<CurrenciesModel>? currencies;
}
