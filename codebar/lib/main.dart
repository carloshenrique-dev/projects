import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:up_codebar/app/modules/app_routes.dart';
import 'app/core/translation/codebar_translations.dart';
import 'app/theme/styles/app_colors.dart';
import 'app/bindings/application_bindings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  runApp(const CodeBar());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class CodeBar extends StatelessWidget {
  const CodeBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: 'UpCodebar',
      initialBinding: ApplicationBindings(),
      locale: Get.deviceLocale,
      translations: CodebarTranslations(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.grayColor,
        unselectedWidgetColor: AppColors.whiteColor,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        unselectedWidgetColor: AppColors.whiteColor,
      ),
      themeMode: ThemeMode.system,
      getPages: AppRoutes.routes,
      initialRoute: '/splash',
      debugShowCheckedModeBanner: false,
    );
  }
}
