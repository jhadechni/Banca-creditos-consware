import 'package:get/get.dart';
import 'package:prueba_tecnica_consware/data/repositories/credito_repository.dart';
import 'package:prueba_tecnica_consware/domain/usecases/guardar_credito_use_case.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../domain/usecases/sign_up_use_case.dart';
import 'auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpUseCase(Get.find<AuthenticationRepositoryIml>()));
    Get.lazyPut(() => SaveCreditoUseCase(Get.find<CreditoRepositoryIml>()));
    Get.put(AuthController(Get.find()), permanent: true);
  }
}