import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:up_template/models/Content/Content.dart';
import 'package:upentregas/app/core/translation/upentregas_translations.dart';
import 'package:upentregas/app/modules/detalhes_entrega/romaneio_details_module.dart';
import 'package:upentregas/app/modules/escolha_romaneio/escolha_romaneio_module.dart';
import 'package:upentregas/app/modules/fim_entrega/fim_entrega_module.dart';
import 'package:upentregas/app/modules/phone/phone_module.dart';
import 'package:upentregas/app/services/database.dart';
import 'package:upentregas/app/shared/styles/app_colors.dart';
import 'app/bindings/application_bindings.dart';
import 'app/modules/splash/splash_module.dart';
import 'app/shared/constants/variables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  final id = await recId();
  content = await GenericContent.getContent(12, id);
  runApp(const UpEntregas());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class UpEntregas extends StatelessWidget {
  const UpEntregas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: ApplicationBindings(),
      locale: Get.deviceLocale,
      translations: UpentregasTranslations(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF252525),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.grayColor,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      getPages: [
        ...PhoneModule().routers,
        ...SplashModule().routers,
        ...FimEntregaModule().routers,
        ...RomaneioDetailsModule().routers,
        ...EscolhaRomaneioModule().routers,
      ],
      themeMode: ThemeMode.system,
      initialRoute: '/splash',
    );
  }
}
