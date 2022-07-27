import 'package:get/get.dart';
import 'package:up_afv/application/modules/modules.dart';
import 'splash_bindings.dart';
import 'splash_page.dart';

class SplashModule extends Modules {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/splash',
      page: () => const SplashPage(),
      binding: SplashBindings(),
    )
  ];
}
