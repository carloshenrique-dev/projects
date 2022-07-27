import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_images.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'text_personalizable_widget.dart';

final List cards = [
  {
    'title': 'Venda',
    'icon': AppImages.moneySolid,
    'page': '/saleorder',
  },
  {
    'title': 'Agenda',
    'icon': AppImages.calendarSolid,
    'page': '/products',
  },
  {
    'title': 'Caixa Vendedor',
    'icon': AppImages.cashRegisterSolid,
    'page': '/products',
  },
  {
    'title': 'Clientes',
    'icon': AppImages.idCardSolid,
    'page': '/customers',
  },
  {
    'title': 'Metas',
    'icon': AppImages.bullseyeSolid,
    'page': '/products',
  },
  {
    'title': 'Não Venda',
    'icon': AppImages.xSolid,
    'page': '/notSale',
  },
  {
    'title': 'Pré Cadastro',
    'icon': AppImages.penSolid,
    'page': '/products',
  },
  {
    'title': 'Produtos',
    'icon': AppImages.boxSolid,
    'page': '/products',
  },
  {
    'title': 'Relatórios',
    'icon': AppImages.fineLinesSolid,
    'page': '/products',
  },
  {
    'title': 'Utilitários',
    'icon': AppImages.gearSolid,
    'page': '/products',
  },
  {
    'title': 'Verba Comercial',
    'icon': AppImages.moneyCardSolid,
    'page': '/products',
  },
  {
    'title': 'Logout',
    'icon': AppImages.logOut,
    'page': '/products',
  },
];

class SidebarMenuWidget extends StatelessWidget {
  const SidebarMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Drawer(
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.07,
                        width: Get.width * 0.15,
                        child: Image.asset(
                          AppImages.userSolid,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Get.width * .05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextPersonalizableWidget(
                          style: AppTextStyles.textFieldTitleDetailsDark,
                          text: 'USER 2319',
                          maxLines: 1),
                      TextPersonalizableWidget(
                          style: AppTextStyles.searchBarHintText,
                          text: '#ID 2756',
                          maxLines: 1),
                    ],
                  ),
                ],
              ),
            ),
            decoration: const BoxDecoration(
              color: AppColors.whiteGray,
            ),
          ),
          Expanded(
            child: _buildItems(theme),
          ),
        ],
      ),
    );
  }

  _buildItems(ThemeData theme) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const Divider(
          height: 0.5,
          color: AppColors.body,
        );
      },
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    cards[index]['icon'],
                    height: 30,
                    width: 30,
                    filterQuality: FilterQuality.high,
                  ),
                  SizedBox(
                    width: Get.width * .05,
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(cards[index]['page']),
                    child: Text(
                      cards[index]['title'],
                      style: theme.brightness == Brightness.dark
                          ? AppTextStyles.textFieldTitleWhite
                          : AppTextStyles.textFieldTitleDark,
                    ),
                  ),
                ],
              ),
              const Icon(
                IconData(0xe09c,
                    fontFamily: 'MaterialIcons', matchTextDirection: true),
                color: AppColors.lightGray,
              ),
            ],
          ),
        );
      },
    );
  }
}
