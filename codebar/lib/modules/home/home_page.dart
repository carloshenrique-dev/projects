import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/theme/widgets/card_widget.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: Get.height,
            width: Get.width,
            color: AppColors.darkBlue,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/logo.png',
                    color: AppColors.whiteColor,
                    width: Get.width * 0.30,
                    height: Get.height * 0.15,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: Get.height * 0.025,
                  child: IconButton(
                    onPressed: () => Get.toNamed('/configuration'),
                    icon: const Icon(Icons.build_circle),
                    color: AppColors.whiteColor,
                    iconSize: Get.width * 0.13,
                  ),
                ),
                Positioned(
                  top: Get.height * 0.15,
                  width: Get.width,
                  child: Material(
                    elevation: 6,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: Get.height * 0.065,
                        ),
                        SizedBox(
                          width: Get.width * 0.70,
                          child: Text(
                            'homePageTitulo'.tr,
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
                          width: Get.width * 0.95,
                          child: AnimatedCard(
                            direction: AnimatedCardDirection.left,
                            child: SizedBox(
                              width: Get.width * 0.95,
                              height: Get.height * 0.25,
                              child: CardWidget(
                                title: 'homePageSeparacao'.tr,
                                textStyles: AppTextStyles.cardTextLight,
                                color: AppColors.darkBlue,
                                icon: Icon(Icons.local_shipping,
                                    size: Get.height * 0.1,
                                    color: AppColors.whiteColor),
                                navigation: () => Get.toNamed('/navigate'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.020,
                        ),
                        Container(
                          height: Get.height * 0.7,
                          width: Get.width * 0.95,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          child: AnimatedCard(
                            direction: AnimatedCardDirection.right,
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4,
                              children: [
                                CardWidget(
                                  title: 'homePageDevolucao'.tr,
                                  textStyles:
                                      theme.brightness == Brightness.dark
                                          ? AppTextStyles.cardTextDark
                                          : AppTextStyles.cardTextLight,
                                  color: theme.brightness == Brightness.dark
                                      ? AppColors.whiteColor
                                      : AppColors.grayColor,
                                  icon: Icon(
                                    Icons.sync_problem,
                                    size: Get.height * 0.08,
                                    color: theme.brightness == Brightness.dark
                                        ? AppColors.black
                                        : AppColors.whiteColor,
                                  ),
                                  navigation: () => Get.toNamed('/devolution'),
                                ),
                                CardWidget(
                                  title: 'homePageInventario'.tr,
                                  textStyles:
                                      theme.brightness == Brightness.dark
                                          ? AppTextStyles.cardTextDark
                                          : AppTextStyles.cardTextLight,
                                  color: theme.brightness == Brightness.dark
                                      ? AppColors.whiteColor
                                      : AppColors.grayColor,
                                  icon: Icon(
                                    Icons.inventory,
                                    size: Get.height * 0.08,
                                    color: theme.brightness == Brightness.dark
                                        ? AppColors.black
                                        : AppColors.whiteColor,
                                  ),
                                  navigation: () => Get.toNamed('/inventory'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
