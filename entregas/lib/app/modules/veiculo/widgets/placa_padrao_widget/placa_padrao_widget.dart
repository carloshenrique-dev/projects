import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/shared/formatter/formatter.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';
import 'package:upentregas/app/shared/textcontrollers/textfield_controllers.dart';

class PlacaPadraoWidget extends StatelessWidget {
  const PlacaPadraoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: Get.width * 0.60,
        child: TextField(
          textAlign: TextAlign.center,
          inputFormatters: [UpperCaseTextFormatter()],
          controller: placaAntigaController,
          style: theme.brightness == Brightness.dark
              ? AppTextStyles.title16
              : AppTextStyles.title16Black,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            hintText: 'XXX-XXXX',
            hintStyle: theme.brightness == Brightness.dark
                ? AppTextStyles.title16
                : AppTextStyles.title16Black,
          ),
        ),
      ),
    );
  }
}
