import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:up_codebar/app/core/services/api_services.dart';
import 'package:up_codebar/app/core/services/storage_services.dart';
import 'package:up_codebar/modules/conexao/conexao_controller.dart';

class ApplicationBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(GetStorage(), permanent: true);
    Get.put(Storage(getStorage: Get.find()), permanent: true);
    Get.put(ApiServices(storage: Get.find()), permanent: true);
    Get.put(Connectivity(), permanent: true);
    Get.put(ConexaoController(connectivity: Get.find(), storage: Get.find()),
        permanent: true);
  }
}
