import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';

class RomaneioCardWidget extends StatelessWidget {
  final int? id;
  final VoidCallback funcao;
  final String titulo;
  final Color color;
  final IconData icon;

  const RomaneioCardWidget({
    Key? key,
    this.id,
    required this.funcao,
    required this.titulo,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 10.0,
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05, vertical: Get.height * 0.01),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white),
              ],
            ),
            title: Text(
              titulo,
              style: AppTextStyles.title20,
            ),
            onTap: funcao,
          ),
        ],
      ),
    );
  }
}
