import 'package:get/get.dart';

import 'phone_controller.dart';

class PhoneBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhoneController>(() => PhoneController(), fenix: true);
  }
}
