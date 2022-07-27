import 'package:get/get.dart';
import 'package:up_codebar/app/core/repositories/auth/auth_repository.dart';
import 'package:up_codebar/app/core/repositories/auth/auth_repository_impl.dart';
import 'package:up_codebar/app/core/repositories/login/login_repository.dart';
import 'package:up_codebar/app/core/repositories/login/login_repository_impl.dart';
import 'package:up_codebar/app/core/view_models/auth/auth_view_model.dart';
import 'package:up_codebar/app/core/view_models/auth/auth_view_model_impl.dart';
import 'package:up_codebar/app/core/view_models/login/login_view_model.dart';
import 'package:up_codebar/app/core/view_models/login/login_view_model_impl.dart';
import 'package:up_codebar/modules/login/login_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(apiServices: Get.find()),
        fenix: true);
    Get.lazyPut<AuthViewModel>(
        () => AuthViewModelImpl(authRepository: Get.find()),
        fenix: true);
    Get.lazyPut<LoginRepository>(
        () => LoginRepositoryImpl(apiServices: Get.find()));
    Get.lazyPut<LoginViewModel>(
        () => LoginViewModelImpl(loginRepository: Get.find()));
    Get.lazyPut<LoginController>(() => LoginController(
        loginViewModel: Get.find<LoginViewModel>(),
        storage: Get.find(),
        authViewModel: Get.find<AuthViewModel>()));
  }
}
