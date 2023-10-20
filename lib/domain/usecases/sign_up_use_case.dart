import 'package:loggy/loggy.dart';
import 'package:prueba_tecnica_consware/app/core/usecases/param_usecase.dart';
import 'package:prueba_tecnica_consware/data/models/user.dart';

import '../repositories/auth_repository.dart';

class SignUpUseCase extends ParamUseCase<User, User> {
  final AuthenticationRepository _repo;
  SignUpUseCase(this._repo);

  @override
  Future<User> execute(User user) {
    logInfo('Desde caso de uso ${user.toJson()}');
    return _repo.signUp(user);
  }
}
