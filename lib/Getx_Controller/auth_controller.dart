import 'dart:convert';

import 'package:dineout/IntroScreen/IntroScreen.dart';
import 'package:dineout/Utils/Bottom_bar.dart';
import 'package:dineout/Utils/db.dart';
import 'package:dineout/api/Api_werper.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:dineout/api/Data_save.dart';

class AuthController extends GetxController {
  String loginpage = "";
  login() async {
    String userPhoneNumber = await getPhoneNumber();
    String userPassword = await getUserPassword();
    String countryConde = await getCountryCode();
    try {
      Map map = {
        "mobile": userPhoneNumber,
        "password": userPassword,
        "ccode": countryConde
      };

      // return;
      Uri uri = Uri.parse(AppUrl.login);
      var response = await http.post(uri, body: jsonEncode(map));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        loginpage = result["Result"];
        // save("Firstuser", true);
        print("*********************${loginpage}");
        if (loginpage == "true") {
          // savePhoneNumber(email);
          // saveUserPass(password);
          Get.offAll(() => BottomBar());

          OneSignal.User.addTagWithKey(
              "user_id", getData.read("UserLogin")["id"]);
          ApiWrapper.showToastMessage(result["ResponseMsg"]);
        } else {
          print("we are here");
          ApiWrapper.showToastMessage(result["ResponseMsg"]);
          Get.offAll(BoardingPage(), transition: Transition.fadeIn);
        }
      }
      // update();
    } catch (e) {
      print(e.toString());
    }
  }

  loginAfterSignUp({
    required String userPhoneNumber,
    required String userPassword,
    required String countryConde,
  }) async {
    String userPhoneNumber = await getPhoneNumber();
    String userPassword = await getUserPassword();
    String countryConde = await getCountryCode();
    try {
      Map map = {
        "mobile": userPhoneNumber,
        "password": userPassword,
        "ccode": countryConde
      };

      // return;
      Uri uri = Uri.parse(AppUrl.login);
      var response = await http.post(uri, body: jsonEncode(map));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        loginpage = result["Result"];
        // save("Firstuser", true);
        print("*********************${loginpage}");
        if (loginpage == "true") {
          // savePhoneNumber(email);
          // saveUserPass(password);
          Get.offAll(() => BottomBar());

          OneSignal.User.addTagWithKey(
              "user_id", getData.read("UserLogin")["id"]);
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

  // logout() async {
  //   String userId = getData.read("UserLogin")["id"];
  //   try {
  //     Map map = {
  //       "user_id": userId,
  //     };
  //     print(userId);
  //     return;
  //     Uri uri = Uri.parse(AppUrl.accountDelete);
  //     var response = await http.post(uri, body: jsonEncode(map));
  //     if (response.statusCode == 200) {
  //       var result = jsonDecode(response.body);
  //       // loginpage = result["Result"];
  //       // save("Firstuser", true);
  //       print("*********************${loginpage}");
  //       if (loginpage == "true") {
  //         // savePhoneNumber(email);
  //         // saveUserPass(password);
  //         Get.offAll(() => BottomBar());

  //         OneSignal.User.addTagWithKey(
  //             "user_id", getData.read("UserLogin")["id"]);
  //         ApiWrapper.showToastMessage(result["ResponseMsg"]);
  //       } else {
  //         ApiWrapper.showToastMessage(result["ResponseMsg"]);
  //       }
  //     }
  //     // update();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
