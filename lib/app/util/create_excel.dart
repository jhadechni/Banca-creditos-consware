import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

Future<void> createExcel(List<List<String>> tabla) async {
  final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  final Workbook workbook = Workbook();
  final Worksheet sheet = workbook.worksheets[0];
  sheet.getRangeByName('A1').setText('Tabla de amortización');
  sheet.getRangeByName('A2').setText('No. Cuota');
  sheet.getRangeByName('B2').setText('Valor de cuota');
  sheet.getRangeByName('C2').setText('Interés');
  sheet.getRangeByName('D2').setText('Abono a capital');
  sheet.getRangeByName('E2').setText('Saldo del periodo');
  // Agregar nuevas filas a partir de la última fila ocupada
  for (int i = 0; i < tabla.length; i++) {
    sheet.getRangeByName('A${i + 3}').setText(tabla[i][0]);
    sheet.getRangeByName('B${i + 3}').setText(tabla[i][1]);
    sheet.getRangeByName('C${i + 3}').setText(tabla[i][2]);
    sheet.getRangeByName('D${i + 3}').setText(tabla[i][3]);
    sheet.getRangeByName('E${i + 3}').setText(tabla[i][4]);
  }

  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();
  final String path = (await getApplicationSupportDirectory()).path;
  final String fileName = '$path/tabla_amortizacion_$timestamp.xlsx';
  final File file = File(fileName);
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open(fileName);
}
