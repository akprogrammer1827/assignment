import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'app/data/providers/api_service.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/app_theme.dart';
import 'app/utils/colors.dart';

void main() async {
  initServices();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    title: "Weather Forecast",
    initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
    theme: appTheme,
    builder: EasyLoading.init(),
    debugShowCheckedModeBanner: false,
  ));
  Future.delayed(const Duration(milliseconds: 1000), () async {
    configLoading();
  });
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = primary
    ..backgroundColor = white
    ..indicatorColor = white
    ..textColor = white
    ..maskColor = tertiary
    ..userInteractions = true
    ..dismissOnTap = true;
  // ..customAnimation = CustomAnimation();
}

void initServices() async {
  log('starting services');
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => ApiService().init());
  log('All services started');
}
