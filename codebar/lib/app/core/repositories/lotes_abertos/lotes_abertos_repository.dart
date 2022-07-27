import 'package:up_codebar/app/core/models/lotes_abertos_model.dart';

abstract class LotesAbertosRepository {
  Future<List<LotesAbertosModel>> getLotesAbertos();
}