import 'package:up_codebar/app/core/models/default_return_model.dart';
import 'package:up_codebar/app/core/services/api_services.dart';

import './devolution_repository.dart';

class DevolutionRepositoryImpl implements DevolutionRepository {
  final ApiServices _apiServices;
  DevolutionRepositoryImpl({
    required ApiServices apiServices,
  }) : _apiServices = apiServices;
  @override
  Future<DefaultReturnModel> setItemDevol(
      {required String codEtiqueta, required String tipo}) async {
    try {
      final body = await _apiServices.genericPost(
          map: {'COD_ETIQUETA': codEtiqueta, 'TIPO': tipo},
          endPoint: 'SetItemDevol/setItemDevol');
      return DefaultReturnModel(
          msgRetorno: body['msg_retorno'], codRetorno: body['cod_retorno']);
    } catch (e) {
      return DefaultReturnModel(
          msgRetorno: 'Erro ao comunicar-se com a API', codRetorno: 0);
    }
  }
}
