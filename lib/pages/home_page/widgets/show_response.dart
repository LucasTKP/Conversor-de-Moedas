import 'package:flutter/material.dart';

class ShowResponse extends StatefulWidget {
  const ShowResponse(
      {super.key,
      required this.currentCoinSelected,
      required this.currentConvertedCurrency,
      required this.convertedValue, required this.quantity});
  final String? currentCoinSelected;
  final String? currentConvertedCurrency;
  final ValueNotifier<String?> convertedValue;
  final String quantity;
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
          valueListenable: widget.convertedValue,
          builder: (context, value, child) {
            if (value != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Moeda base: ${widget.currentCoinSelected}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Moeda a ser convertida: ${widget.currentConvertedCurrency}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),

                  Text(
                    'Valor a ser convertido: ${widget.quantity}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),

                  Text(
                    'Resultado da conversão é: $value',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              );
            } else {
              // Se o valor for nulo, você pode retornar um widget vazio ou qualquer outro widget de sua escolha
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
