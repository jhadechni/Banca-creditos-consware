import 'package:loggy/loggy.dart';
import 'package:prueba_tecnica_consware/data/models/user.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthenticationRepositoryIml extends AuthenticationRepository {

  @override
  Future<User> signUp(User user) async {
    logInfo('Desde repositorio ${user.toJson()}');
    return Future.value(user);
  }
}
