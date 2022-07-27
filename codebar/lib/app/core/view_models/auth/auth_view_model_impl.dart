import 'package:up_codebar/app/core/models/default_return_model.dart';
import 'package:up_codebar/app/core/models/licencas_model.dart';
import 'package:up_codebar/app/core/repositories/auth/auth_repository.dart';
import './auth_view_model.dart';

class AuthViewModelImpl implements AuthViewModel {
  final AuthRepository _authRepository;
  AuthViewModelImpl({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<List<LicencasModel>> getLicencasCodebar() =>
      _authRepository.getLicencasCodebar();

  @override
  Future<DefaultReturnModel> vinculaLicenca(
          {required String sequencia,
          required String dispositivo,
          required String senha}) =>
      _authRepository.vinculaLicenca(
          sequencia: sequencia, dispositivo: dispositivo, senha: senha);
}
