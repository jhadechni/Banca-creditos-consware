import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_consware/app/util/colors.dart';
import 'package:prueba_tecnica_consware/app/util/create_excel.dart';
import 'package:prueba_tecnica_consware/app/util/currency_formatter.dart';
import 'package:prueba_tecnica_consware/app/util/generate_amortization_table.dart';
import 'package:prueba_tecnica_consware/data/models/credito.dart';
import 'package:prueba_tecnica_consware/data/models/user.dart';
import 'package:prueba_tecnica_consware/presentation/controllers/user/user_controller.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/button.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/table.dart';

class CotizacionPage extends StatelessWidget {
  final Credito credito;
  final User user;
  const CotizacionPage({super.key, required this.credito, required this.user});

  @override
  Widget build(BuildContext context) {
    List<List<String>> eliminarCampo(
        List<List<String>> tabla, int indiceCampo) {
      for (int i = 0; i < tabla.length; i++) {
        if (indiceCampo < tabla[i].length) {
          tabla[i].removeAt(indiceCampo);
        }
      }
      return tabla;
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: SizedBox(
                    width: 50,
                    height: 50,
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
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Palette.kPrimaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: const Text(
                            'Resultado de tu simulador de crédito',
                            style: TextStyle(
                                fontSize: 25,
                                color: Palette.kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.notifications_on_outlined),
                      ],
                    ),
                  ),
                  const Text(
                      'Te presentamos en tu tabla de amortización el resultado del movimiento de tu crédito.',
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: const Text(
                            'Tabla de créditos',
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(
                            width: 32,
                            height: 29,
                            child: Image(
                                image:
                                    AssetImage('assets/images/settings.png'))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 17, bottom: 21),
                    child: CustomTable(
                      rowNames: const [
                        'No. Cuota',
                        'Valor de cuota',
                        'Interés',
                        'Abono a capital'
                      ],
                      data: eliminarCampo(
                          generateAmortizationTable(
                              loanAmount: double.parse(Formatter.unFormatNumberCOP(credito.maximoPrestamo)),
                              annualInterestRate: credito.anualInterest,
                              loanTermInMonths: credito.term),
                          4),
                      columnTextColors: const [
                        Colors.black,
                        Palette.kGray,
                        Colors.black,
                        Palette.kGreen
                      ],
                    ),
                  ),
                  CustomButton(
                      text: 'Descargar tabla',
                      color: Palette.kPrimaryColor,
                      textColor: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.92,
                      height: 50,
                      onPressed: () => {
                            createExcel(generateAmortizationTable(
                              loanAmount: double.parse(Formatter.unFormatNumberCOP(credito.maximoPrestamo)),
                              annualInterestRate: credito.anualInterest,
                              loanTermInMonths: credito.term))
                          }),
                  Padding(
                    padding: const EdgeInsets.only(top: 9),
                    child: CustomButton(
                        text: 'Guardar cotización',
                        color: Colors.white,
                        textColor: Palette.kPrimaryColor,
                        width: MediaQuery.of(context).size.width * 0.92,
                        height: 50,
                        borderColor: Palette.kPrimaryColor,
                        onPressed: () => {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomModal(
                                        credito: credito,
                                        user: user,
                                      ))
                            }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class CustomModal extends StatelessWidget {
  final Credito credito;
  final User user;

  const CustomModal({
    Key? key,
    required this.credito,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();

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
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: 50,
                      height: 50,
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
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                          width: 70,
                          height: 70,
                          child: Image(
                              image:
                                  AssetImage('assets/images/info-circle.png'))),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 12),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: const Text(
                            '¿Está seguro que desea Guardar la cotización?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 37),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: const Text(
                            'La cotización realizada la podrás consultar en tu historial de créditos.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF525B64)),
                          ),
                        ),
                      ),
                      CustomButton(
                          text: 'Guardar',
                          color: Palette.kPrimaryColor,
                          textColor: Colors.white,
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 40,
                          onPressed: () => {
                                // Close the modal
                                userController.saveCredito(credito, user),
                                Navigator.of(context).pop()
                              }),
                      Padding(
                        padding: const EdgeInsets.only(top: 9.0),
                        child: CustomButton(
                            text: 'Cancelar',
                            color: Colors.white,
                            textColor: Palette.kPrimaryColor,
                            width: MediaQuery.of(context).size.width * 0.9,
                            borderColor: Palette.kPrimaryColor,
                            height: 40,
                            onPressed: () => {
                                  // Close the modal
                                  Navigator.of(context).pop()
                                }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
