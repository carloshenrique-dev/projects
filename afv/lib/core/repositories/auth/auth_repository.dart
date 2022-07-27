import 'package:up_afv/core/models/api/api_return_auth_model.dart';
import 'package:up_afv/core/models/auth/auth_model.dart';

abstract class AuthRepository {
  Future<ApiReturnAuthModel> doAuth({required AuthModel authModel});
}
