import 'package:up_codebar/app/core/models/lotes_abertos_model.dart';

abstract class LotesAbertosListViewModel {
  Future<List<LotesAbertosModel>> getLotesAbertos();
}
