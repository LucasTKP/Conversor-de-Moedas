import 'package:currency_converter/controllers/coins_controller.dart';
import 'package:flutter/material.dart';

class SelectCoins extends StatefulWidget {
  const SelectCoins({
    super.key,
    required this.currentConvertedCurrency,
    required this.setCurrentConvertedCurrency,
    required this.setCurrentCoinSelected,
    required this.currentCoinSelected,
    required this.formKey,
    required this.controller,
  });
  final CoinsController controller;
  final String? currentConvertedCurrency;
  final Function setCurrentConvertedCurrency;
  final Function setCurrentCoinSelected;
  final String? currentCoinSelected;
  final GlobalKey<FormState> formKey;

  @override
  State<SelectCoins> createState() => _SelectConverterState();
}

class _SelectConverterState extends State<SelectCoins> {
  late List<String> coins;

  @override
  void initState() {
    super.initState();

    coins = [];
    _updateCoins();
  }

  void _updateCoins() async {
    List<String> fetchedCoins = await CoinsController.getCurrencies();
    setState(() {
      coins = fetchedCoins;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          child: DropdownButtonFormField<String>(
            value: widget.currentCoinSelected,
            onChanged: (String? newValue) {
              if (newValue != null) {
                widget.setCurrentCoinSelected(newValue);
                widget.controller.saveInCache(newValue);
              }
            },
            items: coins
                .where((element) => element != widget.currentConvertedCurrency)
                .map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ).toList(),
            decoration: const InputDecoration(
              hintText: 'Selecione a moeda base',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, selecione a moeda base.';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          child: DropdownButtonFormField<String>(
            value: widget.currentConvertedCurrency,
            onChanged: (String? newValue) {
              widget.setCurrentConvertedCurrency(newValue);
            },
            items: coins
                .where((element) => element != widget.currentCoinSelected)
                .map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ).toList(),
            decoration: const InputDecoration(
              hintText: 'Selecione a moeda para converter',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, selecione uma moeda para converter.';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
