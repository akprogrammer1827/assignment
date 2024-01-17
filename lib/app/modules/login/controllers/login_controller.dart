import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field/otp_field.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/ui.dart';

class LoginController extends GetxController with GetTickerProviderStateMixin {
  int page = 1;

  String countryCode = '+91';
  String? otpCode;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? strVerificationId;

  Future<void> phoneNumberVerification() async {
    phoneVerificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
      await firebaseAuth.signInWithCredential(phoneAuthCredential);
      UI.showLoading();
    }

    phoneVerificationFailed(FirebaseAuthException authException) {
      UI.showMessageSnackBar(
          'Alert',
          "Phone number verification is failed. Code: ${authException.code}."
              " Message: ${authException.message}");
    }

    phoneCodeSent(String verificationId, int? forceResendingToken) async {
      UI.hideLoading();
      startTimer();
      UI.showMessageSnackBar('Alert', 'OTP sent successfully');
      strVerificationId = verificationId;
      page = 3;
    }

    phoneCodeAutoRetrievalTimeout(String verificationId) {
      strVerificationId = verificationId;
    }

    try {
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: countryCode + phoneNumberController.text,
          timeout: const Duration(seconds: 120),
          verificationCompleted: phoneVerificationCompleted,
          verificationFailed: phoneVerificationFailed,
          codeSent: phoneCodeSent,
          codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
    } catch (e) {
      UI.showMessageSnackBar('Alert', "Failed to Verify Phone Number: $e");
    }
  }

  submitOTP(String code) async {
    if (code.length != 6) {
      UI.showMessageSnackBar('Invalid OTP', 'Enter valid OTP');
    }
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: strVerificationId!, smsCode: code))
          .then((value) async {
        if (value.user != null) {
          log("Value User ${value.user}");
          UI.showMessageSnackBar('Successful', 'Otp Verified Successfully');
          goToDashboard();
        }
      });
    } catch (e) {
      UI.showMessageSnackBar('Invalid OTP', 'Enter Valid OTP');
    }
  }

  TextEditingController phoneNumberController = TextEditingController();

  OtpFieldController otpFieldController = OtpFieldController();

  final key = GlobalKey();
  int levelClock = 120;
  AnimationController? animationController;
  String? timerText;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));
  }

  loginValidation() {
    if (phoneNumberController.text.isEmpty) {
      UI.showMessageSnackBar('Alert', "Phone Number can't be empty");
    } else if (phoneNumberController.text.length < 10) {
      UI.showMessageSnackBar('Alert', "Phone Number is not valid");
    } else {
      GetStorage box = GetStorage();
      box.write('phoneNumber', phoneNumberController.text);
      box.save();
      phoneNumberVerification();
    }
  }

  startTimer() {
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));
    animationController!.forward();
    log('animationController!.status ${animationController!.isCompleted}');
    update();
  }

  goToDashboard() {
    Get.offAllNamed(Routes.HOME);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController!.dispose();
    super.dispose();
  }
}
