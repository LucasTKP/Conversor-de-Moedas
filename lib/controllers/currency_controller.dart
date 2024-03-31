import 'dart:async';
import 'dart:io';
import 'package:currency_converter/models/currencies.dart';
import 'package:currency_converter/models/currency.dart';
import 'package:currency_converter/models/general.dart';
import 'package:currency_converter/service/dio_service.dart';
import 'package:currency_converter/service/dio_service_imp.dart';
import 'package:currency_converter/service/sington_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyController {
  final DioService dioService;
  CurrencyController(this.dioService);

  String? currentCurrencySelected;
  String? currentConvertedCurrency;
  final quantityController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ValueNotifier<String?> convertedValue = ValueNotifier<String?>(null);
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  //Buscando todos os tipos de moedas
  Future<bool> getCurrencies() async {
    try {
      final response = await dioService.getDio().get('/currencies');
      final Map<String, dynamic> data = response.data;

      List<CurrenciesModel> currencies = CurrenciesModel.fromMap(data);

      SingtonService().currencies = currencies;
      return true;
    } catch (e) {
      String error =
          'Erro ao buscar valor convertido, tente novamente mais tarde';
      if (e is DioException) {
        if (e.error is SocketException) {
          error = 'Sem internet, por favor reconecte';
        }
      }
      Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }

  //Fazendo a requisição para buscar a conversão
  void handleConverter(Function(String) onError) async {
    isLoading.value = true;
    final result = await validateForms();
    if (result == true) {
      DioService dioService = DioServiceImp();
      try {
        final response = await dioService.getDio().get(
            '/latest?amount=${quantityController.text}&from=$currentCurrencySelected&to=$currentConvertedCurrency');
        if (response.statusCode == 200) {
          final CurrencyModel currency =
              CurrencyModel.fromJson(response.data['rates']);
          convertedValue.value = currency.valueConverted.toString();
        }
      } catch (e) {
        String error =
            'Erro ao buscar valor convertido, tente novamente mais tarde';
        if (e is DioException) {
          if (e.error is SocketException) {
            error = 'Sem internet, por favor reconecte';
          }
        }
        onError(error);
      }
    }
    Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
  }

  //Verificando se os campos foram preenchidos corretamente
  Future<bool> validateForms() async {
    if (formKey.currentState!.validate()) {
      //Verificando se as moedas não são iguais pois a api retorna um erro
      if (currentCurrencySelected == currentConvertedCurrency) {
        Fluttertoast.showToast(
          msg: "Não é possivel converter uma moeda para ela mesma",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return false;
      }
      return true;
    }
    return false;
  }

  //Salvando a moeda base escolhida no cache
  saveInCache(String value, TypeDropDown typeDropDown) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (TypeDropDown.base == typeDropDown) {
      prefs.setString('currency_base_cache', value);
    } else if (TypeDropDown.converted == typeDropDown) {
      prefs.setString('currency_converted_cache', value);
    }
  }

  //Puxando a ultima moeda base escolhida
  Future<String?> getInCache(TypeDropDown typeDropDown) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? currencyCache;
    if (TypeDropDown.base == typeDropDown) {
      currencyCache = prefs.getString('currency_base_cache');
    } else if (TypeDropDown.converted == typeDropDown) {
      currencyCache = prefs.getString('currency_converted_cache');
    }
    if (currencyCache != null) {
      return currencyCache;
    }
    return null;
  }
}
