import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/application/themes/widgets/details_card_widget.dart';
import 'package:up_afv/application/themes/widgets/title_text_widget.dart';
import 'package:up_afv/modules/product_details/widgets/price_list_card_widget.dart';
import './product_details_controller.dart';

class ProductDetailsPage extends GetView<ProductDetailsController> {
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.dark
          ? AppColors.grayColor
          : AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Column(children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      height: Get.height * 0.40,
                      decoration: BoxDecoration(
                        color: AppColors.whiteDefault,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: Image.memory(
                            controller
                                .dataFromBase64String(controller.prod.imagem!),
                          ).image,
                          fit: BoxFit.scaleDown,
                          isAntiAlias: true,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Text(
                    '${'codCli'.tr}${controller.prod.codProd}',
                    style: theme.brightness == Brightness.dark
                        ? AppTextStyles.prodDetailsWhite
                        : AppTextStyles.prodDetailsDark,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  TitleTextWidget(
                    text: '${controller.prod.descricao!.capitalizeFirst}',
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: Get.height * 0.007,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.waterGreen,
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.03,
                        vertical: Get.height * 0.009,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: Get.width * 0.80,
                          child: Text(
                            '${'inStock'.tr} ${controller.prod.estoqueInicial} ${controller.prod.unid}',
                            style: AppTextStyles.prodDetailsHeadWhite,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.010,
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Get.width,
                                child: TitleTextWidget(
                                  text: 'detailsProd'.tr,
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              DetailsCardWidget(
                                isVisible3Text: true,
                                containerSizeWidth: Get.width * .9,
                                text1: '${'class2'.tr}${controller.prod.obs}',
                                text2:
                                    '${'saleUnit'.tr} ${controller.prod.unid}',
                                text3: '${'obs'.tr} ${controller.prod.classe}',
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              TitleTextWidget(
                                text: 'convDetails'.tr,
                                maxLines: 1,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              DetailsCardWidget(
                                isVisible3Text: false,
                                containerSizeWidth: Get.width * .9,
                                text1:
                                    'P.E: ${controller.prod.peQtd} ${controller.prod.peUnid}',
                                text2:
                                    '${'factor'.tr}: ${controller.prod.fator} ${controller.prod.fatorUnid}',
                                text3: '',
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleTextWidget(
                              text: 'priceList'.tr,
                              maxLines: 1,
                            ),
                            Flexible(
                              child: SizedBox(
                                width: Get.width * .9,
                                child: Obx(
                                  () {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controller.list.length,
                                      itemBuilder: (context, index) {
                                        var pricesList = controller.list[index];
                                        if (controller.list.isEmpty) {
                                          return const Center(
                                            child: Text(
                                                'Produto sem listas de preco cadastradas'),
                                          );
                                        } else {
                                          return InkWell(
                                            onTap: () =>
                                                controller.showPriceList(
                                                    context: context,
                                                    priceList: pricesList),
                                            child: PriceListCardWidget(
                                              title:
                                                  '${pricesList.priceCode} - ${'sale'.tr} ${pricesList.salePrice} ${pricesList.unit}',
                                              subtitle:
                                                  '${'minimum'.tr} ${pricesList.minPrice}',
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
