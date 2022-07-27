import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final Color? color;
  final EdgeInsets? padding;

  const Logo({Key? key, this.color, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: padding,
          child: const Center(
            child: ImageIcon(
              AssetImage('assets/images/logo.png'),
              size: 150.0,
            ),
          ),
        ),
      ],
    );
  }
}
