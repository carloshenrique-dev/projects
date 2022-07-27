import 'package:up_codebar/app/core/models/default_return_model.dart';
import 'package:up_codebar/app/core/models/produto_model.dart';
import 'package:up_codebar/app/core/models/tipo_setor_estoque_model.dart';
import 'package:up_codebar/app/core/repositories/produto/produto_repository.dart';
import 'produto_view_model.dart';

class ProdutoViewModelImpl implements ProdutoViewModel {
  final ProdutoRepository _produtoRepository;
  ProdutoViewModelImpl({
    required ProdutoRepository produtoRepository,
  }) : _produtoRepository = produtoRepository;

  @override
  Future<List<ProdutoModel>> getProdutos(
          {required int codLote, required int tipoSetor}) =>
      _produtoRepository.getProdutos(codLote: codLote, tipoSetor: tipoSetor);

  @override
  Future<List<TipoSetorEstoqueModel>> getTipoSetorEstoque(
          {required int codLote}) =>
      _produtoRepository.getTipoSetorEstoque(codLote: codLote);

  @override
  Future<DefaultReturnModel> deleteItensLote(
          {required int codLote, required int codProd}) =>
      _produtoRepository.deleteItensLote(codLote: codLote, codProd: codProd);
}
