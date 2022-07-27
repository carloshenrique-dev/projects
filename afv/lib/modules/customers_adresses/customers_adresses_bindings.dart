import 'package:get/get.dart';
import './customers_adresses_controller.dart';

class CustomersAdressesBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(
      CustomersAdressesController(
        customersViewModel: Get.find(),
      ),
    );
  }
}
