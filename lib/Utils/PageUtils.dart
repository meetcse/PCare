import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageUtils {
  static pushPage(
    Widget page,
  ) {
    Get.to(page, transition: Transition.fadeIn);
  }

  static pushPageAndRemoveAll(Widget page) {
    Get.offAll(page, transition: Transition.fadeIn);
  }

  static pushPageAndRemoveCurrentPage(Widget page) {
    Get.off(page, transition: Transition.fadeIn);
  }

  static popCurrentPage() {
    Get.back();
  }
}
