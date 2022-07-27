import 'package:up_codebar/app/core/models/default_return_model.dart';
import 'package:up_codebar/app/core/models/licencas_model.dart';
import 'package:up_codebar/app/core/services/api_services.dart';
import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiServices _apiServices;

  AuthRepositoryImpl({required ApiServices apiServices})
      : _apiServices = apiServices;

  @override
  Future<List<LicencasModel>> getLicencasCodebar() async {
    try {
      var teste = await _apiServices.genericGet(
          endPoint: 'GestaoLicencasCodebar/getLicensesCodebar');
      List licencas = teste['getLicensesCli'];
      return licencas.map((data) => LicencasModel.fromJson(data)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<DefaultReturnModel> vinculaLicenca(
      {required String sequencia,
      required String dispositivo,
      required String senha}) async {
    try {
      var retorno = await _apiServices.genericPut(map: {
        'SEQUENCIA': sequencia,
        'DISPOSITIVO': dispositivo,
        'SENHA': senha
      }, endPoint: 'VinculaLicencaCodebar/vinculaLicencaCodebar');
      return DefaultReturnModel(
          msgRetorno: retorno['msg_retorno'],
          codRetorno: retorno['cod_retorno']);
    } catch (e) {
      return DefaultReturnModel(
          msgRetorno: 'Erro ao vincular dispositivo a licenca', codRetorno: 0);
    }
  }
}
