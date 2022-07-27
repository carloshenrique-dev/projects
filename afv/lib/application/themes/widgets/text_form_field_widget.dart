import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? textInputType;
  final bool senha;
  final bool visibilidade;
  final String hintText;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final Icon? icon;
  final VoidCallback? revelaTexto;
  final int? length;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.senha,
    required this.onChanged,
    required this.hintText,
    this.validator,
    this.icon,
    this.revelaTexto,
    required this.visibilidade,
    this.textInputType,
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
                  visibilidade ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.waterGreen,
                ),
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
      textInputAction: textInputAction,
      obscureText: senha ? visibilidade : false,
      maxLength: length,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
