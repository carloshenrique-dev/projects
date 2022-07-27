import 'package:flutter/material.dart';

class DefaultButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback funcao;
  final TextStyle style;
  final Color color;
  const DefaultButtonWidget(
      {Key? key,
      required this.text,
      required this.funcao,
      required this.style,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: funcao,
        style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          backgroundColor: color,
        ),
        child: Text(
          text,
          style: style,
        ));
  }
}
