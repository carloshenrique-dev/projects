import 'package:flutter/material.dart';

class BottomSheetButtonWidget extends StatelessWidget {
  final VoidCallback funcao;
  final Color color;
  final IconData? icon;
  const BottomSheetButtonWidget(
      {Key? key, required this.funcao, required this.color, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 35,
      icon: Icon(icon),
      onPressed: funcao,
      color: color,
    );
  }
}
