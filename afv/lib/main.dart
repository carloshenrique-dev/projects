import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/bindings/application_bindings.dart';
import 'package:up_afv/application/modules/app_routes.dart';
import 'package:up_afv/application/themes/themes.dart';
import 'package:up_afv/core/translation/flutter_translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const UpAfv());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class UpAfv extends StatelessWidget {
  const UpAfv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      translations: FlutterTranslation(),
      locale: Get.deviceLocale,
      darkTheme: Themes.darktheme,
      theme: Themes.lightTheme,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      getPages: AppRoutes.routes,
      initialRoute: '/home',
      initialBinding: ApplicationBindings(),
    );
  }
}