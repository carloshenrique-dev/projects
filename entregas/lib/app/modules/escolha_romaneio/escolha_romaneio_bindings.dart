import 'package:get/get.dart';
import 'escolha_romaneio_controller.dart';

class EscolhaRomaneioBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EscolhaRomaneioController>(() => EscolhaRomaneioController(),
        fenix: true);
  }
}
