import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/widgets/title_list_text_widget.dart';
import './customers_adresses_controller.dart';
import 'widgets/address_card_widget.dart';

class CustomersAdressesPage extends GetView<CustomersAdressesController> {
  const CustomersAdressesPage({Key? key}) : super(key: key);

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
            const Align(
              alignment: Alignment.centerLeft,
              child: TitleListTextWidget(
                text: 'Endereços',
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
                itemCount: controller.list.length,
                itemBuilder: (BuildContext context, int index) {
                  var adresses = controller.list[index];
                  return GestureDetector(
                    onTap: () async {
                      await controller.chooseNavigation(adresses);
                    },
                    child: AddressCardWidget(
                      address: adresses,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
