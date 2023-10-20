import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:prueba_tecnica_consware/app/services/local_storage.dart';
import 'package:prueba_tecnica_consware/data/models/credito.dart';
import 'package:prueba_tecnica_consware/data/models/user.dart';
import 'package:prueba_tecnica_consware/domain/usecases/get_all_creditos_use_case.dart';
import 'package:prueba_tecnica_consware/domain/usecases/get_user_info_use_case.dart';
import 'package:prueba_tecnica_consware/domain/usecases/guardar_credito_use_case.dart';

class UserController extends GetxController {
  UserController(this._userInfo, this._saveCredito,this._getAllCreditosUseCase);
  final UserInfoUseCase _userInfo;
  final SaveCreditoUseCase _saveCredito;
  final GetAllCreditosUseCase _getAllCreditosUseCase;

  final store = Get.find<LocalStorageService>();

  Future<User> getUser(String email) async {
    try {
      User user = await _userInfo.execute(email);
      logInfo('getted user ${user.name}');
      return user;
    } catch (error) {
      Get.snackbar('Error', error.toString());
      return Future.error(error.toString());
    }
  }


  Future<bool> saveCredito(Credito credito, User user) {
    logDebug('saving credito ${credito.toJson()} for user ${user.name}');
    return Future.value(_saveCredito.execute(credito));
  }

  Future<List<Map<String,dynamic>>> getAllCreditos(String email){
    logDebug('mostrando creditos de $email');
    return Future.value(_getAllCreditosUseCase.execute(email));
  }

  Future<Credito> getCotizacion(int idCredito){
    logDebug('mostrando credito con id $idCredito');
    return Future.value(_getAllCreditosUseCase.executeGetCredito(idCredito));
  }

  Future<String> get getLocalEmail async =>
      await store.retrieveData<String>('username') ?? '';
}
