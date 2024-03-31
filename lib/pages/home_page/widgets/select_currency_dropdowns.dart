import 'package:currency_converter/components/dropdown_currency.dart';
import 'package:currency_converter/controllers/currency_controller.dart';
import 'package:flutter/material.dart';

class SelectCurrencyDropDown extends StatefulWidget {
  const SelectCurrencyDropDown({
    super.key,
    required this.setCurrentConvertedCurrency,
    required this.setCurrentSelectedCurrency,
    required this.controller,
  });
  final CurrencyController controller;
  final Function setCurrentConvertedCurrency;
  final Function setCurrentSelectedCurrency;

  @override
  State<SelectCurrencyDropDown> createState() => _SelectConverterState();
}

class _SelectConverterState extends State<SelectCurrencyDropDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        DropDownCurrency(
          setCurrentCurrencySelected: widget.setCurrentSelectedCurrency,
          controller: widget.controller,
        ),
        const SizedBox(height: 20),
        DropDownCurrency(
          setCurrentConvertedCurrency: widget.setCurrentConvertedCurrency,
          controller: widget.controller,
        ),
      ],
    );
  }
}
