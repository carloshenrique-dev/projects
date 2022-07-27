import 'package:flutter/material.dart';

class TextPersonalizableWidget extends StatelessWidget {
  final TextStyle style;
  final String text;
  final int maxLines;
  const TextPersonalizableWidget({
    Key? key,
    required this.style,
    required this.text,
    required this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: TextAlign.start,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
