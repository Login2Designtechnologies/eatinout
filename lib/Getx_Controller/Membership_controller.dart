// ignore_for_file: file_names, avoid_print

import 'package:dineout/Getx_Controller/Controller.dart';
import 'package:dineout/api/Api_werper.dart';
import 'package:dineout/api/Data_save.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:get/get.dart';

class MembershipController extends GetxController {
  HomeController homeController = Get.put(HomeController());
  bool isLoading = false;
  Map member = {};
  membership() {
    var data = {
      "uid": getData.read("UserLogin")["id"],
    };
    ApiWrapper.dataPost(AppUrl.membership, data).then((val) {
      print('val is ::::');
      print(val);
      print(val.runtimeType);
      print(val.runtimeType);
      print(val.runtimeType);
      print(val.runtimeType);
      print(val.runtimeType);
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&$val");
          member = val;
          isLoading = true;
          // ApiWrapper.showToastMessage(val["ResponseMsg"]);
          update();
        } else {
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
        update();
      }
    });
  }
}
