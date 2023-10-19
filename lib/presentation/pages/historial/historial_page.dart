import 'package:flutter/material.dart';
import 'package:prueba_tecnica_consware/app/util/colors.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/button.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/table.dart';

class HistorialPage extends StatelessWidget {
  const HistorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
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
                      'Historial de créditos',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.notifications_on_outlined),
                ],
              ),
            ),
            const Text(
                'Aquí encontrarás tu historial de créditos y el registro de todas tus simulaciones.',
                style: TextStyle(fontSize: 16, color: Colors.black)),
            const Padding(
              padding: EdgeInsets.only(top: 17, bottom: 21),
              child: CustomTable(
                rowNames: [
                  'Monto de crédito',
                  'Fecha',
                  'No. de cuotas',
                  'Interés'
                ],
                data: [
                  ['12000000', '12/10/23', '10', 'abono'],
                  ['12000000', '20', '10', 'abono'],
                  ['12000000', '20', '10', 'abono'],
                  ['12000000', '20', '10', 'abono'],
                  ['12000000', '20', '10', 'abono'],
                  ['12000000', '20', '10', 'abono'],
                  ['12000000', '20', '10', 'abono'],
                  ['12000000', '20', '10', 'abono'],
                  ['12000000', '20', '10', 'abono'],
                  ['12000000', '20', '10', 'abono'],
                ],
                columnTextColors: [
                  Palette.kGray,
                  Colors.black,
                  Colors.black,
                  Colors.black
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, color: Palette.kGray),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'No hay mas datos por mostrar',
                    style: TextStyle(
                        color: Color.fromARGB(255, 155, 159, 165),
                        fontSize: 14),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
