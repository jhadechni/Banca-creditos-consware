import 'package:loggy/loggy.dart';
import 'package:prueba_tecnica_consware/app/core/usecases/param_usecase.dart';
import 'package:prueba_tecnica_consware/data/models/credito.dart';
import 'package:prueba_tecnica_consware/domain/repositories/credito_repository.dart';

class GetAllCreditosUseCase{
  final CreditoRepository _repo;
  GetAllCreditosUseCase(this._repo);

  @override
  Future<List<Map<String, dynamic>>> execute(String email) {
    logInfo('obteniendo creditos de $email en la base de datos');
    return _repo.getAllCotizaciones(email);
  }

  Future<Credito> executeGetCredito(int id) {
    logInfo('obteniendo creditos de $id en la base de datos');
    return _repo.getCotizacion(id);
  }
}