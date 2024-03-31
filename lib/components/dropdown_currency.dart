import 'package:currency_converter/controllers/currency_controller.dart';
import 'package:currency_converter/models/currencies.dart';
import 'package:currency_converter/models/general.dart';
import 'package:currency_converter/service/sington_service.dart';
import 'package:flutter/material.dart';

class DropDownCurrency extends StatefulWidget {
  const DropDownCurrency(
      {super.key,
      this.setCurrentCurrencySelected,
      this.setCurrentConvertedCurrency,
      required this.controller});
  final Function? setCurrentCurrencySelected;
  final Function? setCurrentConvertedCurrency;
  final CurrencyController controller;

  @override
  State<DropDownCurrency> createState() => _DropDownCurrencyState();
}

class _DropDownCurrencyState extends State<DropDownCurrency> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.setCurrentCurrencySelected != null
          ? widget.controller.currentCurrencySelected
          : widget.controller.currentConvertedCurrency,
      onChanged: (String? newValue) {
        if (newValue != null) {
          if (widget.setCurrentCurrencySelected != null) {
            widget.setCurrentCurrencySelected!(newValue);
            widget.controller.saveInCache(newValue, TypeDropDown.base);
          } else if (widget.setCurrentConvertedCurrency != null) {
            widget.setCurrentConvertedCurrency!(newValue);
            widget.controller.saveInCache(newValue, TypeDropDown.converted);

          }
        }
      },
      items: SingtonService().currencies!.map<DropdownMenuItem<String>>(
        (CurrenciesModel data) {
          return DropdownMenuItem<String>(
            value: data.currency,
            child: Text(
              data.currency,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ).toList(),
      decoration: InputDecoration(
        hintText: widget.setCurrentCurrencySelected != null
            ? 'Selecione a moeda base'
            : 'Selecione a moeda para converter',
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          if (widget.setCurrentCurrencySelected != null) {
            return 'Por favor, selecione a moeda base.';
          } else if (widget.setCurrentConvertedCurrency != null) {
            return 'Por favor, selecione uma moeda para converter.';
          }
        }
        return null;
      },
    );
  }
}
