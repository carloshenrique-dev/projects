import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:up_template/models/Content/Content.dart';
import 'package:upentregas/app/modules/login/widgets/text_field_number.dart';
import 'package:upentregas/app/services/database.dart';
import 'package:upentregas/app/shared/constants/variables.dart';
import 'package:upentregas/app/shared/textcontrollers/textfield_controllers.dart';
import 'package:upentregas/app/shared/ui/messages/message_provisorio.dart';
import 'package:upentregas/app/shared/widgets/buttons/button_default.dart';
import 'package:upentregas/app/shared/widgets/dialogs/dialog_localizacao.dart';
import 'package:upentregas/app/shared/widgets/loader/loader_widget.dart';
import 'package:upentregas/app/shared/widgets/logo/logo.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: firstLayout(),
    );
  }

  firstLayout() {
    return SingleChildScrollView(
      child: SizedBox(
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Logo(),
            TextFieldNumber(
              hintText: 'companyid'.tr,
              controller: employeeController,
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: Get.width * 0.70,
              child: Visibility(
                visible: !isLoading,
                child: DefaultButton(
                  function: () async {
                    LocationPermission permission =
                        await Geolocator.checkPermission();

                    if (permission == LocationPermission.denied ||
                        permission == LocationPermission.deniedForever) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const DialogLocation();
                        },
                      );
                    } else if (permission == LocationPermission.always ||
                        permission == LocationPermission.whileInUse) {
                      setState(() {
                        isLoading = true;
                      });
                      validarTelefone();
                    } else {
                      MessageProvisorio()
                          .showMessage(message: 'errorVerifyPermissions'.tr);
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  text: 'login'.tr,
                ),
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
    );
  }

  Future validarTelefone() async {
    saveId(employeeController.text);
    content = await GenericContent.getContent(12, employeeController.text);
    List<FirebaseApp> apps = Firebase.apps;

    if (employeeController.text == '') {
      MessageProvisorio().showMessage(message: 'idEmpty'.tr);
      setState(() {
        isLoading = false;
      });
    } else {
      if (content.api.statusAPI) {
        List<String> appsNames = [];
        for (var app in apps) {
          appsNames.add(app.name);
        }

        if (appsNames.contains(employeeController.text)) {
          String nomeFantasia = await getNomeFantasia(employeeController.text);
          if (nomeFantasia != 'UP') {
            setState(() {
              isLoading = false;
            });
            Get.toNamed(
              '/phone',
              parameters: {
                'nomeFantasia': nomeFantasia,
                'id': employeeController.text
              },
            );
            employeeController.clear();
          } else {
            MessageProvisorio().showMessage(message: 'companyID'.tr);
            setState(() {
              isLoading = false;
            });
          }
        } else {
          MessageProvisorio().showMessage(message: 'companyID'.tr);
          setState(() {
            isLoading = false;
          });
        }
      } else {
        MessageProvisorio().showMessage(message: 'notConnectServer'.tr);
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
