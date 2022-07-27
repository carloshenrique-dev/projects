import 'dart:developer';
import 'package:up_afv/core/models/products/price_list_db_model.dart';
import 'package:up_afv/core/models/products/prices_list_model.dart';
import 'package:up_afv/core/models/products/prod_model.dart';
import 'package:up_afv/core/models/products_order/products_order_model.dart';
import 'package:up_afv/core/services/api/api_provider.dart';
import 'package:up_afv/core/services/db/db_service.dart';
import 'products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ApiProvider _apiProvider;
  final DbService _dbService;
  ProductsRepositoryImpl({
    required ApiProvider apiProvider,
    required DbService dbService,
  })  : _apiProvider = apiProvider,
        _dbService = dbService;

  @override
  Future<void> getProdutos() async {
    try {
      var sellerCode = await _dbService.queryPreferences();
      if (sellerCode[0].sellerCode != null) {
        var retorno = await _apiProvider.get(
            path:
                'http://192.168.56.1:5246/Product/base/${sellerCode[0].sellerCode}');
        var lista = List<ProdModel>.from(
            retorno.data.map((model) => ProdModel.fromJson(model)).toList());
        for (var i = 0; i < lista.length; i++) {
          await _dbService.insertData(
              args: ProdModel(
                classe: lista[i].classe,
                codProd: lista[i].codProd,
                descricao: lista[i].descricao,
                estoqueInicial: lista[i].estoqueInicial,
                fatObrgMulTundsAaux: lista[i].fatObrgMulTundsAaux,
                fator: lista[i].fator,
                fatorUnid: lista[i].fatorUnid,
                imagem: lista[i].imagem,
                nbm: lista[i].nbm,
                obs: lista[i].obs,
                peQtd: lista[i].peQtd,
                peUnid: lista[i].peUnid,
                perComissao: lista[i].perComissao,
                pesoLiq: lista[i].pesoLiq,
                proCodBar: lista[i].proCodBar,
                unid: lista[i].unid,
                unidPdr: lista[i].unidPdr,
                vlrVenda: lista[i].vlrVenda,
                vrCompra: lista[i].vrCompra,
              ),
              table: 'products');
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<List<ProdModel>> queryProducts() async {
    try {
      return await _dbService.queryProducts();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  @override
  Future getPricesList() async {
    try {
      var sellerCode = await _dbService.queryPreferences();
      if (sellerCode[0].sellerCode != null) {
        var retorno = await _apiProvider.get(
            path:
                'http://192.168.56.1:5246/Product/price/${sellerCode[0].sellerCode}');
        var lista = List<PricesListModel>.from(retorno.data
            .map((model) => PricesListModel.fromJson(model))
            .toList());

        for (var i = 0; i < lista.length; i++) {
          for (var j = 0; j < lista[i].prices.length; j++) {
            await _dbService.insertData(
              args: PriceListDbModel(
                indexAdd: lista[i].prices[j].indexAdd,
                maxDiscount: lista[i].prices[j].maxDiscount,
                minPrice: lista[i].prices[j].minPrice,
                priceCode: lista[i].prices[j].priceCode,
                productCode: lista[i].productCode,
                salePrice: lista[i].prices[j].salePrice,
                unit: lista[i].unit,
              ),
              table: 'priceslist',
            );
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<List<PriceListDbModel>> queryPricesList(
      {required int productCode}) async {
    try {
      return await _dbService.queryPricesList(productCode);
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  @override
  Future<List<ProductsOrderModel>> queryProductsOrder() async {
    try {
      return await _dbService.queryProductsOrder();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
