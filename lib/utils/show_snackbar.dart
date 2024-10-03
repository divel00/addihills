import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar(); // Dismiss the current SnackBar if any
  messenger.showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

