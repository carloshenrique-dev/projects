import 'package:get/get.dart';
import 'package:upentregas/app/modulos/module.dart';
import 'romaneio_details_bindings.dart';
import 'romaneio_details_view.dart';

class RomaneioDetailsModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/romaneiodetails',
      page: () => const RomaneioDetailsView(),
      binding: RomaneioDetailsBindings(),
    ),
  ];
}
