import 'package:up_codebar/app/core/models/default_return_model.dart';
import 'package:up_codebar/app/core/repositories/inventory/inventory_repository.dart';
import './inventory_view_model.dart';

class InventoryViewModelImpl implements InventoryViewModel {
  final InventoryRepository _inventoryRepository;
  InventoryViewModelImpl({
    required InventoryRepository inventoryRepository,
  }) : _inventoryRepository = inventoryRepository;

  @override
  Future<DefaultReturnModel> setItemInventario(
          {required int codProd,
          required String codEtiqueta,
          required double qtd,
          required String usuario}) =>
      _inventoryRepository.setItemInventario(
          codProd: codProd,
          codEtiqueta: codEtiqueta,
          qtd: qtd,
          usuario: usuario);
}
