import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';

class SearchBoxWidget extends StatelessWidget {
  final TextInputType keyboard;
  final FocusNode focus;
  final Function onChanged;
  final String hintSearch;
  final TextEditingController controller;
  final VoidCallback onPressed;
  final bool clearButton;

  const SearchBoxWidget({
    Key? key,
    required this.keyboard,
    required this.focus,
    required this.onChanged,
    required this.hintSearch,
    required this.controller,
    required this.onPressed,
    required this.clearButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      onChanged: (value) => onChanged(value),
      style: AppTextStyles.searchBarHintText,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.whiteDefault,
        prefixIcon: const Icon(
          Icons.search,
          size: 25,
          color: AppColors.grayColor,
        ),
        suffixIcon: Visibility(
          visible: clearButton,
          child: IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.close,
              color: AppColors.body,
            ),
          ),
        ),
        hintText: '${'search'.tr}$hintSearch',
        hintStyle: AppTextStyles.searchBarHintText,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      controller: controller,
      focusNode: focus,
    );
  }
}
