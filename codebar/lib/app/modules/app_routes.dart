import 'package:up_codebar/modules/auth/auth.module.dart';
import 'package:up_codebar/modules/conexao/conexao_module.dart';
import 'package:up_codebar/modules/configuration/configuration_module.dart';
import 'package:up_codebar/modules/customizations/customizations_module.dart';
import 'package:up_codebar/modules/devolution/devolution_module.dart';
import 'package:up_codebar/modules/erro/erro_module.dart';
import 'package:up_codebar/modules/generic_devolution/generic_devolution_module.dart';
import 'package:up_codebar/modules/home/home_module.dart';
import 'package:up_codebar/modules/inventory/inventory_module.dart';
import 'package:up_codebar/modules/itens_pedido/itens_pedido_module.dart';
import 'package:up_codebar/modules/login/login_module.dart';
import 'package:up_codebar/modules/lotes_abertos/lotes_abertos_module.dart';
import 'package:up_codebar/modules/navigate/navigate_module.dart';
import 'package:up_codebar/modules/pedido/pedido_module.dart';
import 'package:up_codebar/modules/produto/produto_module.dart';
import 'package:up_codebar/modules/splash/splash_module.dart';

abstract class AppRoutes {
  static final routes = [
    ...LoginModule().routers,
    ...HomeModule().routers,
    ...ConexaoModule().routers,
    ...InventoryModule().routers,
    ...DevolutionModule().routers,
    ...LotesAbertosModule().routers,
    ...NavigateModule().routers,
    ...PedidoModule().routers,
    ...ProdutoModule().routers,
    ...ItensPedidoModule().routers,
    ...SplashModule().routers,
    ...GenericDevolutionModule().routers,
    ...AuthModule().routers,
    ...ErroModule().routers,
    ...ConfigurationModule().routers,
    ...CustomizationsModule().routers,
  ];
}
