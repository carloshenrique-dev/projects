import 'package:up_codebar/app/core/models/default_return_model.dart';
import 'package:up_codebar/app/core/models/licencas_model.dart';

abstract class AuthRepository {
  Future<List<LicencasModel>> getLicencasCodebar();
  Future<DefaultReturnModel> vinculaLicenca(
      {required String sequencia,
      required String dispositivo,
      required String senha});
}
