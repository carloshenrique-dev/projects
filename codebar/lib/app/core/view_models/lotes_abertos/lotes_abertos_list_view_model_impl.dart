import 'package:up_codebar/app/core/models/lotes_abertos_model.dart';
import 'package:up_codebar/app/core/repositories/lotes_abertos/lotes_abertos_repository.dart';

import './lotes_abertos_list_view_model.dart';

class LotesAbertosListViewModelImpl implements LotesAbertosListViewModel {
  final LotesAbertosRepository _lotesAbertosRepository;
  LotesAbertosListViewModelImpl({
    required LotesAbertosRepository lotesAbertosRepository,
  }) : _lotesAbertosRepository = lotesAbertosRepository;
  @override
  Future<List<LotesAbertosModel>> getLotesAbertos() =>
      _lotesAbertosRepository.getLotesAbertos();
}
