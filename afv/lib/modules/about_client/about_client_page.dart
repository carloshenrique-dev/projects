import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/modules/customers_adresses/customers_adresses_page.dart';
import 'package:up_afv/modules/customers_details/customer_details_page.dart';
import 'package:up_afv/modules/customers_sales/customers_sales_page.dart';
import 'package:up_afv/modules/financial_position/financial_position_page.dart';
import './about_client_controller.dart';
import 'widgets/bottom_navigation_bar_widget.dart';

class AboutClientPage extends GetView<AboutClientController> {
  const AboutClientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: controller.pageController,
          onPageChanged: (value) => controller.navigationBar(value),
          children: [
            CustomerDetailsPage(
              key: UniqueKey(),
            ),
            FinancialPositionPage(
              key: UniqueKey(),
            ),
            CustomersSalesPage(
              key: UniqueKey(),
            ),
            CustomersAdressesPage(
              key: UniqueKey(),
            ),
          ],
        ),
        bottomNavigationBar: Obx(() {
          return BottomNavigationBarWidget(
            index: controller.currentPage.value,
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
                icon: const Icon(Icons.monetization_on),
                label: 'posFin'.tr,
                backgroundColor: theme.brightness == Brightness.dark
                ? AppColors.whiteColor
                : AppColors.grayColor,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.history),
                label: 'lastPurchase'.tr,
                backgroundColor: theme.brightness == Brightness.dark
                ? AppColors.whiteColor
                : AppColors.grayColor,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.directions),
                label: 'adresses'.tr,
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
}
