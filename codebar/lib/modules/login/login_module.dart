import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_codebar/app/modules/module.dart';
import 'package:up_codebar/modules/login/login_bindings.dart';
import 'package:up_codebar/modules/login/login_page.dart';

class LoginModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
        name: '/login',
        page: () => const LoginPage(),
        binding: LoginBindings()),
  ];
}
