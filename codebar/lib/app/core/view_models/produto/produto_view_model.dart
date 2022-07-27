import 'package:up_codebar/app/core/models/default_return_model.dart';
import 'package:up_codebar/app/core/models/produto_model.dart';
import 'package:up_codebar/app/core/models/tipo_setor_estoque_model.dart';

abstract class ProdutoViewModel {
  Future<List<ProdutoModel>> getProdutos(
      {required int codLote, required int tipoSetor});
  Future<List<TipoSetorEstoqueModel>> getTipoSetorEstoque(
      {required int codLote});
  Future<DefaultReturnModel> deleteItensLote(
      {required int codLote, required int codProd});
}
