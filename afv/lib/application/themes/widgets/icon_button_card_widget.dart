import 'package:flutter/material.dart';

class IconButtonCardWidget extends StatelessWidget {
  final VoidCallback? function;
  final IconData icon;
  final Color color;
  const IconButtonCardWidget({
    Key? key,
    required this.function,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      onPressed: function,
      icon: Icon(
        icon,
        color: color,
        size: 35,
      ),
    );
  }
}
