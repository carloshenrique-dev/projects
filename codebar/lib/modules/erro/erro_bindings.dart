import 'package:get/get.dart';

import 'erro_controller.dart';

class ErroBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ErroController>(() => ErroController(storage: Get.find()),
        fenix: true);
  }
}
