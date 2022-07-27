import 'package:up_afv/core/models/api/api_return_auth_model.dart';
import 'package:up_afv/core/models/auth/auth_model.dart';
import 'package:up_afv/core/repositories/auth/auth_repository.dart';
import './auth_view_model.dart';

class AuthViewModelImpl implements AuthViewModel {
  final AuthRepository _authRepository;

  AuthViewModelImpl({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<ApiReturnAuthModel> doAuth({required AuthModel authModel}) =>
      _authRepository.doAuth(authModel: authModel);
}
