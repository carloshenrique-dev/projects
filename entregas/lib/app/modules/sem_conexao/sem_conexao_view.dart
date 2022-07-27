import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/modules/login/login_view.dart';
import 'package:upentregas/app/shared/controllers/conexao_controller/sem_conexao_controller.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';
import 'package:upentregas/app/shared/ui/messages/message_provisorio.dart';
import 'package:upentregas/app/shared/widgets/buttons/button_default.dart';
import 'package:upentregas/app/shared/widgets/loader/loader_widget.dart';
import 'package:upentregas/app/shared/widgets/logo/logo.dart';

class SemConexaoView extends StatelessWidget {
  const SemConexaoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    bool isLoading = false;
    SemConexaoController semConexaoController = SemConexaoController();
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Logo(),
                const SizedBox(
                  height: 5,
                ),
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  children: [
                    MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      removeBottom: true,
                      child: SizedBox(
                        width: Get.width * 0.85,
                        child: ListTile(
                          title: Text(
                            'hasError'.tr,
                            style: theme.brightness == Brightness.dark
                                ? AppTextStyles.title18
                                : AppTextStyles.title18Black,
                            textAlign: TextAlign.center,
                          ),
                          subtitle: Text(
                            '${'unable'.tr}\n ${'verifyConnection'.tr}',
                            style: theme.brightness == Brightness.dark
                                ? AppTextStyles.title16Connection
                                : AppTextStyles.title16BlackConnection,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                SizedBox(
                  width: Get.width * 0.70,
                  child: DefaultButton(
                    function: () async {
                      bool conexao =
                          await semConexaoController.checkConnectivity();
                      if (conexao) {
                        Get.to(() => const LoginView());
                      } else {
                        MessageProvisorio().showMessage(
                            message:
                                '${'unable'.tr}\n ${'verifyConnection'.tr}');
                      }
                    },
                    text: 'update'.tr,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                SizedBox(
                  width: Get.width * 0.70,
                  child: DefaultButton(
                    function: () {
                      exit(0);
                    },
                    text: 'exitApp'.tr,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                LoaderWidget(
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
