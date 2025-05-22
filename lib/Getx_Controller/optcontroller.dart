import 'dart:convert';

import 'package:dineout/Utils/Custom_widegt.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OtpController extends GetxController implements GetxService {
  Future getMsgtype() async {
    var request = await http.get(
      Uri.parse(AppUrl.baseUrl + AppUrl.smstype),
    );

    if (request.statusCode == 200) {
      var response = jsonDecode(request.body);
      return response;
    } else {
      showToastMessage("Something went wrong!");
    }
  }

  Future sendOtp({required mobile}) async {
    Map body = {
      "mobile": mobile,
    };
    var request = await http.post(Uri.parse(AppUrl.baseUrl + AppUrl.msgotp),
        body: jsonEncode(body));
    if (request.statusCode == 200) {
      var response = jsonDecode(request.body);
      print(response);
      if (response["Result"] == "true") {
        return response;
      } else {
        showToastMessage(response["ResponseMsg"]);
      }
    } else {
      showToastMessage("Something went wrong!");
    }
  }

  Future resendOtp({required mobile}) async {
    print('resending otp');
    print('mobiel ========================+>>>');
    print(mobile);
    Map body = {
      "mobile": mobile,
    };
    var request = await http.post(Uri.parse(AppUrl.baseUrl + AppUrl.resendotp),
        body: jsonEncode(body));
    if (request.statusCode == 200) {
      var response = jsonDecode(request.body);
      print(response);
      if (response["Result"] == "true") {
        return response;
      } else {
        showToastMessage(response["ResponseMsg"]);
      }
    } else {
      showToastMessage("Something went wrong!");
    }
  }

  Future verifyOTP({required mobile, required String otp}) async {
    Map body = {
      "mobile": mobile,
      "otp": otp,
    };
    var request = await http.post(Uri.parse(AppUrl.baseUrl + AppUrl.verifyOtp),
        body: jsonEncode(body));
    if (request.statusCode == 200) {
      var response = jsonDecode(request.body);
      print(response);
      if (response["Result"] == "true") {
        return response;
      } else {
        showToastMessage(response["ResponseMsg"]);
      }
    } else {
      showToastMessage("Something went wrong!");
    }
  }

  Future twilloOtp({required mobile}) async {
    Map body = {
      "mobile": mobile,
    };
    var request = await http.post(Uri.parse(AppUrl.baseUrl + AppUrl.twillotp),
        body: jsonEncode(body));
    if (request.statusCode == 200) {
      var response = jsonDecode(request.body);
      if (response["Result"] == "true") {
        return response;
      } else {
        showToastMessage(response["ResponseMsg"]);
      }
    } else {
      showToastMessage("Something went wrong!");
    }
  }
}
