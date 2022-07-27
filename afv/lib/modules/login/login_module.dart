import 'package:get/get.dart';
import 'package:up_afv/application/modules/modules.dart';
import 'package:up_afv/modules/login/login_bindings.dart';
import 'login_page.dart';

class LoginModule extends Modules {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/login',
      page: () => const LoginPage(),
      binding: LoginBindings(),
    )
  ];
}
