import 'package:currency_converter/controllers/currency_controller.dart';
import 'package:flutter/material.dart';

class ButtonHandleForm extends StatefulWidget {
  const ButtonHandleForm({
    super.key,
    required this.controller,
  });

  final CurrencyController controller;

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
              onError(String error) {
                final snackBar = SnackBar(
                  content: Text(error),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

              if (FocusScope.of(context).focusedChild != null) {
                FocusScope.of(context).focusedChild!.unfocus();
              }

              widget.controller.handleConverter(onError);
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
