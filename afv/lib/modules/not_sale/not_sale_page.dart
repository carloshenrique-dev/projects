import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_images.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/application/themes/widgets/text_personalizable_widget.dart';
import 'package:up_afv/application/themes/widgets/title_list_text_widget.dart';
import './not_sale_controller.dart';

class NotSalePage extends GetView<NotSaleController> {
  const NotSalePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.brightness == Brightness.dark
            ? AppColors.grayColor
            : AppColors.whiteColor,
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.06, vertical: Get.height * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: TitleListTextWidget(
                    text: 'Não Venda',
                  ),
                ),
                Divider(
                  color: theme.brightness == Brightness.dark
                      ? AppColors.whiteDefault
                      : AppColors.grayColor,
                  thickness: 0.7,
                ),
                SizedBox(
                  height: Get.height * .01,
                ),
                TextPersonalizableWidget(
                    style: theme.brightness == Brightness.dark
                        ? AppTextStyles.productBodyWhite
                        : AppTextStyles.productBodyDark,
                    text: 'Selecione o cliente',
                    maxLines: 1),
                SizedBox(
                  height: Get.height * 0.065,
                  width: Get.width,
                  child: Card(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                        borderSide: BorderSide.none),
                    margin: EdgeInsets.zero,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 315),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                              const IconData(0xf0072,
                                  fontFamily: 'MaterialIcons'),
                              color: theme.brightness == Brightness.dark
                                  ? AppColors.whiteDefault
                                  : AppColors.grayColor),
                        )),
                  ),
                ),
                SizedBox(
                  height: Get.height * .01,
                ),
                TextPersonalizableWidget(
                    style: theme.brightness == Brightness.dark
                        ? AppTextStyles.productBodyWhite
                        : AppTextStyles.productBodyDark,
                    text: 'Selecione o motivo de não venda',
                    maxLines: 1),
                SizedBox(
                  height: Get.height * .001,
                ),
                Obx(() => SizedBox(
                      height: Get.height * 0.062,
                      width: Get.width,
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: DropdownButton(
                            onChanged: (newValue) {
                              controller.selected(newValue.toString());
                            },
                            value: controller.selected.value,
                            isExpanded: true,
                            underline: const SizedBox(),
                            items: controller.list.map((selectedType) {
                              return DropdownMenuItem(
                                child: TextPersonalizableWidget(
                                    style: theme.brightness == Brightness.dark
                                        ? AppTextStyles.textFieldTitleWhite
                                        : AppTextStyles.textFieldTitleDark,
                                    text:
                                        '${selectedType.code.toString()} - ${selectedType.motive.toLowerCase().capitalizeFirst}',
                                    maxLines: 1),
                                value: selectedType.motive,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: Get.height * .01,
                ),
                TextPersonalizableWidget(
                    style: theme.brightness == Brightness.dark
                        ? AppTextStyles.productBodyWhite
                        : AppTextStyles.productBodyDark,
                    text: 'Insira a observação',
                    maxLines: 1),
                SizedBox(
                  height: Get.height * .001,
                ),
                TextFormField(
                  cursorColor: AppColors.darkBlueCard,
                  decoration: InputDecoration(
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
                        borderSide:
                            const BorderSide(color: AppColors.darkBlueCard),
                      ),
                      fillColor: AppColors.lightGray),
                ),
                SizedBox(
                  height: Get.height * .04,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    height: Get.height * 0.07,
                    width: Get.width * 0.7,
                    child: Card(
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          borderSide: BorderSide.none),
                      color: AppColors.defaultGreen,
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.width * 0.15,
                            ),
                            SizedBox(
                              height: Get.height * 0.065,
                              width: Get.width * 0.065,
                              child: Image.asset(
                                AppImages.plane,
                                color: AppColors.whiteDefault,
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.06,
                            ),
                            TextPersonalizableWidget(
                                style: AppTextStyles.buttonText,
                                text: 'Enviar',
                                maxLines: 1),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
