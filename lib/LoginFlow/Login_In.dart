// ignore_for_file: file_names, non_constant_identifier_names, avoid_print, unnecessary_brace_in_string_interps, deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:dineout/LoginFlow/Resend_Code1.dart';
import 'package:dineout/LoginFlow/Sign_up.dart';
import 'package:dineout/LoginFlow/Sign_upold.dart';
import 'package:dineout/Utils/Bottom_bar.dart';
import 'package:dineout/Utils/Colors.dart';
import 'package:dineout/Utils/Custom_widegt.dart';
import 'package:dineout/Utils/db.dart';
import 'package:dineout/Utils/printf.dart';
import 'package:dineout/api/Api_werper.dart';
import 'package:dineout/api/Data_save.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/dark_light_mode.dart';

bool verifyotp = false;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Email = TextEditingController();
  final password = TextEditingController(text: kDebugMode ? "12345678" : "");
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool loading = false;
  setLoadingTrue() {
    setState(() {
      loading = true;
    });
  }

  setLoadingFalse() {
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getDarkMode();
    super.initState();
  }

  String loginpage = "";
  String Country = "";
  bool isChecked = false;

  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final Mobile = TextEditingController(text: kDebugMode ? "6367622773" : "");

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
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        backgroundColor: notifier.background,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: SizedBox(
            height: Get.height * 0.12,
            child: Column(
              children: [
                loading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: orangeColor,
                        ),
                      )
                    : AppButton(
                        buttonColor: orangeColor,
                        buttontext: "Sign In".tr,
                        onTap: () async {
                          if ((_formKey.currentState?.validate() ?? false)) {
                            setLoadingTrue();
                            initPlatformState();
                            await login(Mobile.text, Country, password.text);
                            setLoadingFalse();
                          }
                          // Get.to(() => const HomePage());
                        },
                      ),
                SizedBox(height: Get.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?".tr,
                      style: TextStyle(fontFamily: "Gilroy Medium", color: notifier.textColor, fontSize: 16),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const Singup());
                      },
                      child: Text(
                        " Sign Up".tr,
                        style: TextStyle(fontFamily: "Gilroy Bold", color: orangeColor, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
            backgroundColor: notifier.background,
            elevation: 0,
            leading: Transform.translate(
                offset: const Offset(-4, 0),
                child: Padding(
                  padding: const EdgeInsets.all(19),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          exit(0);
                        });
                      },
                      child: Image.asset("assets/leftarrow.png", color: notifier.textColor)),
                ))),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.05),
                Text(
                  "Welcome back".tr,
                  style: TextStyle(fontFamily: "Gilroy Bold", color: notifier.textColor, fontSize: 22),
                ),
                SizedBox(height: Get.height * 0.03),
                IntlPhoneField(
                  keyboardType: TextInputType.number,
                  controller: Mobile,
                  dropdownTextStyle: TextStyle(color: notifier.textColor, fontSize: 16),
                  style: TextStyle(fontFamily: "Gilroy Medium", color: notifier.textColor),
                  cursorColor: const Color(0xff4361EE),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    iconColor: notifier.textColor,
                    fillColor: transparent,
                    filled: true,
                    counterText: "",
                    hintText: 'Enter your Phone'.tr,
                    hintStyle: const TextStyle(
                      fontFamily: 'Gilroy Medium',
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
                    printf("(9)" * 90);
                    printf(phone);
                    Country = phone.countryCode;
                    print(phone.countryCode);
                  },
                ),
                const SizedBox(height: 10),
                passwordtextfield(
                  lebaltext: "Password",
                  color: notifier.textColor,
                  controller: password,
                  obscureText: _obscureText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Password';
                    }
                    return null;
                  },
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
                SizedBox(height: Get.height * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => const ResendCode());
                      },
                      child: Text(
                        "Forgot Password?".tr,
                        style: TextStyle(fontFamily: "Gilroy Medium", color: notifier.textColor, fontSize: 16),
                      ),
                    ),
                    Row(
                      children: [
                        Transform.translate(
                          offset: const Offset(8, 0),
                          child: Theme(
                            data: ThemeData(unselectedWidgetColor: greycolor),
                            child: Checkbox(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                              value: isChecked,
                              activeColor: notifier.textColor,
                              checkColor: notifier.background,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                  save("Remember", value);
                                });
                              },
                            ),
                          ),
                        ),
                        Text(
                          "Remember Me".tr,
                          style: TextStyle(fontSize: 14, fontFamily: "Gilroy Medium", color: notifier.textColor),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login(String email, String country, String password) async {
    try {
      Map map = {"mobile": email, "password": password, "ccode": Country};

      Uri uri = Uri.parse(AppUrl.login);
      var response = await http.post(uri, body: jsonEncode(map));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        loginpage = result["Result"];
        save("Firstuser", true);
        setState(() {
          save("UserLogin", result["UserLogin"]);
        });
        print("*********************${loginpage}");

        if (loginpage == "true") {
          savePhoneNumber(email);
          saveUserPass(password);
          saveCountryCode(Country);
          Get.to(() => BottomBar());
          // OneSignal.shared.sendTag("user_id", getData.read("UserLogin")["id"]);
          OneSignal.User.addTagWithKey("user_id", getData.read("UserLogin")["id"]);
          ApiWrapper.showToastMessage(result["ResponseMsg"]);
        } else {
          ApiWrapper.showToastMessage(result["ResponseMsg"]);
        }
      }
      // update();
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<void> initPlatformState() async {
  //   OneSignal.shared.setAppId(AppUrl.oneSignel);
  //   OneSignal.shared
  //       .promptUserForPushNotificationPermission()
  //       .then((accepted) {});
  //   OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
  //     print("Accepted OSPermissionStateChanges : $changes");
  //   });
  //   // print("--------------__uID : ${getData.read("UserLogin")["id"]}");

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
