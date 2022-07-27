import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/modules/about_client/widgets/bottom_navigation_bar_widget.dart';
import 'package:up_afv/modules/sale_order/widgets/pages/register_order_page.dart';
import './sale_order_controller.dart';
import 'widgets/pages/products_order_page.dart';

class SaleOrderPage extends GetView<SaleOrderController> {
  const SaleOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Obx(
              () => _buildPage(),
            ),
          ),
        ),
        bottomNavigationBar: Obx(() {
          return BottomNavigationBarWidget(
            index: controller.page.value,
            onTap: (value) => controller.navigationBar(value),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: 'detailsCli'.tr,
                backgroundColor: theme.brightness == Brightness.dark
                    ? AppColors.whiteColor
                    : AppColors.grayColor,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_cart_outlined),
                label: 'Items',
                backgroundColor: theme.brightness == Brightness.dark
                    ? AppColors.whiteColor
                    : AppColors.grayColor,
              ),
            ],
          );
        }),
      ),
    );
  }

  _buildPage() {
    if (controller.page.value == 0) {
      return const RegisterOrderPage();
    } else if (controller.page.value == 1) {
      return const ProductsOrderPage();
    }
  }
}
