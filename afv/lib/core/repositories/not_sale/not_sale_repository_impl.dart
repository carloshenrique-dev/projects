import 'dart:developer';
import 'package:up_afv/core/models/not_sale/not_sale_model.dart';
import 'package:up_afv/core/repositories/not_sale/not_sale_repository.dart';
import 'package:up_afv/core/services/api/api_provider.dart';
import 'package:up_afv/core/services/db/db_service.dart';

class NotSaleRepositoryImpl implements NotSaleRepository {
  final ApiProvider _apiProvider;
  final DbService _dbService;
  NotSaleRepositoryImpl({
    required ApiProvider apiProvider,
    required DbService dbService,
  })  : _apiProvider = apiProvider,
        _dbService = dbService;

  @override
  Future<void> getNotSale() async {
    try {
      var retorno = await _apiProvider.get(
          path: 'http://192.168.56.1:5246/NotSale/motives/126');

      var lista = List<NotSaleModel>.from(
          retorno.data.map((model) => NotSaleModel.fromJson(model)).toList());
      for (var i = 0; i < lista.length; i++) {
        await _dbService.insertData(
            args: NotSaleModel(code: lista[i].code, motive: lista[i].motive),
            table: 'notsale');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<List<NotSaleModel>> queryNotSale() async {
    try {
      return await _dbService.queryNotSale();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
