import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

/// All app level utility methods are defined here
class Utils {
  Utils._();

  /// Show common snack bar messages
  static void showMessage(String title, String message, {snackPosition = SnackPosition.BOTTOM}) {
    Get.snackbar(title, message, snackPosition: snackPosition);
  }

  /// Close keyboard
  static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// Show popup dialog with title and message
  static void showPopupDialog(
    String title,
    String message, {
    bool isDismissible = false,
    String? textConfirm,
    Future<bool> Function()? onWillPop,
    VoidCallback? onConfirm,
    Color? confirmTextColor,
  }) {
    Get.defaultDialog(
        title: title,
        middleText: message,
        barrierDismissible: isDismissible,
        textConfirm: textConfirm,
        onWillPop: onWillPop,
        onConfirm: onConfirm,
        confirmTextColor: confirmTextColor);
  }
}
