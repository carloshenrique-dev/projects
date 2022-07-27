import 'package:get/get.dart';
import 'package:upentregas/app/modulos/module.dart';
import 'splash_view.dart';

class SplashModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/splash',
      page: () => const SplashView(),
    ),
  ];
}
