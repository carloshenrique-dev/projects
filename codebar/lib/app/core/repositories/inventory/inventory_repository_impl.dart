import 'package:up_codebar/app/core/models/default_return_model.dart';
import 'package:up_codebar/app/core/services/api_services.dart';
import './inventory_repository.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final ApiServices _apiServices;
  InventoryRepositoryImpl({
    required ApiServices apiServices,
  }) : _apiServices = apiServices;

  @override
  Future<DefaultReturnModel> setItemInventario({
    required int codProd,
    required String codEtiqueta,
    required double qtd,
    required String usuario,
  }) async {
    try {
      final body = await _apiServices.genericPost(
        map: {
          'COD_PROD': codProd,
          'COD_ETIQUETA': codEtiqueta,
          'QTD': qtd,
          'USUARIO_CODEBAR': usuario,
          'SISTEMA': 'UpCodebar',
          'ROTINA': 'Inventario'
        },
        endPoint: 'SetItemInventario/setItemInventario',
      );
      return DefaultReturnModel(
          codRetorno: body['cod_retorno'], msgRetorno: body['msg_retorno']);
    } catch (e) {
      return DefaultReturnModel(
          codRetorno: 0, msgRetorno: 'Erro ao gravar o item no inventario');
    }
  }
}
