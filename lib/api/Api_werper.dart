// ignore_for_file: file_names, duplicate_ignore, avoid_print, dead_code
// ignore_for_file: file_names
import 'dart:convert';
import 'dart:developer';

import 'package:dineout/Utils/Colors.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

//! Api Call
class ApiWrapper {
  static var headers = {
    'Content-Type': 'application/json',
    'Cookie': 'PHPSESSID=oonu3ro0agbeiik4t0l6egt8ab'
  };
  static doImageUpload(
      String endpoint, Map<String, String> params, List imgs) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(AppUrl.baseUrl + endpoint));
    request.fields.addAll(params);
    for (int i = 0; i < imgs.length; i++) {
      log(imgs[i].toString(), name: "Image name $i");
      request.files.add(await http.MultipartFile.fromPath('image$i', imgs[i]));
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var model = await response.stream.bytesToString();
    return jsonDecode(model);
  }

  static showToastMessage(message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: gradientColor.withOpacity(0.9),
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static dataPost(appUrl, method) async {
    try {
      var url = Uri.parse(AppUrl.baseUrl + appUrl);
      print(url);
      print(method);

      var request =
          await http.post(url, headers: headers, body: jsonEncode(method));
      var response = jsonDecode(request.body);
      print("response----- $response");
      if (request.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      return e;
      print("Exeption----- $e");
    }
  }

  static dataGet(appUrl) async {
    try {
      var url = Uri.parse(AppUrl.baseUrl + appUrl);
      var request = await http.get(url, headers: headers);
      var response = jsonDecode(request.body);
      if (request.statusCode == 200) {
        return response;
      } else {
        print(request.reasonPhrase);
      }
    } catch (e) {
      return e;
      print("Exeption----- $e");
    }
  }

  // static dataGetLocation(appUrl) async {
  //   try {
  //     var request = await http.get(appUrl, headers: headers);
  //     var response = jsonDecode(request.body);
  //     if (request.statusCode == 200) {
  //       return response;
  //     } else {
  //       print(request.reasonPhrase);
  //     }
  //   } catch (e) {
  //     print("Exeption----- $e");
  //   }
  // }
}
