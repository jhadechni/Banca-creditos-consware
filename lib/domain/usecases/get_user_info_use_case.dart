import 'package:loggy/loggy.dart';
import 'package:prueba_tecnica_consware/app/core/usecases/param_usecase.dart';
import 'package:prueba_tecnica_consware/data/models/user.dart';
import 'package:prueba_tecnica_consware/domain/repositories/user_repository.dart';


class UserInfoUseCase extends ParamUseCase<User, String> {
  final UserRepository _repo;
  UserInfoUseCase(this._repo);

  @override
  Future<User> execute(String email) {
    logInfo('obteniendo usuario con email $email');
    return _repo.getUser(email);
  }
}
