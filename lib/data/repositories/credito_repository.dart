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
    @override
  Future<List<Map<String, dynamic>>> getAllCotizaciones(String email) async {
    try {
      logInfo('obteniendo creditos de $email en la base de datos');
      var cotizaciones = await localDataSource.getAllCotizacionesByUser(email);
      return Future.value(cotizaciones);
    } catch (e) {
      logError(e.toString());
      return Future.error(e.toString());
    }
  }

  @override
  Future<Credito> getCotizacion(int id) async {
    try {
      logInfo('obteniendo credito con $id en la base de datos');
      var cotizacion = await localDataSource.getCotizacion(id);
      return Future.value(cotizacion);
    } catch (e) {
      logError(e.toString());
      return Future.error(e.toString());
    }
  }
}
