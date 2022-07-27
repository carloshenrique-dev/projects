import 'package:flutter/material.dart';

class TextCardClientesWidget extends StatelessWidget {
  final String? text;
  final TextStyle style;
  const TextCardClientesWidget(
      {Key? key, required this.text, required this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text.rich(
        TextSpan(
          text: text,
          style: style,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
      ),
    );
  }
}
