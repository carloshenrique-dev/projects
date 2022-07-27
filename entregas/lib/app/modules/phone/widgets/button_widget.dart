import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback funcao;
  final bool isValid;
  const ButtonWidget({
    Key? key,
    required this.funcao,
    required this.isValid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: funcao,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        padding: const EdgeInsets.all(16.0),
        primary: isValid == true
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor.withOpacity(0.5),
      ),
      child: Text(
        isValid == true ? 'proceed'.tr : 'enterphone'.tr,
        style: AppTextStyles.button,
      ),
    );
  }
}
