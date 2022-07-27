import 'package:flutter/material.dart';

import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';

class TextFieldProductWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback plusCallback;
  final VoidCallback minusCallback;
  const TextFieldProductWidget({
    Key? key,
    required this.controller,
    required this.plusCallback,
    required this.minusCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.darkBlueCard,
      style: AppTextStyles.h3Dark,
      textAlign: TextAlign.center,
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: '0',
        hintStyle: AppTextStyles.ordersWhiteLabel,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        filled: true,
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
