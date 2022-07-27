import 'package:flutter/material.dart';

class ErrorTextWidget extends StatelessWidget {
  final String text;
  final TextStyle style;
  const ErrorTextWidget({
    Key? key,
    required this.text,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      maxLines: 4,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );
  }
}
