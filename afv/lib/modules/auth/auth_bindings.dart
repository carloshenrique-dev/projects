import 'package:get/get.dart';
import 'package:up_afv/core/repositories/auth/auth_repository.dart';
import 'package:up_afv/core/repositories/auth/auth_repository_impl.dart';
import 'package:up_afv/core/view_models/auth/auth_view_model.dart';
import 'package:up_afv/core/view_models/auth/auth_view_model_impl.dart';
import './auth_controller.dart';

class AuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(
        () =>
            AuthRepositoryImpl(apiProvider: Get.find(), dbService: Get.find()),
        fenix: true);
    Get.lazyPut<AuthViewModel>(
        () => AuthViewModelImpl(authRepository: Get.find()),
        fenix: true);
    Get.put(AuthController(authViewModel: Get.find()));
  }
}
