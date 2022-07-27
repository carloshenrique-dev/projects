import 'package:flutter/material.dart';

class TextCardProdutoWidget extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int maxLines;
  const TextCardProdutoWidget(
      {Key? key,
      required this.text,
      required this.style,
      required this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        style: style,
      ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      textAlign: TextAlign.center,
    );
  }
}
