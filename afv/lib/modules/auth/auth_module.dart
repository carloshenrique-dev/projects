import 'package:get/get.dart';
import 'package:up_afv/application/modules/modules.dart';
import 'package:up_afv/modules/auth/auth_bindings.dart';
import 'auth_page.dart';

class AuthModule extends Modules {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/auth',
      page: () => const AuthPage(),
      binding: AuthBindings(),
    )
  ];
}
