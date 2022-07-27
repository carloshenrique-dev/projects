import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final Function(int)? onTap;
  final int index;
  final List<BottomNavigationBarItem> items;
  const BottomNavigationBarWidget({
    Key? key,
    this.onTap,
    required this.index,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: [
          theme.brightness == Brightness.dark
              ? const BoxShadow(
                  color: Colors.white38, spreadRadius: 0.5, blurRadius: 5)
              : const BoxShadow(
                  color: Colors.black38, spreadRadius: 0.5, blurRadius: 5),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          iconSize: 27,
          currentIndex: index,
          onTap: onTap,
          items: items,
        ),
      ),
    );
  }
}
