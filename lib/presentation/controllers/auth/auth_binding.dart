import 'package:get/get.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../domain/usecases/sign_up_use_case.dart';
import 'auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpUseCase(Get.find<AuthenticationRepositoryIml>()));
    Get.put(AuthController(Get.find()), permanent: true);
  }
}