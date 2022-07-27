import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/core/models/customers/customers_address_model.dart';
import 'package:up_afv/core/models/customers/customers_model.dart';
import '../../../application/themes/widgets/icon_button_card_widget.dart';
import 'text_flip_card_widget.dart';

class FlipCardWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final CustomersModel cli;
  final CustomersAddressModel? addressModel;
  final int type;
  final VoidCallback? openMaps;
  final VoidCallback? openWaze;
  final VoidCallback? openWhats;
  final VoidCallback? openPhone;
  final VoidCallback? openEmail;
  const FlipCardWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.cli,
    this.addressModel,
    required this.type,
    this.openMaps,
    this.openWaze,
    this.openWhats,
    this.openPhone,
    this.openEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.brightness == Brightness.dark
            ? AppColors.lightGray
            : AppColors.grayLight,
      ),
      child: FlipCard(
        direction: FlipDirection.VERTICAL,
        front: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: theme.brightness == Brightness.dark
                  ? AppColors.whiteDefault
                  : AppColors.grayColor,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Text(
              title,
              style: theme.brightness == Brightness.dark
                  ? AppTextStyles.productTitleWhite
                  : AppTextStyles.productTitleDark,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        back: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.003,
            horizontal: Get.width * 0.025,
          ),
          child: returnBackCard(theme),
        ),
      ),
    );
  }

  Widget returnBackCard(ThemeData theme) {
    if (type == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFlipCardWidget(
            text:
                '${addressModel?.address}, ${addressModel?.numberAddress},\n${addressModel?.neighborhood}, ${addressModel?.city}-${addressModel?.state}. ',
            maxLines: 2,
          ),
          TextFlipCardWidget(
            text: 'CEP: ${addressModel?.postalCode}',
            maxLines: 1,
          ),
          SizedBox(
            height: Get.height * 0.005,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButtonCardWidget(
                function: openMaps,
                icon: FontAwesomeIcons.mapMarkerAlt,
                color: theme.brightness == Brightness.dark
                    ? AppColors.whiteDefault
                    : AppColors.grayColor,
              ),
              SizedBox(
                width: Get.width * 0.05,
              ),
              IconButtonCardWidget(
                function: openWaze,
                icon: FontAwesomeIcons.waze,
                color: theme.brightness == Brightness.dark
                    ? AppColors.whiteDefault
                    : AppColors.grayColor,
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: cli.contact != '',
            child: TextFlipCardWidget(
              text: '${'talkTo'.tr} ${cli.contact}\n',
              maxLines: 1,
            ),
          ),
          Visibility(
            visible: cli.phones != '',
            child: TextFlipCardWidget(
              text: '${'phone'.tr} ${cli.phones}\n',
              maxLines: 1,
            ),
          ),
          Visibility(
            visible: cli.mail != '',
            child: TextFlipCardWidget(
              text: '${cli.mail}',
              maxLines: 1,
            ),
          ),
          SizedBox(
            height: Get.height * 0.005,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButtonCardWidget(
                function: openWhats,
                icon: FontAwesomeIcons.whatsapp,
                color: AppColors.green,
              ),
              SizedBox(
                width: Get.width * 0.05,
              ),
              IconButtonCardWidget(
                function: openPhone,
                icon: FontAwesomeIcons.phone,
                color: AppColors.green,
              ),
              SizedBox(
                width: Get.width * 0.05,
              ),
              IconButtonCardWidget(
                function: openEmail,
                icon: Icons.email,
                color: AppColors.green,
              ),
            ],
          ),
        ],
      );
    }
  }
}
