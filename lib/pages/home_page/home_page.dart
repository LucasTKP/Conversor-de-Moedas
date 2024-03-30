import 'package:currency_converter/controllers/coins_controller.dart';
import 'package:currency_converter/pages/home_page/widgets/button_handleForm.dart';
import 'package:currency_converter/pages/home_page/widgets/select_coins.dart';
import 'package:currency_converter/pages/home_page/widgets/select_quantity.dart';
import 'package:currency_converter/pages/home_page/widgets/show_response.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CoinsController controller = CoinsController();
  List<String> coins = [];
  String? currentCoinSelected;
  String? currentConvertedCurrency;
  final quantityController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ValueNotifier<String?> convertedValue = ValueNotifier<String?>(null);

  setCurrentCoinSelected(String value) {
    setState(() => currentCoinSelected = value);
  }

  setCurrentConvertedCurrency(String value) {
    setState(() => currentConvertedCurrency = value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CoinsController.getCurrencies().then((value) {
      setState(() {
        coins = value;
      });
    });
    getInCache();
  }

  void getInCache() async {
    final response = await controller.getInCache();
    if (response != null) {
      setState(() {
        currentCoinSelected = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade100,
          title: const Text(
            'Cambio',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Bem Vindo",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              const Text(
                "ao conversor de moedas",
                style: TextStyle(fontSize: 23),
              ),
              Form(
                key: formKey,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectCoins(
                        currentConvertedCurrency: currentConvertedCurrency,
                        setCurrentConvertedCurrency:
                            setCurrentConvertedCurrency,
                        setCurrentCoinSelected: setCurrentCoinSelected,
                        currentCoinSelected: currentCoinSelected,
                        formKey: formKey,
                        controller: controller,
                      ),
                      SelectedQuantity(quantityController: quantityController),
                      ButtonHandleForm(
                        quantity: quantityController,
                        controller: controller,
                        formKey: formKey,
                        currentCoinSelected: currentCoinSelected,
                        currentConvertedCurrency: currentConvertedCurrency,
                        convertedValue: convertedValue,
                      ),
                      ShowResponse(
                        currentCoinSelected: currentCoinSelected,
                        currentConvertedCurrency: currentConvertedCurrency,
                        convertedValue: convertedValue, quantity: quantityController.text,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
