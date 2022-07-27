import 'package:up_codebar/app/core/models/default_return_model.dart';

abstract class LoginRepository {
  Future<DefaultReturnModel> doLogin(
      {required String usuario, required String senha});
}
