import 'package:get/get.dart';
import 'package:up_codebar/app/modules/module.dart';
import 'package:up_codebar/modules/generic_devolution/generic_devolution_bindings.dart';
import 'generic_devolution_page.dart';

class GenericDevolutionModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/gendevolution',
      page: () => const GenericDevolutionPage(),
      binding: GenericDevolutionBindings(),
    ),
  ];
}
