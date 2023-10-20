import 'package:prueba_tecnica_consware/data/models/user.dart';

abstract class UserRepository {
  Future<User> getUser(String email);
}
