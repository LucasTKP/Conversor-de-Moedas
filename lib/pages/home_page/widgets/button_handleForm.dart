import 'package:currency_converter/controllers/coins_controller.dart';
import 'package:flutter/material.dart';

class ButtonHandleForm extends StatefulWidget {
  const ButtonHandleForm(
      {super.key,
      required this.quantity,
      required this.controller,
      required this.formKey,
      required this.currentCoinSelected,
      required this.currentConvertedCurrency,
      required this.convertedValue});

  final TextEditingController quantity;
  final CoinsController controller;
  final GlobalKey<FormState> formKey;
  final String? currentCoinSelected;
  final String? currentConvertedCurrency;
  final ValueNotifier<String?> convertedValue;

  @override
  State<ButtonHandleForm> createState() => _ButtonHandleFormState();
}

class _ButtonHandleFormState extends State<ButtonHandleForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              final response = await widget.controller.handleConverter(
                formKey: widget.formKey,
                quantity: widget.quantity.text,
                currentCoinSelected: widget.currentCoinSelected,
                currentConvertedCurrency: widget.currentConvertedCurrency,
              );
          
              if (response != null) {
                if (response.data.containsKey('rates')) {
                  // Acessa o valor a moeda escolhida para fazer o cambio
                  widget.convertedValue.value = response.data['rates']
                          [widget.currentConvertedCurrency]
                      .toString();
                }
              }
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.blue.shade100),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            child: const Text(
              'Converter',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
