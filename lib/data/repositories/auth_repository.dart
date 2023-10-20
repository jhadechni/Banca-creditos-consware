import 'package:loggy/loggy.dart';
import 'package:prueba_tecnica_consware/data/datasources/local/user_local_datasource_sqflite.dart';
import 'package:prueba_tecnica_consware/data/models/user.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthenticationRepositoryIml extends AuthenticationRepository {
  late UserLocalDataSource localDataSource;

  AuthenticationRepositoryIml() {
    localDataSource = UserLocalDataSource();
  }
  @override
  Future<User> signUp(User user) async {
    logInfo('Guardando usuario ${user.toJson()} en la base de datos');
    await localDataSource.addUser(user);
    user = await localDataSource.getUser(user.email);
    print(user);
    return Future.value(user);
  }
}
