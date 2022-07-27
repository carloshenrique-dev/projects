import 'package:up_codebar/app/core/models/default_return_model.dart';
import 'package:up_codebar/app/core/services/api_services.dart';
import './login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final ApiServices _apiServices;
  LoginRepositoryImpl({
    required ApiServices apiServices,
  }) : _apiServices = apiServices;
  @override
  Future<DefaultReturnModel> doLogin(
      {required String usuario, required String senha}) async {
    try {
      final body = await _apiServices.genericPost(
          map: {'USUARIO': usuario, 'SENHA': senha},
          endPoint: ('GetLogin/getLogin'));
      return DefaultReturnModel(
          msgRetorno: body['msg_retorno'], codRetorno: body['cod_retorno']);
    } catch (e) {
      return DefaultReturnModel(
          msgRetorno: 'Erro ao realizar login', codRetorno: 0);
    }
  }
}
