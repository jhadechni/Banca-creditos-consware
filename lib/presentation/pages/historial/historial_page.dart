import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:prueba_tecnica_consware/app/util/colors.dart';
import 'package:prueba_tecnica_consware/data/models/credito.dart';
import 'package:prueba_tecnica_consware/presentation/controllers/user/user_controller.dart';
import 'package:prueba_tecnica_consware/presentation/pages/cotizacion/cotizacion_page.dart';
import 'package:prueba_tecnica_consware/presentation/pages/cotizacion/cotizacion_page_without_user.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/table.dart';

class HistorialPage extends StatefulWidget {
  String email;

  HistorialPage({super.key, required this.email});

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  UserController userController = Get.find<UserController>();
  List<Map<String, dynamic>> creditos = [];
  @override
  void initState() {
    super.initState();
    getCreditos().then((value) => setState(() {
          creditos = value;
          logDebug('creditos $creditos');
        }));
  }

  Future<List<Map<String, dynamic>>> getCreditos() async {
    UserController userController = Get.find<UserController>();
    String email = await userController.getLocalEmail;
    var creditos = await userController.getAllCreditos(email);
    return creditos;
  }

  List<List<dynamic>> transformArray(List<Map<String, dynamic>> originalArray) {
    return originalArray.map((item) {
      return [
        item['id'],
        item['maximoPrestamo'],
        item['fecha'],
        item['term'],
        item['anualInterest'],
        // Agrega más campos según sea necesario
      ];
    }).toList();
  }

  List<List<dynamic>> eliminarCampo(
      List<List<dynamic>> tabla, int indiceCampo) {
    for (int i = 0; i < tabla.length; i++) {
      if (indiceCampo < tabla[i].length) {
        tabla[i].removeAt(indiceCampo);
      }
    }
    return tabla;
  }

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
            Padding(
              padding: const EdgeInsets.only(top: 17, bottom: 21),
              child: CustomTable(
                rowNames: const [
                  'Monto de crédito',
                  'Fecha',
                  'No. de cuotas',
                  'Interés'
                ],
                data: eliminarCampo(transformArray(creditos), 0),
                onRowClick: (index) async {
                  logDebug('clicked row $index');
                  Credito cotizacion =
                      await userController.getCotizacion(index + 1);
                  Get.to(() => CotizacionPageNoUser(credito: cotizacion));
                  logDebug('cotizacion $cotizacion');
                },
                columnTextColors: const [
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
