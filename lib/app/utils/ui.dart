import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'colors.dart';

class UI {
  static exitAppDialog() {
    Get.defaultDialog(
        backgroundColor: white,
        barrierDismissible: false,
        onWillPop: () {
          return Future.value(false);
        },
        title: "Exit",
        titleStyle: const TextStyle(fontSize: 16, color: primary),
        content: const Text(
          "Are you sure you want to exit from the app",
          style: TextStyle(
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: const BorderSide(color: primary)),
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'No',
              style: TextStyle(color: primary),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onPressed: () {
              exit(0);
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: white),
            ),
          ),
        ]);
  }

  static showMessageSnackBar(String title, String message) {
    Get.snackbar(title, message,
        backgroundColor: buttonBackground,
        colorText: white,
        snackPosition: SnackPosition.BOTTOM);
  }

  static showLoading() {
    EasyLoading.instance
      ..backgroundColor = white
      ..indicatorColor = primary
      ..textColor = primary;
    EasyLoading.show(status: 'Loading...', dismissOnTap: false);
  }

  static void hideLoading() {
    EasyLoading.dismiss();
    // Get.back();
  }
}
