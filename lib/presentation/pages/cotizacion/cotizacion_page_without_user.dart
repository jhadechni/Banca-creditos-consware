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

class CotizacionPageNoUser extends StatelessWidget {
  final Credito credito;
  const CotizacionPageNoUser({super.key, required this.credito});

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
                              loanTermInMonths: int.parse(credito.term)),
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
                              loanTermInMonths: int.parse(credito.term)))
                          }),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

