import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:prueba_tecnica_consware/app/util/notification.dart';
import 'package:prueba_tecnica_consware/data/models/user.dart';
import '../../../app/services/local_storage.dart';
import '../../../domain/usecases/sign_up_use_case.dart';

class AuthController extends GetxController {
  AuthController(this._signUseCase);
  final SignUpUseCase _signUseCase;
  NotificationBuilder notificationBuilder = NotificationBuilder();
  final store = Get.find<LocalStorageService>();
  var isLoggedIn = false.obs;

  @override
  void onInit() async {
    super.onInit();
    isLoggedIn.value = await isLoogged;
  }

  Future<bool> logIn(String username, String password) async {
    try {
      String localUsername = await getUsername;
      String localPassword = await getPassword;
      if (localUsername == username && localPassword == password) {
        isLoggedIn.value = true;
        isLoggedIn.refresh();
        await store.storeData('logged', isLoggedIn);
        return Future.value(true);
      }
      throw 'Credenciales incorrectas';
    } catch (error) {
      logError(error);
      isLoggedIn.value = false;
      notificationBuilder.showErrorSnackbar('Error', error.toString());
      return Future.value(false);
    }
  }

  Future<bool> signUp(User user) async {
    try {
      logInfo('Desde controlador ${user.toJson()}');
      await _signUseCase.execute(user);
      await store.storeData('username', user.email);
      await store.storeData('password', user.password);
      await logIn(user.email, user.password);
      return Future.value(true);
    } catch (error) {
      logError(error);
      Get.snackbar('Inicio de sesión', 'Inicio de sesión no exitoso');
      isLoggedIn.value = false;
      return Future.value(false);
    }
  }

  Future<bool> get isLoogged async =>
      await store.retrieveData<bool>('logged') ?? false;

  Future<String> get getUsername async =>
      await store.retrieveData<String>('username') ?? '';

  Future<String> get getPassword async =>
      await store.retrieveData<String>('password') ?? '';

}
