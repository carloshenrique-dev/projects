import 'package:flutter/material.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';

class TextFieldSaleOrderWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  const TextFieldSaleOrderWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.textInputAction,
    required this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.darkBlueCard,
      onFieldSubmitted: onFieldSubmitted,
      style: AppTextStyles.ordersWhiteLabel,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 10),
        hintText: hintText,
        hintStyle: AppTextStyles.ordersWhiteLabel,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              7.0,
            ),
            borderSide: BorderSide.none),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          borderSide: const BorderSide(color: AppColors.darkBlueCard),
        ),
        fillColor: AppColors.lightGray,
      ),
    );
  }
}
