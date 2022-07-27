import 'package:get/get.dart';
import 'package:up_codebar/app/modules/module.dart';
import 'configuration_bindings.dart';
import 'configuration_page.dart';

class ConfigurationModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/configuration',
      page: () => const ConfigurationPage(),
      binding: ConfigurationBindings(),
    ),
  ];
}
