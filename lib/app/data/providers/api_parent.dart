import 'dart:convert' as convert;
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../../utils/ui.dart';
import 'api_service.dart';

class ApiParent extends GetConnect {
  Map<String, dynamic> jsonDecode(String source) {
    return convert.jsonDecode(source);
  }

  String jsonEncode(String source) {
    return convert.jsonEncode(source);
  }

  bool hasInternetConnection() {
    ApiService apiService = Get.put(ApiService());
    apiService.initConnectivity();
    if (apiService.connectionStatus == ConnectivityResult.none) {
      showNoInternetDialog();
      return false;
    }
    return true;
  }

  void showNoInternetDialog() {
    log("No internet");
    UI.showMessageSnackBar(
        'No Internet', 'Please check your internet connection');
  }
}
