import 'package:up_codebar/app/core/models/default_return_model.dart';
import 'package:up_codebar/app/core/repositories/login/login_repository.dart';
import './login_view_model.dart';

class LoginViewModelImpl implements LoginViewModel {
  final LoginRepository _loginRepository;
  LoginViewModelImpl({
    required LoginRepository loginRepository,
  }) : _loginRepository = loginRepository;

  @override
  Future<DefaultReturnModel> doLogin(
          {required String usuario, required String senha}) =>
      _loginRepository.doLogin(usuario: usuario, senha: senha);
}
