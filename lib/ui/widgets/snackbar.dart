import 'package:flutter/material.dart';

void ShowSnackBar(BuildContext context, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      action: SnackBarAction(
        label: 'OKE',
        onPressed: scaffold.hideCurrentSnackBar,
      ),
    ),
  );
}
