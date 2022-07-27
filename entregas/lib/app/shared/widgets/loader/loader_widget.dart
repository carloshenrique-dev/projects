import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';

class LoaderWidget extends StatelessWidget {
  final bool isLoading;

  const LoaderWidget({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Visibility(
      visible: isLoading,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              children: [
                Text(
                  'loading'.tr,
                  style: theme.brightness == Brightness.dark
                      ? AppTextStyles.title18
                      : AppTextStyles.title18Black,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade800),
            ),
          ],
        ),
      ),
    );
  }
}
