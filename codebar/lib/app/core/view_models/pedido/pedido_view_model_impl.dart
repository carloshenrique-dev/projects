import 'package:up_codebar/app/core/models/default_return_model.dart';
import 'package:up_codebar/app/core/models/pedido_model.dart';
import 'package:up_codebar/app/core/models/itens_pedido_model.dart';
import 'package:up_codebar/app/core/repositories/pedido/pedido_repository.dart';
import './pedido_view_model.dart';

class PedidoViewModelImpl implements PedidoViewModel {
  final PedidoRepository _pedidoRepository;
  PedidoViewModelImpl({
    required PedidoRepository pedidoRepository,
  }) : _pedidoRepository = pedidoRepository;
  @override
  Future<List<ItensPedidoModel>> getItensPedido({required int codPed}) =>
      _pedidoRepository.getItensPedido(codPed: codPed);

  @override
  Future<List<PedidoModel>> getPedidos({required int codLote}) =>
      _pedidoRepository.getPedidos(codLote: codLote);

  @override
  Future<DefaultReturnModel> deleteItensPedido({required int codPed}) =>
      _pedidoRepository.deleteItensPedido(codPed: codPed);

  @override
  Future<DefaultReturnModel> deleteItemIndivPedido(
          {required int codPed, required int item}) =>
      _pedidoRepository.deleteItemIndivPedido(codPed: codPed, item: item);
}
