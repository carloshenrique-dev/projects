import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';

class PriceListCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const PriceListCardWidget({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: Get.height * 0.005,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text(
                title,
                style: Get.isDarkMode
                    ? AppTextStyles.textFieldTitleDetailsWhite
                    : AppTextStyles.textFieldTitleDetailsDark,
              ),
              subtitle: Text(subtitle),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              (const IconData(0xe09c,
                  fontFamily: 'MaterialIcons', matchTextDirection: false)),
              color: theme.brightness == Brightness.dark
                  ? AppColors.whiteColor
                  : AppColors.grayColor,
            ),
          ),
        ],
      ),
    );
  }
}
