import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/core/models/products_order/products_order_model.dart';
import 'package:up_afv/modules/sale_order/widgets/custom_widgets/text_field_product_widget.dart';

class AddRemoveProductWidget extends StatelessWidget {
  final ProductsOrderModel product;
  final TextEditingController controller;
  final Color? backgroundColor;
  final VoidCallback minusCallback;
  final VoidCallback plusCallback;
  final bool calculateTotal;

  const AddRemoveProductWidget(
      {Key? key,
      required this.plusCallback,
      required this.minusCallback,
      required this.controller,
      required this.product,
      this.backgroundColor,
      this.calculateTotal = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      shadowColor: Colors.black26,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width * .23,
              //height: Get.height * 0.11,
              child: Image.memory(
                dataFromBase64String(product.product.imagem!),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${product.product.descricao!.toLowerCase().capitalizeFirst} - ${product.product.codProd}',
                  style: AppTextStyles.prodDetailsHeadDark,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
                Text(
                  'Estoque: ${product.product.estoqueInicial}',
                  style: AppTextStyles.h3Dark,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
                Text(
                  'Unidade: ${product.product.unid}',
                  style: AppTextStyles.h3Dark,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
                Text(
                  'R\$: ${product.product.vlrVenda}',
                  style: AppTextStyles.h3Dark,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(
              width: Get.width * .16,
              child: Column(
                children: [
                  IconButton(
                    onPressed: plusCallback,
                    padding: const EdgeInsets.only(bottom: 05),
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.green,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * .05,
                    child: TextFieldProductWidget(
                      controller: controller,
                      plusCallback: plusCallback,
                      minusCallback: minusCallback,
                    ),
                  ),
                  IconButton(
                    onPressed: minusCallback,
                    padding: const EdgeInsets.only(top: 05),
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.remove,
                      color: AppColors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }
}
