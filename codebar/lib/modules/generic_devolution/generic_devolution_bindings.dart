import 'package:get/get.dart';
import 'package:up_codebar/app/core/repositories/devolution/devolution_repository.dart';
import 'package:up_codebar/app/core/repositories/devolution/devolution_repository_impl.dart';
import 'package:up_codebar/app/core/view_models/devolution/devolution_view_model.dart';
import 'package:up_codebar/app/core/view_models/devolution/devolution_view_model_impl.dart';
import 'generic_devolution_controller.dart';

class GenericDevolutionBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DevolutionRepository>(
        () => DevolutionRepositoryImpl(apiServices: Get.find()));
    Get.lazyPut<DevolutionViewModel>(
        () => DevolutionViewModelImpl(devolutionRepository: Get.find()));
    Get.lazyPut<GenericDevolutionController>(
        () => GenericDevolutionController(devolutionViewModel: Get.find()));
  }
}
