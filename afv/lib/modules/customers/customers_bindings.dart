import 'package:get/get.dart';
import 'customers_controller.dart';

class CustomersBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomersController>(
      () => CustomersController(
        dbService: Get.find(),
      ),
    );
  }
}
