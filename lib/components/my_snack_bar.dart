import 'package:flutter/material.dart';

void showCostumSnackBar({
  required BuildContext context,
  required String message,
  String? type,
}) {
  Color color = Colors.grey;
  if (type == "success") {
    color = Colors.green;
  } else if (type == "danger") {
    color = Colors.red;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      backgroundColor: color,
    ),
  );
}
