import 'package:get/get.dart';
import 'package:prueba_tecnica_consware/data/repositories/credito_repository.dart';
import 'package:prueba_tecnica_consware/data/repositories/user_repository.dart';
import '../../data/repositories/auth_repository.dart';

class DependencyCreator {
  static init() {
    Get.lazyPut(() => AuthenticationRepositoryIml());
    Get.lazyPut(() => UserRepositoryIml());
    Get.lazyPut(() => CreditoRepositoryIml());
  }
}