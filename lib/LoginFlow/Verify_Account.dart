// ignore_for_file: file_names, unused_catch_clause, non_constant_identifier_names, avoid_print, prefer_final_fields

import 'dart:convert';

import 'package:dineout/LoginFlow/Forgot_Password.dart';
import 'package:dineout/Utils/Bottom_bar.dart';
import 'package:dineout/Utils/Colors.dart';
import 'package:dineout/Utils/Custom_widegt.dart';
import 'package:dineout/api/Api_werper.dart';
import 'package:dineout/api/Data_save.dart';
import 'package:dineout/api/confrigation.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Getx_Controller/optcontroller.dart';
import '../Utils/dark_light_mode.dart';

// ignore: must_be_immutable
class VerifyAccount extends StatefulWidget {
  String? ccode;
  String? number;
  String? FullName;
  String? Email;
  String? Password;
  String? Signup;
  String? otpCode;

  VerifyAccount(
      {this.FullName,
      this.Email,
      this.Password,
      this.ccode,
      this.number,
      this.Signup,
      this.otpCode,
      super.key});

  @override
  State<VerifyAccount> createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  // final FirebaseAuth auth = FirebaseAuth.instance;
  final pinController = TextEditingController();
  OtpController otpController = Get.put(OtpController());
  String code = "";

  String pagerought = "";
  // ignore: unused_field
  String _verificationId = "";
  // ignore: unused_field
  int? _resendToken;
  String verrification = "";

  @override
  void initState() {
    getDarkMode();
    super.initState();
    setState(() {
      verrification = widget.Signup ?? "";
    });
  }

  late ColorNotifier notifier;

  getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previousState = prefs.getBool("setIsDark");
    if (previousState == null) {
      notifier.setIsDark = false;
    } else {
      notifier.setIsDark = previousState;
    }
  }

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    var padding = Container(
      // color: Colors.amber,
      // width: MediaQuery.of(context).size.width,
      child: Pinput(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        length: 4,
        controller: pinController,
        submittedPinTheme: PinTheme(
            width: 56,
            height: 56,
            textStyle: TextStyle(
                fontSize: 20,
                color: notifier.textColor,
                fontFamily: "Gilroy Bold"),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: orangeColor))),
        defaultPinTheme: PinTheme(
          width: 56,
          height: 56,
          textStyle: TextStyle(
              fontSize: 20,
              color: notifier.background,
              fontFamily: "Gilroy Bold"),
          decoration: BoxDecoration(
              color: notifier.containerColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: greycolor.withOpacity(0.2))),
        ),
        errorText: 'Wrong otp'.tr,
        onChanged: (value) {
          code = value;
        },
      ),
    );
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: AppButton(
          buttonColor: orangeColor,
          buttontext: "Verify Account".tr,
          onTap: () async {
            print(code);
            if (code.isEmpty || code.length < 3) {
              ApiWrapper.showToastMessage("Please Enter Valid OTP");
            } else {
              print(code);
              print(widget.number);
              print(widget.ccode);
              print("${widget.ccode}${widget.number}");
              // return;
              print('can check otp');
              var res = await otpController.verifyOTP(
                  mobile: "${widget.ccode}${widget.number}", otp: code);
              print(res);
              if (res['Result'] == "true") {
                await Register(
                    widget.FullName ?? "",
                    widget.Email ?? "",
                    widget.number ?? "",
                    widget.ccode ?? "",
                    widget.Password ?? "");
                initPlatformState();
              } else {
                Get.to(() => ForgotPassword(
                      ccode: widget.ccode,
                      mobileNo: widget.number,
                    ));
              }
            }
            return;
            if (widget.otpCode == code) {
              var res =
                  otpController.verifyOTP(mobile: widget.number, otp: code);
              if (verrification == "Signup") {
                // make api call for check otp is correct

                // if success then registrer uesr

                Register(
                    widget.FullName ?? "",
                    widget.Email ?? "",
                    widget.number ?? "",
                    widget.ccode ?? "",
                    widget.Password ?? "");
                initPlatformState();
              } else {
                Get.to(() => ForgotPassword(
                      ccode: widget.ccode,
                      mobileNo: widget.number,
                    ));
              }
            } else {
              ApiWrapper.showToastMessage("Please Enter Valid OTP");
            }
          },
        ),
      ),
      appBar: loginappbar(
          backGround: notifier.background, color: notifier.textColor),
      backgroundColor: notifier.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.05),
            Text(
              "Verify Account".tr,
              style: TextStyle(
                  fontFamily: "Gilroy Bold",
                  color: notifier.textColor,
                  fontSize: 22),
            ),
            SizedBox(height: Get.height * 0.02),
            SizedBox(
              width: Get.width * 0.80,
              child: RichText(
                text: TextSpan(
                  text:
                      "Please, enter the verification code we send to your mobile"
                          .tr,
                  style: TextStyle(
                      fontFamily: "Gilroy Medium",
                      color: greycolor,
                      fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                        text: "  ${widget.ccode} ${widget.number}",
                        style: TextStyle(
                            fontFamily: "Gilroy Bold",
                            fontSize: 16,
                            color: notifier.textColor)),
                  ],
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            padding,
            SizedBox(height: Get.height * 0.02),
            InkWell(
              onTap: () {
                setState(() {});
                pinController.clear();
                print(widget.ccode);
                print(widget.ccode);
                print(widget.ccode);
                print(widget.ccode);

                otpController.resendOtp(
                    mobile: "${widget.ccode}${widget.number}");
                otpController.getMsgtype().then(
                  (msgtype) {
                    if (msgtype["SMS_TYPE"] == "Msg91") {
                      otpController.resendOtp(
                          mobile: "${widget.ccode}${widget.number}");
                    } else if (msgtype["SMS_TYPE"] == "Msg91") {
                      otpController.twilloOtp(
                          mobile: "$widget.ccode ${widget.number}");
                    }
                  },
                );
                // sendOTP(phone: widget.number ?? "", Countrycode: widget.ccode);

                print("########################${widget.number}");
                print("########################${widget.ccode}");
              },
              child: Text(
                "Resend code?".tr,
                style: TextStyle(
                    fontFamily: "Gilroy Bold",
                    color: notifier.textColor,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Register(String fullname, String email, String mobile, String Country,
      String password) async {
    try {
      Map map = {
        "name": fullname,
        "email": email,
        "mobile": mobile,
        "ccode": Country,
        "password": password
      };
      print("+++++++++++++++"
          "$fullname"
          "----------------"
          "$email"
          "**************"
          "$mobile"
          "+++++++++++++++"
          "$Country"
          "+++++++++++++++"
          "$password");
      Uri uri = Uri.parse(AppUrl.register);
      var response = await http.post(uri, body: jsonEncode(map));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print("************yagnik*********${result.toString()}");
        pagerought = result["Result"];
        save("UserLogin", result["UserLogin"]);

        if (pagerought == "true") {
          Get.to(() => BottomBar());
          // OneSignal.shared.sendTag("user_id", getData.read("UserLogin")["id"]);
          OneSignal.User.addTagWithKey(
              "user_id", getData.read("UserLogin")["id"]);
        } else {
          ApiWrapper.showToastMessage(result["ResponseMsg"]);
        }
      }
      // update();
    } catch (e) {
      print(e.toString());
    }
  }

  //
  // Future<bool> sendOTP({required String phone, Countrycode}) async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: Countrycode + phone,
  //     verificationCompleted: (PhoneAuthCredential credential) {},
  //     verificationFailed: (FirebaseAuthException e) {},
  //     codeSent: (String verificationId, int? resendToken) async {
  //       _verificationId = verificationId;
  //       _resendToken = resendToken;
  //     },
  //     timeout: const Duration(seconds: 60),
  //     forceResendingToken: _resendToken,
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       verificationId = _verificationId;
  //     },
  //   );
  //   debugPrint("_verificationId: $_verificationId");
  //   return true;
  // }

//   Future<void> initPlatformState() async {
//     OneSignal.shared.setAppId(AppUrl.oneSignel);
//     OneSignal.shared
//         .promptUserForPushNotificationPermission()
//         .then((accepted) {});
//     OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
//       print("Accepted OSPermissionStateChanges : $changes");
//     });
//     // print("--------------__uID : ${getData.read("UserLogin")["id"]}");
//     await OneSignal.shared.sendTag("user_id", getData.read("UserLogin")["id"]);
//   }
// }
  Future<void> initPlatformState() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize(AppUrl.oneSignel);
    OneSignal.Notifications.requestPermission(true).then(
      (value) {
        print("Signal value:- $value");
      },
    );
  }
}
