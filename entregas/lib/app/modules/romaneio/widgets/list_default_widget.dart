import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/models/item_romaneio/romaneio_itens.dart';
import 'package:upentregas/app/services/database.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';
import 'package:upentregas/app/shared/widgets/view_custom/functions_custom.dart';

class ListDefaultWidget extends StatelessWidget {
  final RomaneioItens item;
  final int? romaneioId;
  final String? idItem;

  const ListDefaultWidget({
    Key? key,
    required this.item,
    this.romaneioId,
    this.idItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      elevation: 6.0,
      margin: EdgeInsets.symmetric(
          horizontal: Get.width * 0.013, vertical: Get.height * 0.005),
      child: Center(
        child: Stack(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.05, vertical: Get.height * 0.002),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    changeIcon(item),
                    color: checkIfDarkModeEnabled(context),
                  ),
                ],
              ),
              title: Wrap(
                direction: Axis.horizontal,
                children: [
                  Column(
                    children: [
                      Text(
                        '${item.cliente!['NomeFantasia']} ',
                        style: theme.brightness == Brightness.dark
                            ? AppTextStyles.title16
                            : AppTextStyles.title16Black,
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        '${item.enderecoEntrega!['logradouro']}, '
                        '${item.enderecoEntrega!['numero']}, '
                        '${item.enderecoEntrega!['bairro']}, '
                        '${item.enderecoEntrega!['cidade']}-'
                        '${item.enderecoEntrega!['UF']}.\n'
                        'Status: ${verificaStatus(item.entregaConcluida, item.rotaEntrega)}',
                        style: theme.brightness == Brightness.dark
                            ? AppTextStyles.title14
                            : AppTextStyles.title14Black,
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () {
                Get.toNamed(
                  '/romaneiodetails',
                  parameters: {
                    'romaneioId': '$romaneioId',
                  },
                  arguments: item,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
