import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ApiService extends GetxService {
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
      connectionStatus = result;
    } on PlatformException catch (e) {
      log(e.toString());
      return;
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    // setState(() {
    connectionStatus = result;
  }

  Future<ApiService> init() async {
    initConnectivity();
    if (GetPlatform.isAndroid) {
      _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    } else if (GetPlatform.isIOS) {
      const duration = Duration(seconds: 20);
      Timer.periodic(duration, (timer) {
        initConnectivity();
      });
    }
    return this;
  }
}
