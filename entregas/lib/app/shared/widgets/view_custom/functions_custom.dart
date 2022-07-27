import 'package:flutter/material.dart';
import 'package:upentregas/app/services/database.dart';

checkIfDarkModeEnabled(BuildContext context) {
  final ThemeData theme = Theme.of(context);

  if (theme.brightness == Brightness.dark) {
    return Colors.white;
  } else {
    return Colors.black;
  }
}

backgSignature(BuildContext context) {
  final ThemeData theme = Theme.of(context);

  if (theme.brightness == Brightness.dark) {
    return Colors.white;
  } else {
    return const Color(0xFFe9e9e9);
  }
}

changeIcon(_prefs) {
  if (verificaStatus(_prefs.entregaConcluida, _prefs.rotaEntrega) ==
      'pendente') {
    return Icons.directions_car;
  } else if (verificaStatus(_prefs.entregaConcluida, _prefs.rotaEntrega) ==
      'em andamento') {
    return Icons.navigation;
  } else {
    return Icons.check;
  }
}
