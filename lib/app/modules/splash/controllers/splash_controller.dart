import 'package:assignment/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  dynamic phoneNumber;
  getPhoneNumber() {
    GetStorage box = GetStorage();
    phoneNumber = box.read('phoneNumber');
  }

  checkCondition() {
    if (phoneNumber == null) {
      navigateToLogin();
    } else {
      navigateToHome();
    }
  }

  navigateToLogin() {
    Get.offAllNamed(Routes.LOGIN);
  }

  navigateToHome() {
    Get.offAllNamed(Routes.HOME);
  }

  @override
  void onInit() {
    super.onInit();
    getPhoneNumber();
    Future.delayed(const Duration(milliseconds: 3000), () {
      checkCondition();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
