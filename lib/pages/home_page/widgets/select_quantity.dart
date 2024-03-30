import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectedQuantity extends StatefulWidget {
  const SelectedQuantity({super.key, required this.quantityController});
  final TextEditingController quantityController;

  @override
  State<SelectedQuantity> createState() => _SelectedQuantityState();
}

class _SelectedQuantityState extends State<SelectedQuantity> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          child: TextFormField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um número.';
                }
                return null;
              },
              controller: widget.quantityController,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                hintText: 'Digite o valor a ser convertido',
              )),
        ),
      ],
    );
  }
}
