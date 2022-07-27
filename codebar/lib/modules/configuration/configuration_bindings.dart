import 'package:get/get.dart';

import 'configuration_controller.dart';

class ConfigurationBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ConfigurationController(storage: Get.find()),
    );
  }
}
