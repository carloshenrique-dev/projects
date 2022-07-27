import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_afv/application/modules/modules.dart';
import 'package:up_afv/modules/connection/connection_bindings.dart';
import 'connection_page.dart';

class ConnectionModule extends Modules {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/connection',
      page: () => const ConnectionPage(),
      binding: ConnectionBindings(),
    )
  ];
}
