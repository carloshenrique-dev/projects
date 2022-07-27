import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/application/themes/widgets/text_personalizable_widget.dart';
import 'customer_details_controller.dart';
import 'widgets/flip_card_widget.dart';

class CustomerDetailsPage extends GetView<CustomerDetailsController> {
  const CustomerDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextPersonalizableWidget(
                      maxLines: 1,
                      text:
                          '${controller.cli.corporateName?.toLowerCase().capitalizeFirst}',
                      style: theme.brightness == Brightness.dark
                          ? AppTextStyles.homeTitleWhite
                          : AppTextStyles.homeTitleDark,
                    ),
                    Divider(
                      color: theme.brightness == Brightness.dark
                          ? AppColors.whiteDefault
                          : AppColors.grayColor,
                      thickness: 1,
                    ),
                    TextPersonalizableWidget(
                      maxLines: 1,
                      text: 'fantasyNameCli'.tr,
                      style: theme.brightness == Brightness.dark
                          ? AppTextStyles.productBodyWhite
                          : AppTextStyles.productBodyDark,
                    ),
                    TextPersonalizableWidget(
                      maxLines: 2,
                      text:
                          '${controller.cli.commercialName?.toLowerCase().capitalizeFirst}',
                      style: theme.brightness == Brightness.dark
                          ? AppTextStyles.clientDetailsWhite
                          : AppTextStyles.clientDetailsDark,
                    ),
                    TextPersonalizableWidget(
                      maxLines: 1,
                      text: 'condition'.tr,
                      style: theme.brightness == Brightness.dark
                          ? AppTextStyles.productBodyWhite
                          : AppTextStyles.productBodyDark,
                    ),
                    TextPersonalizableWidget(
                      maxLines: 1,
                      text:
                          '${controller.cli.paymentCondition?.toLowerCase().capitalizeFirst}',
                      style: theme.brightness == Brightness.dark
                          ? AppTextStyles.clientDetailsWhite
                          : AppTextStyles.clientDetailsDark,
                    ),
                    TextPersonalizableWidget(
                      maxLines: 1,
                      text: 'cnpj'.tr,
                      style: theme.brightness == Brightness.dark
                          ? AppTextStyles.productBodyWhite
                          : AppTextStyles.productBodyDark,
                    ),
                    TextPersonalizableWidget(
                      maxLines: 1,
                      text: '${controller.cli.cnpjCpf}',
                      style: theme.brightness == Brightness.dark
                          ? AppTextStyles.clientDetailsWhite
                          : AppTextStyles.clientDetailsDark,
                    ),
                    TextPersonalizableWidget(
                      maxLines: 1,
                      text: 'IE:',
                      style: theme.brightness == Brightness.dark
                          ? AppTextStyles.productBodyWhite
                          : AppTextStyles.productBodyDark,
                    ),
                    TextPersonalizableWidget(
                      maxLines: 1,
                      text: '${controller.cli.ieRg}',
                      style: theme.brightness == Brightness.dark
                          ? AppTextStyles.clientDetailsWhite
                          : AppTextStyles.clientDetailsDark,
                    ),
                    TextPersonalizableWidget(
                      maxLines: 1,
                      text: 'activity'.tr,
                      style: theme.brightness == Brightness.dark
                          ? AppTextStyles.productBodyWhite
                          : AppTextStyles.productBodyDark,
                    ),
                    TextPersonalizableWidget(
                      maxLines: 1,
                      text:
                          '${controller.cli.activityArea?.toLowerCase().capitalizeFirst}',
                      style: theme.brightness == Brightness.dark
                          ? AppTextStyles.clientDetailsWhite
                          : AppTextStyles.clientDetailsDark,
                    ),
                    SizedBox(
                      height: Get.height * .010,
                    ),
                    FlipCardWidget(
                      cli: controller.cli,
                      icon: FontAwesomeIcons.addressBook,
                      title: 'contact'.tr,
                      type: 1,
                      openPhone: () => controller.callPhone(),
                      openWhats: () => controller.callWhats(),
                      openEmail: () => controller.callEmail(),
                    ),
                    SizedBox(
                      height: Get.height * .009,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 7.0),
                      child: Obx(() {
                        if (controller.addressModel.isNotEmpty) {
                          return FlipCardWidget(
                            addressModel: controller.addressModel[0],
                            cli: controller.cli,
                            icon: FontAwesomeIcons.mapSigns,
                            title: 'address'.tr,
                            type: 0,
                            openMaps: () {}, //controller.callMaps(),
                            openWaze: () {}, //controller.callWaze(),
                          );
                        }
                        return const SizedBox.shrink();
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
