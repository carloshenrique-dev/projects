import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';

class ExpandableCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String subtitle2;
  const ExpandableCardWidget(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.subtitle2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ExpansionTile(
      title: Text(
        title,
        style: Get.isDarkMode
            ? AppTextStyles.textFieldTitleDetailsWhite
            : AppTextStyles.textFieldTitleDetailsDark,
      ),
      subtitle: Text('$subtitle\n$subtitle2'),
      collapsedIconColor: theme.brightness == Brightness.dark
          ? AppColors.whiteColor
          : AppColors.grayColor,
      children: [
        Text(
          'Choperia Colorado',
          style: Get.isDarkMode
              ? AppTextStyles.textFieldTitleDetailsWhite
              : AppTextStyles.textFieldTitleDetailsDark,
        ),
        Text(
          'R\$ 295,96',
          style: Get.isDarkMode
              ? AppTextStyles.textFieldTitleDetailsWhite
              : AppTextStyles.textFieldTitleDetailsDark,
        ),
        Text(
          '5491',
          style: Get.isDarkMode
              ? AppTextStyles.textFieldTitleDetailsWhite
              : AppTextStyles.textFieldTitleDetailsDark,
        ),
      ],
    );
  }
}
