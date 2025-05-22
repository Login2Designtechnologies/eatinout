// ignore_for_file: file_names

import 'package:dineout/Getx_Controller/Controller.dart';
import 'package:dineout/api/Api_werper.dart';
import 'package:dineout/api/Data_save.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:get/get.dart';

class PlanpurchaseController extends GetxController {
  HomeController homeController = Get.put(HomeController());
  bool isLoading = false;
  planpurchase({String? planid, transactionid, pname}) {
    var data = {
      "uid": getData.read("UserLogin")["id"],
      "plan_id": planid,
      "transaction_id": transactionid,
      "pname": pname,
    };
    ApiWrapper.dataPost(AppUrl.planpurchase, data).then((val) {
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          isLoading = true;
          homeController.homeDataApi();
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
          update();
        } else {
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
        update();
      }
    });
  }
}
