import 'package:upentregas/app/modulos/module.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'phone_bindings.dart';
import 'phone_view.dart';

class PhoneModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/phone',
      page: () => const PhoneView(),
      binding: PhoneBindings(),
    ),
  ];
}
