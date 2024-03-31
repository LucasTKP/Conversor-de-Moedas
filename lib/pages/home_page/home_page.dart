import 'package:currency_converter/controllers/currency_controller.dart';
import 'package:currency_converter/models/general.dart';
import 'package:currency_converter/pages/home_page/widgets/button_handleForm.dart';
import 'package:currency_converter/pages/home_page/widgets/select_currency_dropdowns.dart';
import 'package:currency_converter/pages/home_page/widgets/select_quantity.dart';
import 'package:currency_converter/pages/home_page/widgets/show_response.dart';
import 'package:currency_converter/service/dio_service_imp.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CurrencyController controller = CurrencyController(DioServiceImp());

  setCurrentSelectedCurrency(String value) {
    setState(() => controller.currentCurrencySelected = value);
  }

  setCurrentConvertedCurrency(String value) {
    setState(() => controller.currentConvertedCurrency = value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInCache();
  }

  void getInCache() async {
    final base = await controller.getInCache(TypeDropDown.base);
    final converted = await controller.getInCache(TypeDropDown.converted);

    if (base != null) {
      setState(() {
        controller.currentCurrencySelected = base;
      });
    }

    if (converted != null) {
      setState(() {
        controller.currentConvertedCurrency = converted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        body: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Bem Vindo",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      "ao conversor de moedas",
                      style: TextStyle(fontSize: 23),
                    ),
                    Form(
                      key: controller.formKey,
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectCurrencyDropDown(
                              setCurrentConvertedCurrency:
                                  setCurrentConvertedCurrency,
                              setCurrentSelectedCurrency:
                                  setCurrentSelectedCurrency,
                              controller: controller,
                            ),
                            SelectedQuantity(controller: controller),
                            ButtonHandleForm(
                              controller: controller,
                            ),
                            ShowResponse(controller: controller)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: controller.isLoading,
              builder: (context, isLoadingValue, child) {
                return Visibility(
                  visible: isLoadingValue,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black.withOpacity(0.6),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
