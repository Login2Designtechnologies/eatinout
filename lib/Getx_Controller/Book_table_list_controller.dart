// ignore_for_file: file_names

import 'package:dineout/api/Api_werper.dart';
import 'package:dineout/api/Data_save.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:get/get.dart';

class TablelistsController extends GetxController {
  bool isLoading = false;
  Map tableList = {};
  booktableList({String? tableid}) {
    var data = {"uid": getData.read("UserLogin")["id"], "tableid": tableid};
    ApiWrapper.dataPost(AppUrl.booktable, data).then((val) {
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          tableList = val["TableList"];
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
