import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showWelcomeSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Selamat Datang Diaplikasi Morfo"),
      ),
    );
  }
}
