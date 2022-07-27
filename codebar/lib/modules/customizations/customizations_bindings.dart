import 'package:get/get.dart';
import './customizations_controller.dart';

class CustomizationsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CustomizationsController(
        barcodeViewModel: Get.find(),
        storage: Get.find(),
        pedidoViewModel: Get.find(),
        itensPedidoController: Get.find(),
      ),
    );
  }
}
