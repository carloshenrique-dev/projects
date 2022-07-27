import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/modules/phone/phone_controller.dart';
import 'package:upentregas/app/modules/phone/widgets/button_widget.dart';
import 'package:upentregas/app/modules/phone/widgets/input_phone_widget.dart';
import 'package:upentregas/app/shared/widgets/titles/titles_default.dart';

class PhoneView extends GetView<PhoneController> {
  const PhoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    PhoneNumber number = PhoneNumber(isoCode: 'BR');
    controller.id.value = Get.parameters['id']!;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  const Center(
                    child: ImageIcon(
                      AssetImage('assets/images/logo.png'),
                      size: 140.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TitleDefault(
                    title: Get.parameters['nomeFantasia'],
                  ),
                  InputPhoneWidget(
                    number: number,
                    phoneController: phoneController,
                    funcao: (PhoneNumber number) {
                      if (number.phoneNumber!.length == 14) {
                        controller.phoneNo.value = number.phoneNumber!;
                        controller.isValid.value = true;
                      } else {
                        controller.isValid.value = false;
                      }
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: Get.width * 0.75,
                      child: Obx(
                        () => ButtonWidget(
                          isValid: controller.isValid.value,
                          funcao: () async => controller.validaTelefone(),
                        ),
                      ),
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
}
