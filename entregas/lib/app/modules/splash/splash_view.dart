import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/modules/sem_conexao/sem_conexao_view.dart';
import 'package:upentregas/app/shared/controllers/conexao_controller/sem_conexao_controller.dart';
import '../../app.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SemConexaoController semConexaoController = SemConexaoController();

  @override
  void initState() {
    super.initState();
    navegar();
  }

  navegar() async {
    await Future.delayed(const Duration(seconds: 3));

    bool connectivityResult = await semConexaoController.checkConnectivity();
    if (connectivityResult) {
      Get.offAll(() => const App());
    } else {
      Get.offAll(() => const SemConexaoView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: const [
                  Center(
                    child: ImageIcon(
                      AssetImage('assets/images/logo.png'),
                      size: 140.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
