import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_codebar/app/modules/module.dart';
import 'package:up_codebar/modules/auth/auth_bindings.dart';
import 'auth_page.dart';

class AuthModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/auth',
      page: () => const AuthPage(),
      binding: AuthBindings(),
    ),
  ];
}
