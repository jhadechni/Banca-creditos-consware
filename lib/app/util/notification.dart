import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationBuilder {
  NotificationBuilder();

  void showErrorSnackbar(String title, String body) {
    Get.snackbar(
      title,
      body,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  void showSuccesSnackbar(String title, String body) {
    Get.snackbar(
      title,
      body,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }
}
