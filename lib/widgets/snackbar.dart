import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

void showSnackBar(String content, {BuildContext? context}) {
  final snackbar = SnackBar(content: Text(content));
  if (context == null) {
    snackbarKey.currentState?.showSnackBar(snackbar);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
