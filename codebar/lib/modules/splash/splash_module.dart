import 'package:get/get.dart';
import 'package:up_codebar/app/modules/module.dart';
import 'splash_page.dart';

class SplashModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/splash',
      page: () => const SplashPage(),
    ),
  ];
}