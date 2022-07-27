import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/application/themes/widgets/combo_box_widget.dart';
import 'package:up_afv/application/themes/widgets/text_personalizable_widget.dart';
import 'package:up_afv/application/themes/widgets/title_list_text_widget.dart';
import 'package:up_afv/modules/sale_order/sale_order_controller.dart';
import 'package:up_afv/modules/sale_order/widgets/custom_widgets/add_customer_widget.dart';
import 'package:up_afv/modules/sale_order/widgets/custom_widgets/customer_widget.dart';
import 'package:up_afv/modules/sale_order/widgets/custom_widgets/text_field_sale_order_widget.dart';

class RegisterOrderPage extends GetView<SaleOrderController> {
  const RegisterOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * .01,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: TitleListTextWidget(
              text: 'Cadastrar pedido',
            ),
          ),
          Divider(
            color: theme.brightness == Brightness.dark
                ? AppColors.whiteDefault
                : AppColors.grayColor,
            thickness: 0.7,
          ),
          SizedBox(
            height: Get.height * .005,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () {
                  return CustomerWidget(
                    customer: controller.customerName.value.capitalizeFirst!,
                  );
                },
              ),
              AddCustomerWidget(
                onPressed: () async =>
                    await controller.handleDataFromSecondPage(),
              )
            ],
          ),
          SizedBox(
            height: Get.height * 0.012,
          ),
          Text(
            'Condição de pagamento',
            style: theme.brightness == Brightness.dark
                ? AppTextStyles.productDetailsWhite
                : AppTextStyles.productDetailsDark,
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: Get.height * .01,
          ),
          ComboBoxWidget(
            items: [
              DropdownMenuItem<String>(
                child: TextPersonalizableWidget(
                    style: AppTextStyles.textFieldTitleWhite,
                    text: 'item 1',
                    maxLines: 1),
                value: '0',
              )
            ],
            height: Get.height * .07,
          ),
          SizedBox(
            height: Get.height * .012,
          ),
          Text(
            'Movimento',
            style: theme.brightness == Brightness.dark
                ? AppTextStyles.productDetailsWhite
                : AppTextStyles.productDetailsDark,
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: Get.height * .01,
          ),
          ComboBoxWidget(
            items: [
              DropdownMenuItem<String>(
                child: TextPersonalizableWidget(
                    style: AppTextStyles.textFieldTitleWhite,
                    text: 'item 1',
                    maxLines: 1),
                value: '0',
              )
            ],
            height: Get.height * .07,
          ),
          SizedBox(
            height: Get.height * .012,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              width: Get.width * .6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lista de precos',
                    style: theme.brightness == Brightness.dark
                        ? AppTextStyles.productDetailsWhite
                        : AppTextStyles.productDetailsDark,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: Get.height * .01,
                  ),
                  ComboBoxWidget(
                    items: [
                      DropdownMenuItem<String>(
                        child: Center(
                          child: TextPersonalizableWidget(
                              style: AppTextStyles.textFieldTitleWhite,
                              text: 'item 1',
                              maxLines: 1),
                        ),
                        value: '0',
                      )
                    ],
                    height: Get.height * .083,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Get.width * .25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Desconto',
                    style: theme.brightness == Brightness.dark
                        ? AppTextStyles.productDetailsWhite
                        : AppTextStyles.productDetailsDark,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: Get.height * .01,
                  ),
                  SizedBox(
                    height: Get.height * .065,
                    child: TextFieldSaleOrderWidget(
                      hintText: '0%',
                      controller: controller.obsController,
                      textInputAction: TextInputAction.send,
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                ],
              ),
            ),
          ]),
          SizedBox(
            height: Get.height * .012,
          ),
          Text(
            'Observação do pedido',
            style: theme.brightness == Brightness.dark
                ? AppTextStyles.productDetailsWhite
                : AppTextStyles.productDetailsDark,
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: Get.height * .01,
          ),
          TextFieldSaleOrderWidget(
            hintText: 'Ex: Pedido pronto',
            controller: controller.obsController,
            textInputAction: TextInputAction.send,
            onFieldSubmitted: (value) {},
          ),
          SizedBox(
            height: Get.height * .012,
          ),
          Text(
            'Data de entrega',
            style: theme.brightness == Brightness.dark
                ? AppTextStyles.productDetailsWhite
                : AppTextStyles.productDetailsDark,
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: Get.height * .01,
          ),
          TextFormField(
            keyboardType: TextInputType.datetime,
            showCursor: false,
            controller: controller.dateController,
            readOnly: true,
            style: AppTextStyles.ordersWhiteLabel,
            onTap: () => controller.selectDate(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  7.0,
                ),
                borderSide: BorderSide.none,
              ),
              filled: true,
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(7.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(7.0),
              ),
              fillColor: AppColors.lightGray,
            ),
          ),
        ],
      ),
    );
  }
}
