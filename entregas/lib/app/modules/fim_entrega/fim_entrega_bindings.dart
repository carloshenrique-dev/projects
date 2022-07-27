import 'package:get/get.dart';
import 'package:upentregas/app/modules/fim_entrega/fim_entrega_controller.dart';

class FimEntregaBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FimEntregaController>(() => FimEntregaController(),
        fenix: true);
  }
}
