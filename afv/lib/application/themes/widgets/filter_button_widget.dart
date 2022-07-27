import 'package:flutter/material.dart';

class FilterButtonWidget extends StatelessWidget {
  final String texto;
  final Color color;
  final VoidCallback func;
  final TextStyle textStyle;
  const FilterButtonWidget({
    Key? key,
    required this.texto,
    required this.color,
    required this.func,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: func,
      child: Text(
        texto,
        style: textStyle,
        textAlign: TextAlign.center,
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(color),
      ),
    );
  }
}
