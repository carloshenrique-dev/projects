import 'package:up_codebar/app/core/models/lotes_abertos_model.dart';
import 'package:up_codebar/app/core/services/api_services.dart';
import './lotes_abertos_repository.dart';

class LotesAbertosRepositoryImpl implements LotesAbertosRepository {
  final ApiServices _apiServices;
  LotesAbertosRepositoryImpl({
    required ApiServices apiServices,
  }) : _apiServices = apiServices;

  @override
  Future<List<LotesAbertosModel>> getLotesAbertos() async {
    try {
      final body = await _apiServices.genericGet(
          endPoint: 'GetLotesAbertos/getLotesAbertos');
      List lotesAbertos = body['getLotesAbertos'];
      return lotesAbertos
          .map((data) => LotesAbertosModel.fromJson(data))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
