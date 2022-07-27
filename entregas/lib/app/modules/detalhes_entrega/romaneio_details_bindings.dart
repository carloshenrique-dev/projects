import 'package:get/get.dart';
import 'package:upentregas/app/modules/detalhes_entrega/romaneio_details_controller.dart';

class RomaneioDetailsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RomaneioDetailsController>(() => RomaneioDetailsController(),
        fenix: true);
  }
}
