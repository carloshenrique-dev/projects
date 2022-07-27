import 'package:get/get.dart';
import './sale_order_controller.dart';

class SaleOrderBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SaleOrderController(
      dbService: Get.find(),
      productsViewModel: Get.find(),
    ));
  }
}
