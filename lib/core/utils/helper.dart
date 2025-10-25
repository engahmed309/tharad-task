import 'package:flutter/material.dart';

extension MediaQueryHelper on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  Size get screenSize => MediaQuery.of(this).size;
  // AppLocalizations get translate => AppLocalizations.of(this)!;
}

extension NavigatorHelper on BuildContext {
  void push(Widget page) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => page));
  }
}

extension SnackbarHelper on BuildContext {
  void showSnackBar(
    String message, {
    Color? backGroundColor,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        duration: duration ?? const Duration(seconds: 2),
        backgroundColor: backGroundColor,
        content: Text(message),
      ),
    );
  }
}
