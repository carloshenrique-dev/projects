import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:up_codebar/app/theme/styles/app_text_styles.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? textInputType;
  final bool senha;
  final bool visibilidade;
  final String hintText;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final Icon icon;
  final VoidCallback revelaTexto;
  final int? length;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    this.textInputType,
    required this.senha,
    required this.visibilidade,
    required this.hintText,
    required this.onChanged,
    required this.validator,
    required this.icon,
    required this.revelaTexto,
    this.length,
    this.onFieldSubmitted,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: icon,
        suffixIcon: senha
            ? IconButton(
                onPressed: revelaTexto,
                icon: Icon(
                    visibilidade ? Icons.visibility : Icons.visibility_off),
              )
            : null,
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
      keyboardType: textInputType,
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      obscureText: senha ? visibilidade : false,
      maxLength: length,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction,
    );
  }
}
