
import 'package:prueba_tecnica_consware/data/models/user.dart';

abstract class AuthenticationRepository {
  Future<User> signUp(User user);
}
