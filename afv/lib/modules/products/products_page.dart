import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/application/themes/widgets/filter_row_widget.dart';
import 'package:up_afv/application/themes/widgets/search_box_widget.dart';
import 'package:up_afv/application/themes/widgets/title_list_text_widget.dart';
import 'products_controller.dart';
import 'widgets/card_produto_widget.dart';

class ProductsPage extends GetView<ProductsController> {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.brightness == Brightness.dark
            ? AppColors.grayColor
            : AppColors.whiteColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TitleListTextWidget(
                    text: 'findProd'.tr,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Obx(
                  () {
                    return SearchBoxWidget(
                      keyboard: controller.filterBy.value == 0
                          ? TextInputType.number
                          : TextInputType.text,
                      focus: controller.focus,
                      onChanged: (value) => controller.choosePath(value),
                      hintSearch: controller.hintSearch.value,
                      controller: controller.textController,
                      onPressed: () => controller.clearSearch(),
                      clearButton: controller.clearButton.value,
                    );
                  },
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Obx(
                  () {
                    return FilterRowWidget(
                      textButton1: 'cod'.tr,
                      textButton2: 'class'.tr,
                      textButton3: 'desc'.tr,
                      colorButton1: controller.filterBy.value == 0
                          ? AppColors.softBlueCard
                          : theme.brightness == Brightness.dark
                              ? AppColors.whiteDefault
                              : AppColors.grayColor,
                      colorButton2: controller.filterBy.value == 1
                          ? AppColors.softBlueCard
                          : theme.brightness == Brightness.dark
                              ? AppColors.whiteDefault
                              : AppColors.grayColor,
                      colorButton3: controller.filterBy.value == 2
                          ? AppColors.softBlueCard
                          : theme.brightness == Brightness.dark
                              ? AppColors.whiteDefault
                              : AppColors.grayColor,
                      func1: () async => await controller.putOnCode(),
                      func2: () async => await controller.putOnClass(),
                      func3: () async => await controller.putOnDescription(),
                      textStyle1: controller.filterBy.value == 0
                          ? AppTextStyles.textFieldTitleWhite
                          : theme.brightness == Brightness.dark
                              ? AppTextStyles.textFieldTitleDark
                              : AppTextStyles.textFieldTitleWhite,
                      textStyle2: controller.filterBy.value == 1
                          ? AppTextStyles.textFieldTitleWhite
                          : theme.brightness == Brightness.dark
                              ? AppTextStyles.textFieldTitleDark
                              : AppTextStyles.textFieldTitleWhite,
                      textStyle3: controller.filterBy.value == 2
                          ? AppTextStyles.textFieldTitleWhite
                          : theme.brightness == Brightness.dark
                              ? AppTextStyles.textFieldTitleDark
                              : AppTextStyles.textFieldTitleWhite,
                    );
                  },
                ),
                SizedBox(
                  height: Get.height * 0.013,
                ),
                Obx(
                  () {
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: Get.height * 0.01,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: controller.lista.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var produto = controller.lista[index];
                          if (controller.lista.isEmpty) {
                            return SizedBox(
                                height: Get.height * 0.54,
                                child: const Center(
                                    child: CircularProgressIndicator()));
                          } else {
                            return InkWell(
                              onTap: () => Get.toNamed(
                                '/productdetails',
                                arguments: produto,
                              ),
                              child: CardProdutoWidget(
                                visibility: true,
                                model: produto,
                                reordenateList: controller.filterBy.value,
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
