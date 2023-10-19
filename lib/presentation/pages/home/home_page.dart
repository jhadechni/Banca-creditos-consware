import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_consware/app/util/colors.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/button.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/dropbox.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/input.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 33),
              child: Row(
                children: [
                  Text(
                    'Hola Jesús G.  👋',
                    style: TextStyle(fontSize: 22),
                  ),
                  Spacer(),
                  Icon(Icons.notifications_on_outlined),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Simulador de crédito',
                    style: TextStyle(
                        fontSize: 25,
                        color: Palette.kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: IconButton(
                      onPressed: () => {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) => const CustomModal(
                              maxLoan: '185.798.098,00',
                              anualInterestRate: 43.26,
                              monthlyInterestRate: 3.04,
                              totalValue: 950,
                              monthlyFee: 1112501),
                        )},
                      icon: const Icon(Icons.info_outline),
                      color: Palette.kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 18),
              child: Text(
                'Ingresa los datos para tu crédito según lo que necesites.',
                style: TextStyle(fontSize: 18),
              ),
            ),
            CustomDropdown(
              items: const [
                'Crédito de vehículo',
                'Crédito de vivienda',
                'Crédito de libre inversión'
              ],
              placeholder: 'Selecciona el tipo de crédito',
              width: MediaQuery.of(context).size.width * 0.87,
              label: '¿Qué tipo de créditos deseas realizar?',
            ),
            Column(
              children: [
                CustomInput(
                  placeholder: '\$1´000.000,00',
                  controller: TextEditingController(),
                  width: MediaQuery.of(context).size.width * 0.87,
                  height: 40,
                  labelText: '¿Cúal es tu salario base?',
                  textColor: Colors.black,
                  fontSize: 14,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Digíta tu salario para calcular el préstamo que necesitas',
                      style: TextStyle(fontSize: 12, color: Color(0xFF525B64)),
                    ),
                  ),
                )
              ],
            ),
            CustomInput(
              placeholder: '\$0',
              controller: TextEditingController(),
              width: MediaQuery.of(context).size.width * 0.87,
              height: 40,
              enabled: false,
              backgroundColor: const Color(0xFFE0E0E0),
            ),
            Column(
              children: [
                CustomInput(
                  placeholder: '48',
                  controller: TextEditingController(),
                  width: MediaQuery.of(context).size.width * 0.87,
                  height: 40,
                  labelText: '¿A cuántos meses?',
                  textColor: Colors.black,
                  fontSize: 14,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Elige un plazo desde 12 hata 84 meses',
                      style: TextStyle(fontSize: 12, color: Color(0xFF525B64)),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45),
              child: CustomButton(
                  text: 'Simular',
                  color: Palette.kPrimaryColor,
                  textColor: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.92,
                  height: 40,
                  onPressed: () => {Get.toNamed('/cotizacion')}),
            )
          ],
        ),
      ),
    );
  }
}

class CustomModal extends StatelessWidget {
  final String maxLoan;
  final double anualInterestRate;
  final double monthlyInterestRate;
  final double totalValue;
  final double monthlyFee;

  const CustomModal({
    Key? key,
    required this.maxLoan,
    required this.anualInterestRate,
    required this.monthlyInterestRate,
    required this.totalValue,
    required this.monthlyFee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(20), // Adjust the radius as needed
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Cuota máxima del préstamo',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$$maxLoan",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: const Text(
                          '*Este valor suele cambiar con respecto a tu salario',
                          style: TextStyle(
                            fontSize: 14,
                            color: Palette.kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        elevation: 6,
                        shadowColor: Colors.black,
                      ),
                      onPressed: () {
                        // Close the modal
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Palette.kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ModalItems(
              text1: 'Tasa Efectiva Anual desde',
              text2: '$anualInterestRate%',
            ),
            ModalItems(
              text1: 'Tasa Mensual Vencida desde',
              text2: '$monthlyInterestRate%',
            ),
            ModalItems(
              text1: 'Tasa Efectiva Anual desde',
              text2: '\$$totalValue',
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: const Text(
                      'Valor total a pagar (capital + intereses + seguro)',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text('\$${monthlyFee}',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ModalItems extends StatelessWidget {
  final String text1;
  final String text2;

  const ModalItems({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1,
            style: const TextStyle(fontSize: 18, color: Color(0xFF525B64)),
          ),
          Text(text2,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
