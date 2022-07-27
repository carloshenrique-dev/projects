import 'package:get/get.dart';
import 'package:up_codebar/app/core/repositories/auth/auth_repository.dart';
import 'package:up_codebar/app/core/repositories/auth/auth_repository_impl.dart';
import 'package:up_codebar/app/core/view_models/auth/auth_view_model.dart';
import 'package:up_codebar/app/core/view_models/auth/auth_view_model_impl.dart';
import 'package:up_codebar/modules/auth/auth_controller.dart';

class AuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(apiServices: Get.find()),
        fenix: true);
    Get.lazyPut<AuthViewModel>(
        () => AuthViewModelImpl(authRepository: Get.find()),
        fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(
        authViewModel: Get.find<AuthViewModel>(), storage: Get.find()));
  }
}
