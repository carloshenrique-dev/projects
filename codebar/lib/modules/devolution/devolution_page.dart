import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';
import 'package:up_codebar/app/theme/widgets/card_widget.dart';

class DevolutionPage extends StatelessWidget {
  const DevolutionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: Get.width * 0.8,
                  child: Text(
                    'devolutionPageTitulo'.tr,
                    style: theme.brightness == Brightness.dark
                        ? AppTextStyles.homeTitleWhite
                        : AppTextStyles.homeTitleDark,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                SizedBox(
                  width: Get.width * 0.8,
                  height: Get.height * 0.15,
                  child: CardWidget(
                    title: 'devolutionPageCard1'.tr,
                    textStyles: AppTextStyles.cardTextLight,
                    color: AppColors.darkBlue,
                    icon: Icon(
                      Icons.assignment_return,
                      size: Get.height * 0.05,
                      color: AppColors.whiteColor,
                    ),
                    navigation: () =>
                        Get.toNamed('/gendevolution', arguments: 'T'),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                SizedBox(
                  width: Get.width * 0.8,
                  height: Get.height * 0.15,
                  child: CardWidget(
                    title: 'devolutionPageCard2'.tr,
                    textStyles: AppTextStyles.cardTextLight,
                    color: AppColors.darkBlue,
                    icon: Icon(
                      Icons.cached,
                      size: Get.height * 0.05,
                      color: AppColors.whiteColor,
                    ),
                    navigation: () =>
                        Get.toNamed('/gendevolution', arguments: 'S'),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                SizedBox(
                  width: Get.width * 0.8,
                  height: Get.height * 0.15,
                  child: CardWidget(
                    title: 'devolutionPageCard3'.tr,
                    textStyles: AppTextStyles.cardTextLight,
                    color: AppColors.redCard,
                    icon: Icon(
                      Icons.cancel,
                      size: Get.height * 0.05,
                      color: AppColors.whiteColor,
                    ),
                    navigation: () =>
                        Get.toNamed('/gendevolution', arguments: 'N'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
