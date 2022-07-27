import 'package:up_codebar/app/core/models/barcode_scanner_model.dart';
import 'package:up_codebar/app/core/services/api_services.dart';
import './barcode_repository.dart';

class BarcodeRepositoryImpl implements BarcodeRepository {
  final ApiServices _apiServices;
  BarcodeRepositoryImpl({
    required ApiServices apiServices,
  }) : _apiServices = apiServices;

  @override
  Future<BarCodeModel> setItensLote({
    required int codLote,
    required int codProd,
    required double qtdDigitada,
    required String codEtiqueta,
    required String usuarioCodeBar,
  }) async {
    try {
      final body = await _apiServices.genericPost(map: {
        'COD_LOTE': codLote,
        'COD_PROD': codProd,
        'PESO_CX': 1,
        'COD_ETIQUETA': codEtiqueta,
        'USUARIO_CODEBAR': usuarioCodeBar,
        'QTD_DIGITADA': qtdDigitada,
        'SISTEMA': 'UP_CODEBAR',
        'ROTINA': 'CONFERENCIA'
      }, endPoint: ('SetItensLote/setItensLote'));
      return BarCodeModel(
          msgRetorno: body['msg_retorno'], codRetorno: body['cod_retorno']);
    } catch (e) {
      return BarCodeModel(msgRetorno: '', codRetorno: 0);
    }
  }

  @override
  Future<BarCodeModel> setItensPedido(
      {required int codPed,
      required int item,
      required int numCaixa,
      required int codProd,
      required double pesoCx,
      required int qtdEtiq,
      required String codEtiqueta,
      required String usuarioCodeBar}) async {
    try {
      final body = await _apiServices.genericPost(map: {
        'COD_PED': codPed,
        'ITEM': item,
        'NUM_CAIXA': numCaixa,
        'COD_PROD': codProd,
        'PESO_CX': pesoCx,
        'COD_ETIQUETA': codEtiqueta,
        'QTD_ETIQ': qtdEtiq,
        'USUARIO_CODEBAR': usuarioCodeBar,
        'SISTEMA': 'UP_CODEBAR',
        'ROTINA': 'CONFERENCIA'
      }, endPoint: ('SetItensPedido/setItensPedido'));
      return BarCodeModel(
          msgRetorno: body['msg_retorno'], codRetorno: body['cod_retorno']);
    } catch (e) {
      return BarCodeModel(msgRetorno: '', codRetorno: 0);
    }
  }
}
