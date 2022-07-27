import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_afv/application/modules/modules.dart';
import 'about_client_bindings.dart';
import 'about_client_page.dart';

class AboutClientModule extends Modules {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/aboutclient',
      page: () => const AboutClientPage(),
      binding: AboutClientBindings(),
    )
  ];
}
