import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/application/themes/widgets/title_list_text_widget.dart';
import 'package:up_afv/core/models/customers/sales_customers_items_model.dart';
import 'customers_sales_controller.dart';

class CustomersSalesPage extends GetView<CustomersSalesController> {
  const CustomersSalesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
        child: Column(
          children: [
            SizedBox(
              height: Get.height * .01,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TitleListTextWidget(
                text: 'lastPurchase'.tr,
              ),
            ),
            Divider(
              color: theme.brightness == Brightness.dark
                  ? AppColors.whiteDefault
                  : AppColors.grayColor,
              thickness: 0.7,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  thickness: 0,
                  color: Colors.transparent,
                  height: 1,
                ),
                itemCount: controller.listItems.length,
                itemBuilder: (BuildContext context, int index) {
                  var customerSale = controller.listItems[index];
                  return Card(
                      margin: EdgeInsets.symmetric(
                        vertical: Get.height * 0.005,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: _buildExpandableTile(customerSale));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableTile(SalesCustomersItemsModel item) {
    return ExpansionTile(
      textColor: Get.isDarkMode ? AppColors.whiteDefault : AppColors.grayColor,
      collapsedIconColor: AppColors.darkBlueCard,
      iconColor: AppColors.darkBlueCard,
      title: Text(
        '''Ped: ${item.salesOrder} - ${controller.formatData(item.saleDate!)}''',
        style: Get.isDarkMode
            ? AppTextStyles.textFieldTitleDetailsWhite
            : AppTextStyles.textFieldTitleDetailsDark,
      ),
      children: _buildExpandableItems(item),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Text(
          '''Mvt: ${item.movementType}''',
        ),
      ),
    );
  }

  _buildExpandableItems(SalesCustomersItemsModel items) {
    return List.generate(
      controller.getProductsList(items.salesOrder!).length,
      (index) {
        var products = controller.getProductsList(items.salesOrder!)[index];
        return Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: SizedBox(
              width: Get.width,
              child: Card(
                color: AppColors.grayColor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Text.rich(
                    TextSpan(
                        text:
                            '${products.productCode} - ${products.productDescription}\n',
                        style: AppTextStyles.labelBottomNavigationWhite,
                        children: [
                          TextSpan(
                            text:
                                '${products.totalAmount}\nLP: ${products.priceList}',
                            style: AppTextStyles.textFieldTitleWhite,
                          )
                        ]),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
