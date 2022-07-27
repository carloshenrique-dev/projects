import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/application/themes/widgets/search_box_widget.dart';
import 'package:up_afv/modules/sale_order/sale_order_controller.dart';
import '../custom_widgets/add_remove_product_widget.dart';

class ProductsOrderPage extends GetView<SaleOrderController> {
  const ProductsOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Get.height * .02,
        ),
        SearchBoxWidget(
          keyboard: controller.filterBy.value == 0
              ? TextInputType.number
              : TextInputType.text,
          focus: controller.focus,
          onChanged: (value) => (value), //controller.choosePath(value),
          hintSearch: controller.hintSearch.value,
          controller: controller.textController,
          onPressed: () => controller.clearSearch(),
          clearButton: controller.clearButton.value,
        ),
        SizedBox(
          height: Get.height * .01,
        ),
        Obx(
          () {
            if (controller.products.isEmpty) {
              return Expanded(
                child: Center(
                  child: Text(
                    'Oops! Não existem produtos a serem exibidos ;(',
                    style: AppTextStyles.homeTitleWhite,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.products.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    controller.productsControllers.add(TextEditingController());
                    var products = controller.products[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: AddRemoveProductWidget(
                        product: products,
                        controller: controller.productsControllers[index],
                        backgroundColor: Colors.white,
                        plusCallback: () =>
                            controller.incrementItem(products, index),
                        minusCallback: () =>
                            controller.subtractItem(products, index),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
