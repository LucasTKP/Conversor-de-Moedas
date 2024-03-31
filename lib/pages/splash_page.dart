import 'package:currency_converter/controllers/currency_controller.dart';
import 'package:currency_converter/service/dio_service_imp.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String? error;

  CurrencyController controller = CurrencyController(DioServiceImp());

  @override
  void initState() {
    super.initState();
    controller.getCurrencies().then(
          (result) => {
            if (result == true)
              {
                //Delay para melhorar a experiência do usuário ao ver a animação
                Future.delayed(const Duration(seconds: 2)).then(
                  (value) => Navigator.pushReplacementNamed(context, '/home'),
                )
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Lottie.asset('assets/lottieCoin.json'),
            ),
          ],
        ),
      ),
    );
  }
}
