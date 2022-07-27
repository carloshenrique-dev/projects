import 'package:up_codebar/app/core/models/default_return_model.dart';
import 'package:up_codebar/app/core/models/itens_pedido_model.dart';
import 'package:up_codebar/app/core/models/pedido_model.dart';
import 'package:up_codebar/app/core/services/api_services.dart';
import './pedido_repository.dart';

class PedidoRepositoryImpl implements PedidoRepository {
  final ApiServices _apiServices;
  PedidoRepositoryImpl({
    required ApiServices apiServices,
  }) : _apiServices = apiServices;

  @override
  Future<List<ItensPedidoModel>> getItensPedido({required int codPed}) async {
    try {
      final body = await _apiServices.genericPost(
          map: {'COD_PED': codPed}, endPoint: 'GetItensPedido/getItensPedido');
      List lotesAbertos = body['getItensPedido'];
      return lotesAbertos
          .map((data) => ItensPedidoModel.fromJson(data))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<PedidoModel>> getPedidos({required int codLote}) async {
    try {
      final body = await _apiServices.genericPost(
          map: {'COD_LOTE': codLote},
          endPoint: 'GetPedidosLote/getPedidosPorLote');
      List lotesAbertos = body['getPedidosLote'];
      return lotesAbertos.map((data) => PedidoModel.fromJson(data)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<DefaultReturnModel> deleteItensPedido({required int codPed}) async {
    try {
      final body = await _apiServices.genericPost(
          map: {'COD_PED': codPed}, endPoint: 'DelItensPedido/delItensPedido');
      return DefaultReturnModel(
          msgRetorno: body['msg_retorno'], codRetorno: body['cod_retorno']);
    } catch (e) {
      return DefaultReturnModel(
          msgRetorno: 'Erro ao limpar o item', codRetorno: 0);
    }
  }

  @override
  Future<DefaultReturnModel> deleteItemIndivPedido(
      {required int codPed, required int item}) async {
    try {
      final body = await _apiServices.genericPost(
          map: {'COD_PED': codPed, 'ITEM': item},
          endPoint: 'DelIndivItensPorPedido/delIndivItensPorPedido');
      return DefaultReturnModel(
          msgRetorno: body['msg_retorno'], codRetorno: body['cod_retorno']);
    } catch (e) {
      return DefaultReturnModel(
          msgRetorno: 'Erro ao limpar o item', codRetorno: 0);
    }
  }
}
