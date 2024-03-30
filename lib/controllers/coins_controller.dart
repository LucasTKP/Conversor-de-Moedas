import 'dart:convert';

import 'package:currency_converter/service/dio_service.dart';
import 'package:currency_converter/service/dio_service_imp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoinsController {
  //Buscando todos os tipos de moedas do assets para não fazer requisições atoa quando abrir o app
  static Future<List<String>> getCurrencies() async {
    String jsonString = await rootBundle.loadString('assets/coins.json');
    Map<String, dynamic> data = json.decode(jsonString);
    List<dynamic> currencies = data['coins'];
    List<String> currencyCodes =
        currencies.map((currency) => currency.toString()).toList();
    return currencyCodes;
  }


  //Verificando se os campos foram preenchidos corretamente e fazendo a requisição para buscar a conversão
  Future<dynamic> handleConverter(
      {required GlobalKey<FormState> formKey,
      String? quantity,
      String? currentCoinSelected,
      String? currentConvertedCurrency}) async {
    if (formKey.currentState!.validate()) {
      DioService dioService = DioServiceImp();
      try {
        final response = await dioService.getDio().get(
            '/latest?amount=$quantity&from=$currentCoinSelected&to=$currentConvertedCurrency');
        return response;
      } catch (e) {
        print(e);
      }
    }
    return null;
  }

  //Salvando a moeda base escolhida no cache
  saveInCache(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('coin_cache', value);
  }

    //Puxando a ultima moeda base escolhida
  Future<String?> getInCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var coinCache = prefs.getString('coin_cache');
    if (coinCache != null) {
      return coinCache;
    }
    return null;
  }
}
