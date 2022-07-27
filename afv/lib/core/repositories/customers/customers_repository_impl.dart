import 'dart:developer';
import 'package:up_afv/core/models/customers/customers_address_model.dart';
import 'package:up_afv/core/models/customers/customers_model.dart';
import 'package:up_afv/core/models/customers/financial_position_model.dart';
import 'package:up_afv/core/models/customers/financial_positions_items_model.dart';
import 'package:up_afv/core/models/customers/sales_customers_items_model.dart';
import 'package:up_afv/core/models/customers/sales_customers_model.dart';
import 'package:up_afv/core/models/customers/sales_customers_products_model.dart';
import 'package:up_afv/core/services/api/api_provider.dart';
import 'package:up_afv/core/services/db/db_service.dart';
import 'customers_repository.dart';

class CustomersRepositoryImpl implements CustomersRepository {
  final ApiProvider _apiProvider;
  final DbService _dbService;
  CustomersRepositoryImpl({
    required ApiProvider apiProvider,
    required DbService dbService,
  })  : _apiProvider = apiProvider,
        _dbService = dbService;

  @override
  Future<void> getCustomers() async {
    try {
      var sellerCode = await _dbService.queryPreferences();
      if (sellerCode[0].sellerCode != null) {
        var retorno = await _apiProvider.get(
            path:
                'http://192.168.56.1:5246/Customer/base/${sellerCode[0].sellerCode}');
        var lista = List<CustomersModel>.from(retorno.data
            .map((model) => CustomersModel.fromJson(model))
            .toList());
        for (var i = 0; i < lista.length; i++) {
          await _dbService.insertData(
            args: CustomersModel(
                customerCode: lista[i].customerCode?.toInt(),
                corporateName: lista[i].corporateName,
                commercialName: lista[i].commercialName,
                cnpjCpf: lista[i].cnpjCpf,
                ieRg: lista[i].ieRg,
                phones: lista[i].phones,
                contact: lista[i].contact,
                activityArea: lista[i].activityArea,
                sellerName: lista[i].sellerName,
                paymentCondition: lista[i].paymentCondition,
                attendance: lista[i].attendance,
                sectorCode: lista[i].sectorCode,
                sequency: lista[i].sequency,
                creditLimValue: lista[i].creditLimValue,
                creditLimDate: lista[i].creditLimDate,
                qtyOpenBond: lista[i].qtyOpenBond,
                maxAmountExpiredBond: lista[i].maxAmountExpiredBond,
                active: lista[i].active,
                priceList: lista[i].priceList,
                paymentConditionCode: lista[i].paymentConditionCode,
                mail: lista[i].mail,
                eppMe: lista[i].eppMe,
                activityAreaCode: lista[i].activityAreaCode,
                itineraryCode: lista[i].itineraryCode,
                customersAddressModel: null),
            table: 'customers',
          );
          for (var j = 0; j < lista[i].customersAddressModel!.length; j++) {
            await _dbService.insertData(
              args: CustomersAddressModel(
                customerCode: lista[i].customerCode,
                addressCode: lista[i].customersAddressModel?[j].addressCode,
                address: lista[i].customersAddressModel?[j].address,
                city: lista[i].customersAddressModel?[j].city,
                complement: lista[i].customersAddressModel?[j].complement,
                neighborhood: lista[i].customersAddressModel?[j].neighborhood,
                numberAddress: lista[i].customersAddressModel?[j].numberAddress,
                postalCode: lista[i].customersAddressModel?[j].postalCode,
                state: lista[i].customersAddressModel?[j].state,
                type: lista[i].customersAddressModel?[j].type,
              ),
              table: 'customersaddress',
            );
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<List<CustomersAddressModel>> getCustomersAddress(
      int customerCode) async {
    try {
      return await _dbService.queryCustomersAddress(customerCode);
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> getFinancialPositionData() async {
    try {
      var sellerCode = await _dbService.queryPreferences();
      if (sellerCode[0].sellerCode != null) {
        var retorno = await _apiProvider.get(
            path:
                'http://192.168.56.1:5246/Customer/financial/${sellerCode[0].sellerCode}');
        var list = List<FinancialPositionModel>.from(retorno.data
            .map((model) => FinancialPositionModel.fromJson(model))
            .toList());
        for (var i = 0; i < list.length; i++) {
          for (var j = 0; j < list[i].financialPositionItems!.length; j++) {
            await _dbService.insertData(
              args: FinancialPositionsItemsModel(
                customerCode: list[i].customerCode,
                subsidiaryCode:
                    list[i].financialPositionItems?[j].subsidiaryCode,
                titleCode: list[i].financialPositionItems?[j].titleCode,
                installment: list[i].financialPositionItems?[j].installment,
                type: list[i].financialPositionItems?[j].type,
                issueDate: list[i].financialPositionItems?[j].issueDate,
                originalIssueDate:
                    list[i].financialPositionItems?[j].originalIssueDate,
                dueDate: list[i].financialPositionItems?[j].dueDate,
                amountInstallment:
                    list[i].financialPositionItems?[j].amountInstallment,
                ticketNumber: list[i].financialPositionItems?[j].ticketNumber,
                paymentDate: list[i].financialPositionItems?[j].paymentDate,
                amountInterest:
                    list[i].financialPositionItems?[j].amountInterest,
                discount: list[i].financialPositionItems?[j].discount,
                amountPaid: list[i].financialPositionItems?[j].amountPaid,
                series: list[i].financialPositionItems?[j].series,
                installmentsQty:
                    list[i].financialPositionItems?[j].installmentsQty,
              ),
              table: 'financialposition',
            );
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<List<FinancialPositionsItemsModel>> getFinancialPosition(
      int customerCode) async {
    try {
      return await _dbService.queryFinancialPosition(customerCode);
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  @override
  Future<void> getCustomersSales() async {
    try {
      var sellerCode = await _dbService.queryPreferences();
      if (sellerCode[0].sellerCode != null) {
        var retorno = await _apiProvider.get(
            path:
                'http://192.168.56.1:5246/Customer/sales/${sellerCode[0].sellerCode}');
        var list = List<SalesCustomersModel>.from(retorno.data
            .map((model) => SalesCustomersModel.fromJson(model))
            .toList());
        for (var i = 0; i < list.length; i++) {
          for (var j = 0; j < list[i].salesCustomers!.length; j++) {
            await _dbService.insertData(
                args: SalesCustomersItemsModel(
                    customerCode: list[i].customerCode,
                    subsidiaryCode: list[i].salesCustomers![j].subsidiaryCode,
                    salesOrder: list[i].salesCustomers![j].salesOrder,
                    invoiceNumber: list[i].salesCustomers![j].invoiceNumber,
                    saleDate: list[i].salesCustomers![j].saleDate,
                    deliveryDate: list[i].salesCustomers![j].deliveryDate,
                    note: list[i].salesCustomers![j].note,
                    paymentCondition:
                        list[i].salesCustomers![j].paymentCondition,
                    internalService: list[i].salesCustomers![j].internalService,
                    status: list[i].salesCustomers![j].status,
                    cancellationReason:
                        list[i].salesCustomers![j].cancellationReason,
                    unlockUser: list[i].salesCustomers![j].unlockUser,
                    ublockDate: list[i].salesCustomers![j].ublockDate,
                    unlockReason: list[i].salesCustomers![j].unlockReason,
                    grossAmount:
                        list[i].salesCustomers![j].grossAmount!.toDouble(),
                    netValue: list[i].salesCustomers![j].netValue!.toDouble(),
                    commercialBudget:
                        list[i].salesCustomers![j].commercialBudget!.toDouble(),
                    registrationTime:
                        list[i].salesCustomers![j].registrationTime,
                    syncDate: list[i].salesCustomers![j].syncDate,
                    movementType: list[i].salesCustomers![j].movementType,
                    products: null),
                table: 'salescustomersorders');
            for (var k = 0;
                k < list[i].salesCustomers![j].products!.length;
                k++) {
              await _dbService.insertData(
                args: SalesCustomersProductsModel(
                  customerCode: list[i].customerCode,
                  salesOrder: list[i].salesCustomers![j].salesOrder,
                  item: list[i].salesCustomers![j].products![k].item,
                  productCode:
                      list[i].salesCustomers![j].products![k].productCode,
                  productDescription: list[i]
                      .salesCustomers![j]
                      .products![k]
                      .productDescription,
                  unit: list[i].salesCustomers![j].products![k].unit,
                  invoicedQty:
                      list[i].salesCustomers![j].products![k].invoicedQty,
                  requestQty:
                      list[i].salesCustomers![j].products![k].requestQty,
                  unitAmount: list[i]
                      .salesCustomers![j]
                      .products![k]
                      .unitAmount!
                      .toDouble(),
                  totalAmount: list[i]
                      .salesCustomers![j]
                      .products![k]
                      .totalAmount!
                      .toDouble(),
                  status: list[i].salesCustomers![j].products![k].status,
                  cancellationReason: list[i]
                      .salesCustomers![j]
                      .products![k]
                      .cancellationReason,
                  priceList: list[i].salesCustomers![j].products![k].priceList,
                  originalSaleValue: list[i]
                      .salesCustomers![j]
                      .products![k]
                      .originalSaleValue!
                      .toDouble(),
                  typeOperation:
                      list[i].salesCustomers![j].products![k].typeOperation,
                ),
                table: 'salescustomersproducts',
              );
            }
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<List<SalesCustomersItemsModel>> getCustomersSalesItems(
      int customerCode) async {
    try {
      return await _dbService.querySalesCustomersOrders(customerCode);
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  @override
  Future<List<SalesCustomersProductsModel>> getCustomersSalesProducts(
      int customerCode) async {
    try {
      return await _dbService.querySalesCustomersProducts(customerCode);
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
