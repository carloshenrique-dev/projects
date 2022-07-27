import 'package:up_afv/core/models/api/api_return_login_model.dart';
import 'package:up_afv/core/models/login/login_model.dart';
import 'package:up_afv/core/models/configs/preferences_model.dart';

abstract class LoginRepository {
  Future<ApiReturnLoginModel> doLogin({required LoginModel loginModel});
  Future setDevice({required int sellerCode, required String deviceId});
  Future<List<PreferencesModel>> getPreferences();
  Future<bool> doLogout();
}
