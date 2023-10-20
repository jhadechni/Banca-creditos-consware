import 'package:get/get.dart';
import 'package:prueba_tecnica_consware/data/repositories/credito_repository.dart';
import 'package:prueba_tecnica_consware/data/repositories/user_repository.dart';
import 'package:prueba_tecnica_consware/domain/usecases/get_user_info_use_case.dart';
import 'package:prueba_tecnica_consware/domain/usecases/guardar_credito_use_case.dart';
import 'package:prueba_tecnica_consware/presentation/controllers/user/user_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserInfoUseCase(Get.find<UserRepositoryIml>()));
    Get.lazyPut(() => SaveCreditoUseCase(Get.find<CreditoRepositoryIml>()));
    Get.put(UserController(Get.find(), Get.find()), permanent: true);
  }
}
