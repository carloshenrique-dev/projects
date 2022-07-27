import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:up_afv/core/models/customers/customers_model.dart';
import 'package:up_afv/core/models/customers/sales_customers_items_model.dart';
import 'package:up_afv/core/models/customers/sales_customers_products_model.dart';
import 'package:up_afv/core/view_models/customers/customers_view_model.dart';

class CustomersSalesController extends GetxController {
  final isOpen = false.obs;
  final CustomersViewModel _customersViewModel;
  final listItems = <SalesCustomersItemsModel>[].obs;
  final listProducts = <SalesCustomersProductsModel>[].obs;
  var customer = CustomersModel();

  CustomersSalesController({
    required CustomersViewModel customersViewModel,
  }) : _customersViewModel = customersViewModel;

  @override
  onInit() async {
    super.onInit();
    customer = Get.arguments;
    await getData();
  }

  getData() async {
    try {
      var salesCustomersItems = await _customersViewModel
          .getCustomersSalesItems(customer.customerCode ?? 0);
      var salesCustomersProducts = await _customersViewModel
          .getCustomersSalesProducts(customer.customerCode ?? 0);
      listProducts.assignAll(salesCustomersProducts);
      listItems.assignAll(salesCustomersItems);
    } catch (e) {
      log(e.toString());
    }
  }

  List<SalesCustomersProductsModel> getProductsList(int salesOrder) {
    List<SalesCustomersProductsModel> list = [];
    try {
      for (var j = 0; j < listProducts.length; j++) {
        if (listProducts[j].salesOrder == salesOrder) {
          list.add(listProducts[j]);
        }
      }
      return list;
    } catch (e) {
      log(e.toString());
      return list;
    }
  }

  String formatData(String data) {
    var convert = DateFormat('yyyy-M-ddTHH:mm:ss').parse(data);
    return DateFormat('dd/MM/yyyy').format(convert);
  }
}
