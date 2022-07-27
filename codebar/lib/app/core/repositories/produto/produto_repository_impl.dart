import 'package:up_codebar/app/core/models/default_return_model.dart';
import 'package:up_codebar/app/core/models/produto_model.dart';
import 'package:up_codebar/app/core/models/tipo_setor_estoque_model.dart';
import 'package:up_codebar/app/core/services/api_services.dart';
import './produto_repository.dart';

class ProdutoRepositoryImpl implements ProdutoRepository {
  final ApiServices _apiServices;
  ProdutoRepositoryImpl({
    required ApiServices apiServices,
  }) : _apiServices = apiServices;

  @override
  Future<List<ProdutoModel>> getProdutos(
      {required int codLote, required int tipoSetor}) async {
    try {
      final body = await _apiServices.genericPost(
        map: {'COD_LOTE': codLote, 'TIPO_SETOR': tipoSetor},
        endPoint: 'GetItensLoteMerc/getItensLoteMerc',
      );
      List lotesAbertos = body['getItensLoteMerc'];
      return lotesAbertos.map((data) => ProdutoModel.fromJson(data)).toList();
    } catch (e) {
      return <ProdutoModel>[];
    }
  }

  @override
  Future<List<TipoSetorEstoqueModel>> getTipoSetorEstoque(
      {required int codLote}) async {
    try {
      final body = await _apiServices.genericPost(
          map: {'COD_LOTE': codLote},
          endPoint: 'GetTipoSetorEstoque/getTipoSetorEstoque');
      List tipoSetorEstoque = body['getTiposSetorEstoque'];
      return TipoSetorEstoqueModel.fromJsonList(tipoSetorEstoque);
    } catch (e) {
      return <TipoSetorEstoqueModel>[];
    }
  }

  @override
  Future<DefaultReturnModel> deleteItensLote(
      {required int codLote, required int codProd}) async {
    try {
      final body = await _apiServices.genericPost(
          map: {'COD_LOTE': codLote, 'COD_PROD': codProd},
          endPoint: 'DelItemLote/DelItemLote');
      return DefaultReturnModel(
          msgRetorno: body['msg_retorno'], codRetorno: body['cod_retorno']);
    } catch (e) {
      return DefaultReturnModel(
          msgRetorno: 'Erro ao limpar o item', codRetorno: 0);
    }
  }
}
