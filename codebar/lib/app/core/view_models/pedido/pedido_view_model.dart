import 'package:up_codebar/app/core/models/default_return_model.dart';
import 'package:up_codebar/app/core/models/itens_pedido_model.dart';
import 'package:up_codebar/app/core/models/pedido_model.dart';

abstract class PedidoViewModel {
  Future<List<PedidoModel>> getPedidos({required int codLote});
  Future<List<ItensPedidoModel>> getItensPedido({required int codPed});
  Future<DefaultReturnModel> deleteItensPedido({required int codPed});
  Future<DefaultReturnModel> deleteItemIndivPedido(
      {required int codPed, required int item});
}
