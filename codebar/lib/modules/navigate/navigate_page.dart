import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_images.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';
import 'package:up_codebar/app/theme/widgets/card_widget.dart';

class NavigatePage extends StatelessWidget {
  const NavigatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width * 0.90,
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  children: [
                    MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      removeBottom: true,
                      child: Text(
                        'navigatePageTitulo'.tr,
                        style: theme.brightness == Brightness.dark
                            ? AppTextStyles.homeTitleWhite
                            : AppTextStyles.homeTitleDark,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * 0.25,
                    width: Get.width * 0.47,
                    child: CardWidget(
                      title: 'navigatePageProduto'.tr,
                      textStyles: theme.brightness == Brightness.dark
                          ? AppTextStyles.cardTextDark
                          : AppTextStyles.cardTextLight,
                      color: theme.brightness == Brightness.dark
                          ? AppColors.whiteColor
                          : AppColors.grayColor,
                      icon: Icon(
                        Icons.list,
                        size: Get.height * 0.08,
                        color: theme.brightness == Brightness.dark
                            ? AppColors.black
                            : AppColors.whiteColor,
                      ),
                      navigation: () =>
                          Get.toNamed('/lotesAbertos', arguments: 'produto'),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.25,
                    width: Get.width * 0.47,
                    child: CardWidget(
                      title: 'navigatePagePedido'.tr,
                      textStyles: theme.brightness == Brightness.dark
                          ? AppTextStyles.cardTextDark
                          : AppTextStyles.cardTextLight,
                      color: theme.brightness == Brightness.dark
                          ? AppColors.whiteColor
                          : AppColors.grayColor,
                      icon: Icon(
                        Icons.checklist,
                        size: Get.height * 0.08,
                        color: theme.brightness == Brightness.dark
                            ? AppColors.black
                            : AppColors.whiteColor,
                      ),
                      navigation: () =>
                          Get.toNamed('/lotesAbertos', arguments: 'pedido'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.logoUp,
              color: theme.brightness == Brightness.dark
                  ? AppColors.whiteColor
                  : AppColors.miniLogo,
              width: Get.width * 0.32,
              height: Get.height * 0.11,
              filterQuality: FilterQuality.high,
            ),
          ],
        ),
      ),
    );
  }
}
