import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Get.isDarkMode
            ? AppTextStyles.captionBodyDark
            : AppTextStyles.captionBodyLight,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
      controller: controller,
      keyboardType: TextInputType.number,
    );
  }
}
