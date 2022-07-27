import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/shared/formatter/formatter.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';
import 'package:upentregas/app/shared/textcontrollers/textfield_controllers.dart';

class PlacaNovaWidget extends StatelessWidget {
  const PlacaNovaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(top: 22, left: 16, right: 16),
      child: SizedBox(
        width: Get.width * 0.60,
        child: TextFormField(
          inputFormatters: [
            UpperCaseTextFormatter(),
          ],
          maxLength: 7,
          textAlign: TextAlign.center,
          autovalidateMode: AutovalidateMode.always,
          controller: placaNovaController,
          style: theme.brightness == Brightness.dark
              ? AppTextStyles.title16
              : AppTextStyles.title16Black,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            hintText: 'XXXXXXX',
            hintStyle: theme.brightness == Brightness.dark
                ? AppTextStyles.title16
                : AppTextStyles.title16Black,
          ),
        ),
      ),
    );
  }
}
