import 'package:get/get.dart';
import 'package:up_afv/modules/customers_adresses/customers_adresses_controller.dart';
import 'package:up_afv/modules/customers_details/customer_details_controller.dart';
import 'package:up_afv/modules/customers_sales/customers_sales_controller.dart';
import 'package:up_afv/modules/financial_position/financial_position_controller.dart';
import './about_client_controller.dart';

class AboutClientBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(FinancialPositionController(customersViewModel: Get.find()));
    Get.put(CustomerDetailsController(customersViewModel: Get.find()));
    Get.put(AboutClientController());
    Get.put(CustomersSalesController(customersViewModel: Get.find()));
    Get.put(CustomersAdressesController(customersViewModel: Get.find()));
  }
}
