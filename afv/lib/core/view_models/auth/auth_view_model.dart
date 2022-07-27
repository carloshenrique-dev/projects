import 'package:up_afv/core/models/api/api_return_auth_model.dart';
import 'package:up_afv/core/models/auth/auth_model.dart';

abstract class AuthViewModel {
  Future<ApiReturnAuthModel> doAuth({required AuthModel authModel});
}
