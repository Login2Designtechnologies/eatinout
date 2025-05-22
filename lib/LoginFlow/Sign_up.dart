// ignore_for_file: non_constant_identifier_names, avoid_print, file_names, prefer_const_constructors, unnecessary_string_interpolations, unused_element, must_be_immutable
// ignore: duplicate_ignore
// ignore_for_file: camel_case_types, use_key_in_widget_constructors, annotate_overrides, prefer_const_literals_to_create_immutables, file_names, unused_field, unused_element, avoid_unnecessary_containers, non_constant_identifier_names, unused_import, deprecated_member_use

import 'dart:convert';

import 'package:dineout/LoginFlow/Login_In.dart';
import 'package:dineout/LoginFlow/Verify_Account.dart';
import 'package:dineout/Utils/Bottom_bar.dart';
import 'package:dineout/Utils/Colors.dart';
import 'package:dineout/Utils/Custom_widegt.dart';
import 'package:dineout/api/Api_werper.dart';
import 'package:dineout/api/Data_save.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Getx_Controller/optcontroller.dart';
import '../Utils/dark_light_mode.dart';
import '../main.dart';
import 'Forgot_Password.dart';

class Singup extends StatefulWidget {
  static String verify = "";
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  final FullName = TextEditingController();
  final Email = TextEditingController();
  final Password = TextEditingController();
  final Countrycode = TextEditingController();
  final Mobile = TextEditingController();
  String mobilecheck = "";
  OtpController otpCont = Get.put(OtpController());
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    getDarkMode();
    super.initState();
  }

  String Country = "";
  String pagerought = "";
  final _formKey = GlobalKey<FormState>();
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
    return Scaffold(
      backgroundColor: notifier.background,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: SizedBox(
          height: Get.height * 0.12,
          child: Column(
            children: [
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: orangeColor,
                      ),
                    )
                  : AppButton(
                      buttonColor: orangeColor,
                      buttontext: "Continue".tr,
                      onTap: () async {
                        print("here");
                        if ((_formKey.currentState?.validate() ?? false)) {
                          Mobilecheck(Mobile.text, Country);
                        }
                      },
                    ),
              SizedBox(height: Get.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have account?".tr,
                    style: TextStyle(
                        fontFamily: "Gilroy Medium",
                        color: notifier.textColor,
                        fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const LoginPage());
                    },
                    child: Text(
                      " Log In".tr,
                      style: TextStyle(
                          fontFamily: "Gilroy Bold",
                          color: orangeColor,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      appBar: loginappbar(
          backGround: notifier.background, color: notifier.textColor),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.05),
                SizedBox(
                  width: Get.width * 0.70,
                  child: Text(
                    "Become a Eat In Out member".tr,
                    style: TextStyle(
                        fontFamily: "Gilroy Bold",
                        color: notifier.textColor,
                        fontSize: 22),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                IntlPhoneField(
                  keyboardType: TextInputType.number,
                  controller: Mobile,
                  cursorColor: const Color(0xff4361EE),
                  dropdownTextStyle:
                      TextStyle(color: notifier.textColor, fontSize: 16),
                  style: TextStyle(
                      fontFamily: "Gilroy Medium", color: notifier.textColor),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    fillColor: transparent,
                    counterText: "",
                    filled: true,
                    hintText: 'Enter your Phone'.tr,
                    hintStyle: const TextStyle(
                      fontFamily: 'Gilroy Medium',
                      // fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xffAAACAE),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xffF3F3FA)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: orangeColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.4),
                        ),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  initialCountryCode: 'IN',
                  invalidNumberMessage: 'please enter your phone number '.tr,
                  onChanged: (phone) {
                    Country = phone.countryCode;
                    print(phone.countryCode);
                  },
                ),
                SizedBox(height: 10),
                passwordtextfield(
                    controller: FullName,
                    color: notifier.textColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Full name'.tr;
                      }
                      return null;
                    },
                    lebaltext: "Full Name".tr,
                    suffixIcon: null,
                    obscureText: false),
                SizedBox(height: 10),
                passwordtextfield(
                    color: notifier.textColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email'.tr;
                      }
                      return null;
                    },
                    controller: Email,
                    lebaltext: "Email address".tr,
                    suffixIcon: null,
                    obscureText: false),
                SizedBox(height: 10),
                passwordtextfield(
                  color: notifier.textColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Password'.tr;
                    }
                    return null;
                  },
                  lebaltext: "Password".tr,
                  controller: Password,
                  obscureText: _obscureText,
                  suffixIcon: InkWell(
                      onTap: () {
                        _toggle();
                      },
                      child: !_obscureText
                          ? Icon(
                              Icons.visibility,
                              color: orangeColor,
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: Colors.grey.withOpacity(0.5),
                            )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isLoading = false;
  loadingTrue() {
    setState(() {
      isLoading = true;
    });
  }

  loadingFalse() {
    setState(() {
      isLoading = false;
    });
  }

  Mobilecheck(String mobile, String country) async {
    print("object");
    loadingTrue();
    try {
      Map map = {"mobile": mobile, "ccode": country};
      Uri uri = Uri.parse(AppUrl.mobilecheck);
      var response = await http.post(uri, body: jsonEncode(map));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        mobilecheck = result["Result"];
        save("UserLogin", result["UserLogin"]);
        // ignore: unnecessary_brace_in_string_interps
        print("*********************${mobilecheck}");

        if (mobilecheck == "true") {
          print('setp =====================1');
          setState(() {
            otpCont.getMsgtype().then(
              (msgtype) {
                print('setp =======222222222222222');
                if (msgtype["otp_auth"] == "No") {
                  Register(FullName.text ?? "", Email.text ?? "", Mobile.text,
                      Country ?? "", Password.text ?? "");
                  initPlatformState();
                  // loadingFalse();
                } else {
                  if (msgtype["SMS_TYPE"] == "Msg91") {
                    otpCont.sendOtp(mobile: "$Country${Mobile.text}").then(
                      (value) {
                        print("OTP CODE > *****************> ${value["otp"]}");
                        print("OTP CODE > *****************> ${value["otp"]}");
                        print("OTP CODE > *****************> ${value["otp"]}");
                        print("OTP CODE > *****************> ${value["otp"]}");
                        print("OTP CODE > *****************> ${value["otp"]}");
                        print('vavlue is =================>>>>');
                        print(value);

                        Get.to(() => VerifyAccount(
                              ccode: Country,
                              number: Mobile.text,
                              Email: Email.text,
                              FullName: FullName.text,
                              Password: Password.text,
                              Signup: "Signup",
                              otpCode: value["otp"].toString(),
                            ));
                        loadingFalse();
                      },
                    );
                  } else if (msgtype["SMS_TYPE"] == "Twilio") {
                    otpCont.twilloOtp(mobile: "$Country${Mobile.text}").then(
                      (value) {
                        print("OTP CODE 1 > > ${value["otp"]}");
                        Get.to(() => VerifyAccount(
                              ccode: Country,
                              number: Mobile.text,
                              Email: Email.text,
                              FullName: FullName.text,
                              Password: Password.text,
                              Signup: "Signup",
                              otpCode: value["otp"].toString(),
                            ));

                        print('set loading false from no where');
                        loadingFalse();
                      },
                    );
                  }
                }
              },
            );
          });
        } else {
          print('set loading false from else');
          loadingFalse();
          ApiWrapper.showToastMessage(result["ResponseMsg"]);
        }
      }
      // update();
    } catch (e) {
      print('set loading false from catch');
      loadingFalse();
      print(e.toString());
      print('this was error');
    }
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
}
