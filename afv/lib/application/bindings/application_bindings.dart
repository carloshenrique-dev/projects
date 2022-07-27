//import 'package:connectivity/connectivity.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:up_afv/core/repositories/login/login_repository.dart';
import 'package:up_afv/core/repositories/login/login_repository_impl.dart';
import 'package:up_afv/core/services/api/api_provider.dart';
import 'package:up_afv/core/services/auth/auth_service.dart';
import 'package:up_afv/core/services/connection/connection_service.dart';
import 'package:up_afv/core/services/db/db_service.dart';
import 'package:up_afv/core/view_models/login/login_view_model.dart';
import 'package:up_afv/core/view_models/login/login_view_model_impl.dart';

class ApplicationBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<Dio>(Dio(), permanent: true);
    Get.put<ApiProvider>(ApiProvider(dio: Get.find()), permanent: true);
    Get.put<Connectivity>(Connectivity(), permanent: true);
    Get.put<ConnectionService>(ConnectionService(connectivity: Get.find()),
        permanent: true);
    Get.put<DbService>(DbService(), permanent: true);
    Get.lazyPut<LoginRepository>(
        () =>
            LoginRepositoryImpl(apiProvider: Get.find(), dbService: Get.find()),
        fenix: true);
    Get.lazyPut<LoginViewModel>(
        () => LoginViewModelImpl(loginRepository: Get.find()),
        fenix: true);
    Get.putAsync(() async => AuthService(
        dbService: Get.find(),
        loginViewModel: Get.find(),
        connectionService: Get.find()));
  }
}
