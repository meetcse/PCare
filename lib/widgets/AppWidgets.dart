import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';

class AppWidgets {
  static Future customProgressDialog({double height, double size}) {
    return Get.dialog(
      CustomProgressIndicatorWidget(
        height: height,
        size: size,
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.1),
    );
  }

  static Future closeDialog() {
    if (Get.isDialogOpen) {
      Get.back();
    }
  }
}
