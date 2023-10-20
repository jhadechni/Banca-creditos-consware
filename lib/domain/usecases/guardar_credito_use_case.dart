import 'package:loggy/loggy.dart';
import 'package:prueba_tecnica_consware/app/core/usecases/param_usecase.dart';
import 'package:prueba_tecnica_consware/data/models/credito.dart';
import 'package:prueba_tecnica_consware/domain/repositories/credito_repository.dart';

class SaveCreditoUseCase extends ParamUseCase<bool, Credito> {
  final CreditoRepository _repo;
  SaveCreditoUseCase(this._repo);

  @override
  Future<bool> execute(Credito credito) {
    logInfo('guardando credito ${credito.toJson()}');
    return _repo.guardarCotizacion(credito);
  }
}
