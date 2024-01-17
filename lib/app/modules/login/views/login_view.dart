import 'dart:developer';

import 'package:assignment/app/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../../utils/colors.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return UI.exitAppDialog();
      },
      child: GetBuilder<LoginController>(builder: (_) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: controller.page == 1
              ? LoginIntroView()
              : controller.page == 2
                  ? NumberLoginView()
                  : OtpSubmitView(),
        );
      }),
    );
  }
}

class LoginIntroView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  LoginIntroView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [introWidget(), loginViewWidget()],
      ),
    );
  }

  Widget introWidget() {
    return Container(
      height: 435,
      color: onBoardingBackground,
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset(
              'assets/images/stemm_one_logo.jpg',
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Weather Forecast',
              style:
                  GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Widget loginViewWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 56.0, left: 16, right: 16),
      child: ListView(
        shrinkWrap: true,
        children: [
          TextField(
            readOnly: true,
            onTap: () {
              controller.page = 2;
              controller.update();
            },
            decoration: InputDecoration(
                labelText: 'Enter Phone Number',
                labelStyle: GoogleFonts.roboto(
                  color: Colors.black, //<-- SEE HERE
                ),
                hintText: 'Enter Phone Number',
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: textFieldBorder,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: textFieldBorder,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: buttonBackground,
                  ),

                  //  borderRadius: BorderRadius.circular(4),
                ),
                hintStyle: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400, color: black)),
          ),
          const SizedBox(
            height: 45,
          ),
          SizedBox(
            height: 40,
            width: 328,
            child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: buttonBackground),
                onPressed: () {
                  UI.showMessageSnackBar(
                      'Alert', 'Please enter Phone Number to Login');
                },
                child: Text(
                  'Login',
                  style: GoogleFonts.roboto(
                      color: white, fontSize: 14, fontWeight: FontWeight.w500),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'By continuing with Phone Number, you agree to the',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontSize: 12, fontWeight: FontWeight.w300, color: black),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        child: Text(
                      'Terms',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: buttonBackground),
                    )),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'and',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: black),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                        child: Text(
                      'Privacy Policy',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: buttonBackground),
                    )),
                    Text(
                      '.',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      controller.goToDashboard();
                    },
                    child: Text(
                      'SKIP LOGIN',
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          decoration: TextDecoration.underline,
                          color: buttonBackground),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class NumberLoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  NumberLoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.5,
        leading: InkWell(
            onTap: () {
              controller.page = 1;
              controller.update();
            },
            child: const Icon(
              Icons.arrow_back_sharp,
              color: black,
            )),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [loginViewWidget()],
      ),
    );
  }

  Widget loginViewWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 56.0, left: 16, right: 16),
      child: ListView(
        shrinkWrap: true,
        children: [
          TextField(
            autofocus: true,
            controller: controller.phoneNumberController,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            ],
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                labelText: 'Enter Phone Number',
                labelStyle: GoogleFonts.roboto(
                  color: Colors.black, //<-- SEE HERE
                ),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: buttonBackground)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: textFieldBorder)),
                hintStyle: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400, color: black)),
          ),
          const SizedBox(
            height: 45,
          ),
          SizedBox(
            height: 40,
            width: 328,
            child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: buttonBackground),
                onPressed: () {
                  controller.loginValidation();
                },
                child: Text(
                  'Login',
                  style: GoogleFonts.roboto(
                      color: white, fontSize: 14, fontWeight: FontWeight.w500),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'By continuing with Phone Number, you agree to the',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontSize: 12, fontWeight: FontWeight.w300, color: black),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        child: Text(
                      'Terms',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: buttonBackground),
                    )),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'and',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: black),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                        child: Text(
                      'Privacy Policy',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: buttonBackground),
                    )),
                    Text(
                      '.',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: black),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OtpSubmitView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  OtpSubmitView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.5,
        leading: InkWell(
            onTap: () {
              controller.page = 2;
              controller.update();
            },
            child: const Icon(
              Icons.arrow_back_sharp,
              color: black,
            )),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [otpView()],
      ),
    );
  }

  Widget otpView() {
    return Padding(
      padding: const EdgeInsets.only(top: 56.0, left: 16, right: 16),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            // "Enter the OTP sent to your registered phone number ${controller.phoneNumberController.text.replaceRange(0, 6, '******')}",
            "Enter the OTP sent to your registered phone number ${controller.phoneNumberController.text}",
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400, fontSize: 14, color: black),
          ),
          const SizedBox(
            height: 32,
          ),
          OTPTextField(
              controller: controller.otpFieldController,
              length: 6,
              textFieldAlignment: MainAxisAlignment.center,
              fieldWidth: 40,
              spaceBetween: 10,
              fieldStyle: FieldStyle.box,
              outlineBorderRadius: 4,
              otpFieldStyle: OtpFieldStyle(
                  borderColor: textFieldBorder,
                  focusBorderColor: buttonBackground,
                  enabledBorderColor: textFieldBorder),
              style: GoogleFonts.roboto(fontSize: 17),
              onChanged: (pin) {
                log("Changed: $pin");
                controller.otpCode = pin;
                controller.update();
              },
              onCompleted: (pin) {
                log("Completed: $pin");
                controller.otpCode = pin;
                controller.update();
              }),
          const SizedBox(
            height: 25,
          ),
          Countdown(
            key: controller.key,
            animation: StepTween(
              begin: controller.levelClock, // THIS IS A USER ENTERED NUMBER
              end: 0,
            ).animate(controller.animationController!),
          ),
          const SizedBox(
            height: 45,
          ),
          SizedBox(
            height: 40,
            width: 328,
            child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: buttonBackground),
                onPressed: () {
                  controller.submitOTP(controller.otpCode!);
                },
                child: Text(
                  'Submit',
                  style: GoogleFonts.roboto(
                      color: white, fontSize: 14, fontWeight: FontWeight.w500),
                )),
          ),
          const SizedBox(
            height: 25,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'By continuing with Phone Number, you agree to the',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontSize: 12, fontWeight: FontWeight.w300, color: black),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        child: Text(
                      'Terms',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: buttonBackground),
                    )),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'and',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: black),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                        child: Text(
                      'Privacy Policy',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: buttonBackground),
                    )),
                    Text(
                      '.',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: black),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Countdown extends AnimatedWidget {
  final LoginController controller = Get.put(LoginController());
  Countdown({required Key key, required this.animation})
      : super(key: key, listenable: animation);
  final Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    controller.timerText = clockTimer.inSeconds.remainder(120).toString();

    return Center(
      child: controller.timerText == "0"
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Did not receive an OTP?',
                  style: GoogleFonts.roboto(
                      fontSize: 14, fontWeight: FontWeight.w400, color: black),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    controller.phoneNumberVerification();
                  },
                  child: Text(
                    'Resend OTP',
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: buttonBackground),
                  ),
                )
              ],
            )
          : Text(
              "Resend OTP in ${controller.timerText} sec",
              style: GoogleFonts.roboto(
                  fontSize: 14, color: black, fontWeight: FontWeight.w400),
            ),
    );
  }
}
