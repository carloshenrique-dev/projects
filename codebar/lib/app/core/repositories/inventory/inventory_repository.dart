import 'package:up_codebar/app/core/models/default_return_model.dart';

abstract class InventoryRepository {
  Future<DefaultReturnModel> setItemInventario({
    required int codProd,
    required String codEtiqueta,
    required double qtd,
    required String usuario,
  });
}
