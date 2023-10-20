
import 'package:prueba_tecnica_consware/data/models/user.dart';

abstract class AuthenticationRepository {
  //Future<User> logIn(Map <String,String> params);
  Future<User> signUp(User user);
}
