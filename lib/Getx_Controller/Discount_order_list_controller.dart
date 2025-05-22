// ignore_for_file: file_names

import 'package:dineout/api/Api_werper.dart';
import 'package:dineout/api/Data_save.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:get/get.dart';

class DiscountorderlistController extends GetxController {
  bool isLoading = false;
  List discountorder = [];

  discountorderlist() {
    var data = {"uid": getData.read("UserLogin")["id"]};
    ApiWrapper.dataPost(AppUrl.discountorderlist, data).then((val) {
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          discountorder = val["DiscountOrderList"];
          isLoading = true;
          update();
        } else {
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
        update();
      }
    });
  }
}
