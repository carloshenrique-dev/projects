import 'package:flutter/material.dart';

class LoaderFimWidget extends StatelessWidget {
  final bool isLoading;

  const LoaderFimWidget({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade800),
            ),
          ],
        ),
      ),
    );
  }
}
