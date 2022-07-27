import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/core/models/customers/customers_address_model.dart';
import 'package:up_afv/modules/customers_adresses/customers_adresses_controller.dart';
import 'text_card_widget.dart';

class AddressCardWidget extends GetView<CustomersAdressesController> {
  final CustomersAddressModel address;
  const AddressCardWidget({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Get.height * 0.005,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: AppColors.lightGray,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 25,
                      horizontal: 25,
                    ),
                    child: address.type == 'E'
                        ? const Icon(
                            FontAwesomeIcons.truck,
                            color: AppColors.defaultGreen,
                          )
                        : const Icon(
                            FontAwesomeIcons.fileInvoiceDollar,
                            color: AppColors.red,
                          ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: Get.width * .06,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCardWidget(
                    text:
                        '${address.address}, ${address.numberAddress}, ${address.neighborhood}.\n${address.city} -  ${address.state}.\nCEP: ${address.postalCode}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
