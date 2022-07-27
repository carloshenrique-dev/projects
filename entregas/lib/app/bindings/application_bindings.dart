import 'package:get/get.dart';
import 'package:upentregas/app/shared/controllers/conexao_controller/sem_conexao_controller.dart';

class ApplicationBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SemConexaoController(), permanent: true);
  }
}
