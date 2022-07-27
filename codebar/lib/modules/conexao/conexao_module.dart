import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_codebar/app/modules/module.dart';
import 'package:up_codebar/modules/conexao/conexao_page.dart';

class ConexaoModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/conexao',
      page: () => const ConexaoPage(),
    ),
  ];
}
