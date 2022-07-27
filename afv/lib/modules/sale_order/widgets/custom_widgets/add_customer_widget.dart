import 'package:flutter/material.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';

class AddCustomerWidget extends StatelessWidget {
  final Function()? onPressed;

  const AddCustomerWidget({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
          const EdgeInsets.all(12),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          AppColors.lightGray,
        ),
        shape: MaterialStateProperty.all<OutlinedBorder?>(
          const CircleBorder(),
        ),
      ),
      onPressed: onPressed,
      child: const Icon(
        Icons.add,
        size: 25,
        color: AppColors.whiteDefault,
      ),
    );
  }
}
