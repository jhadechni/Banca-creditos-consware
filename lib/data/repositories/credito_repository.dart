import 'package:loggy/loggy.dart';
import 'package:prueba_tecnica_consware/data/datasources/local/cotizaciones_local_datasource_sqflite.dart';
import 'package:prueba_tecnica_consware/data/models/credito.dart';
import 'package:prueba_tecnica_consware/domain/repositories/credito_repository.dart';

class CreditoRepositoryIml extends CreditoRepository {
  late CotizacionLocalDataSource localDataSource;

  CreditoRepositoryIml() {
    localDataSource = CotizacionLocalDataSource();
  }

  @override
  Future<bool> guardarCotizacion(Credito credito) async {
    try {
      logInfo('Guardando cotizacion con ${credito.id} en la base de datos');
      localDataSource.addCotizacion(credito);
      return Future.value(true);
    } catch (e) {
      logError(e.toString());
      return Future.value(false);
    }
  }
}
