import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_afv/application/modules/modules.dart';
import 'financial_position_bindings.dart';
import 'financial_position_page.dart';

class FinancialPositionModule extends Modules {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/financialposition',
      page: () => const FinancialPositionPage(),
      binding: FinancialPositionBindings(),
    )
  ];
}
