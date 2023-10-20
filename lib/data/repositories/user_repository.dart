import 'package:loggy/loggy.dart';
import 'package:prueba_tecnica_consware/data/datasources/local/user_local_datasource_sqflite.dart';
import 'package:prueba_tecnica_consware/data/models/user.dart';
import 'package:prueba_tecnica_consware/domain/repositories/user_repository.dart';

class UserRepositoryIml extends UserRepository {
  late UserLocalDataSource localDataSource;

  UserRepositoryIml() {
    localDataSource = UserLocalDataSource();
  }
  
  @override
  Future<User> getUser(String email) async {
    logInfo('Obteniendo usuario  con $email de la base de datos');
    User user = await localDataSource.getUser(email);
    return Future.value(user);
  }
}
