import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';

class ComboBoxWidget extends StatelessWidget {
  final List<DropdownMenuItem<String>>? items;
  final double? height;

  const ComboBoxWidget({
    Key? key,
    required this.items,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: height,
      width: Get.width,
      child: Card(
        color: AppColors.lightGray,
        margin: EdgeInsets.zero,
        child: DropdownButton(
          hint: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Selecione um item',
              style: AppTextStyles.textFieldTitleWhite,
            ),
          ),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.whiteDefault,
          ),
          isExpanded: true,
          underline: const SizedBox(),
          items: items,
          onChanged: (_) {},
        ),
      ),
    );
  }
}
