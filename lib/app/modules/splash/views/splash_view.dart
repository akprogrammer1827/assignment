import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  final SplashController controller = Get.put(SplashController());
  SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Container(
        color: white,
        child: Center(
          child: Image.asset(
            "assets/images/stemm_one_logo.jpg",
            height: 182,
            width: 360,
          ),
        ),
      ),
    );
  }
}
