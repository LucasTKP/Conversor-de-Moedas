import 'package:currency_converter/controllers/currency_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShowResponse extends StatefulWidget {
  const ShowResponse({super.key, required this.controller});
  final CurrencyController controller;
  @override
  State<ShowResponse> createState() => _ShowResponseState();
}

class _ShowResponseState extends State<ShowResponse> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ValueListenableBuilder<String?>(
          valueListenable: widget.controller.convertedValue,
          builder: (context, value, child) {
            if (value != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Resultado',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    'Moeda base: ${widget.controller.currentCurrencySelected}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Moeda a ser convertida: ${widget.controller.currentConvertedCurrency}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Valor a ser convertido: ${widget.controller.quantityController.text}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Resultado da conversão é: $value',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
