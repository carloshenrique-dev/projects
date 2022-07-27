import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_images.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/application/themes/widgets/icon_button_card_widget.dart';

mixin ChooseNavigationDialogMixin on GetxController {
  void navigationListener(Rxn<ChooseNavigationModel> message) {
    ever<ChooseNavigationModel?>(message, (model) {
      if (model != null) {
        Get.dialog(
          Dialog(
            child: SizedBox(
              height: Get.height * .5,
              width: Get.width * .085,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * .25,
                    child: Image.asset(
                      AppImages.chooseNavigation,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    'Escolha o aplicativo de navegação',
                    style: Get.isDarkMode
                        ? AppTextStyles.productTitleWhite
                        : AppTextStyles.productTitleDark,
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButtonCardWidget(
                        function: () => model.openMaps(),
                        icon: FontAwesomeIcons.mapMarkerAlt,
                        color: Get.isDarkMode
                            ? AppColors.whiteDefault
                            : AppColors.grayColor,
                      ),
                      SizedBox(
                        width: Get.width * 0.05,
                      ),
                      IconButtonCardWidget(
                        function: () => model.openWaze(),
                        icon: FontAwesomeIcons.waze,
                        color: Get.isDarkMode
                            ? AppColors.whiteDefault
                            : AppColors.grayColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
        );
      }
    });
  }
}

class ChooseNavigationModel {
  final VoidCallback openWaze;
  final VoidCallback openMaps;
  ChooseNavigationModel({
    required this.openWaze,
    required this.openMaps,
  });
}
