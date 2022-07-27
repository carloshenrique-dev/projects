import 'package:up_afv/core/models/login/login_model.dart';
import 'package:up_afv/core/models/api/api_return_login_model.dart';
import 'package:up_afv/core/models/configs/preferences_model.dart';
import 'package:up_afv/core/repositories/login/login_repository.dart';
import './login_view_model.dart';

class LoginViewModelImpl implements LoginViewModel {
  final LoginRepository _loginRepository;

  LoginViewModelImpl({
    required LoginRepository loginRepository,
  }) : _loginRepository = loginRepository;

  @override
  Future<ApiReturnLoginModel> doLogin({required LoginModel loginModel}) =>
      _loginRepository.doLogin(loginModel: loginModel);

  @override
  Future setDevice({required int sellerCode, required String deviceId}) =>
      _loginRepository.setDevice(sellerCode: sellerCode, deviceId: deviceId);

  @override
  Future<List<PreferencesModel>> getPreferences() =>
      _loginRepository.getPreferences();

  @override
  Future<bool> doLogout() => _loginRepository.doLogout();
}
