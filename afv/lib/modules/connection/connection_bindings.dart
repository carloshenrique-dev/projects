import 'package:get/get.dart';
import 'package:up_afv/modules/connection/connection_controller.dart';

class ConnectionBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionController>(
      () => ConnectionController(
        connectivity: Get.find(),
      ),
    );
  }
}
