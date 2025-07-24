import 'package:flutter/material.dart';

extension Snackbar on BuildContext {
  void showSnackBar({
    required BuildContext context,
    required String message,
  }) {
    final snackBar = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
      ),
      action: SnackBarAction(
        label: 'Close',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
