// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables, file_names

import 'dart:convert';

import 'package:dineout/Getx_Controller/Controller.dart';
import 'package:dineout/Utils/Custom_widegt.dart';
import 'package:dineout/api/Api_werper.dart';
import 'package:dineout/api/Data_save.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WalletController extends GetxController implements GetxService {
  HomeController hdata = Get.put(HomeController());

  // WalletInfo? walletInfo;
  bool isLoading = false;

  TextEditingController amount = TextEditingController();

  String results = "";
  String walletMsg = "";

  String rCode = "";
  String signupcredit = "";
  String refercredit = "";
  int tex = 0;
  List wallet = [];
  getWalletReportData() async {
    var data = {
      "uid": getData.read("UserLogin")["id"],
    };
    ApiWrapper.dataPost(AppUrl.walletreport, data).then((val) {
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          wallet = val["Walletitem"];
          isLoading = true;
          update();
          // save("currency", val["HomeData"]["currency"]);
        } else {
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
        update();
      }
    });
  }

  getWalletUpdateData() async {
    try {
      Map map = {
        "uid": getData.read("UserLogin")["id"].toString(),
        "wallet": amount.text,
      };
      Uri uri = Uri.parse(AppUrl.baseUrl + AppUrl.walleupdate);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        results = result["Result"];
        walletMsg = result["ResponseMsg"];
        if (results == "true") {
          getWalletReportData();
          hdata.homeDataApi();
          Get.back();
          showToastMessage(walletMsg);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getReferData() async {
    try {
      isLoading = false;
      update();
      Map map = {
        "uid": getData.read("UserLogin")["id"].toString(),
      };
      Uri uri = Uri.parse(AppUrl.baseUrl + AppUrl.referdata);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print(response.body.toString());
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        rCode = result["code"];
        signupcredit = result["signupcredit"];
        refercredit = result["refercredit"];
        tex = int.parse(result["tax"]);
        // Get.toNamed(Routes.referFriendScreen);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  addAmount({String? price}) {
    amount.text = price ?? "";
    update();
  }
}
