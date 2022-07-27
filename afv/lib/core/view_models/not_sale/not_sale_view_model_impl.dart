import 'package:up_afv/core/models/not_sale/not_sale_model.dart';
import 'package:up_afv/core/repositories/not_sale/not_sale_repository.dart';
import 'not_sale_view_model.dart';

class NotSaleViewModelImpl implements NotSaleViewModel {
  final NotSaleRepository _notSaleRepository;
  NotSaleViewModelImpl({
    required NotSaleRepository notSaleRepository,
  }) : _notSaleRepository = notSaleRepository;

  @override
  Future<void> getNotSale() => _notSaleRepository.getNotSale();

  @override
  Future<List<NotSaleModel>> queryNotSale() =>
      _notSaleRepository.queryNotSale();
}
