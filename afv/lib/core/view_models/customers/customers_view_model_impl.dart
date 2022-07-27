import 'package:up_afv/core/models/customers/customers_address_model.dart';
import 'package:up_afv/core/models/customers/financial_positions_items_model.dart';
import 'package:up_afv/core/models/customers/sales_customers_items_model.dart';
import 'package:up_afv/core/models/customers/sales_customers_products_model.dart';
import 'package:up_afv/core/repositories/customers/customers_repository.dart';
import 'customers_view_model.dart';

class CustomersViewModelImpl implements CustomersViewModel {
  final CustomersRepository _customersRepository;
  CustomersViewModelImpl({
    required CustomersRepository customersRepository,
  }) : _customersRepository = customersRepository;

  @override
  Future<void> getCustomers() => _customersRepository.getCustomers();

  @override
  Future<List<CustomersAddressModel>> getCustomersAddress(int customerCode) =>
      _customersRepository.getCustomersAddress(customerCode);

  @override
  Future<void> getFinancialPositionData() =>
      _customersRepository.getFinancialPositionData();

  @override
  Future<List<FinancialPositionsItemsModel>> getFinancialPosition(
          int customerCode) =>
      _customersRepository.getFinancialPosition(customerCode);

  @override
  Future<void> getCustomersSales() => _customersRepository.getCustomersSales();

  @override
  Future<List<SalesCustomersProductsModel>> getCustomersSalesProducts(
          int customerCode) =>
      _customersRepository.getCustomersSalesProducts(customerCode);

  @override
  Future<List<SalesCustomersItemsModel>> getCustomersSalesItems(
          int customerCode) =>
      _customersRepository.getCustomersSalesItems(customerCode);
}
