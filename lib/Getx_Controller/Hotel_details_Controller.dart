// ignore_for_file: file_names

import 'package:dineout/Getx_Controller/Controller.dart';
import 'package:dineout/api/Api_werper.dart';
import 'package:dineout/api/Data_save.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:get/get.dart';

import '../HomeScreen/HomePage.dart';

class HoteldetailController extends GetxController {
  Map hoteldetails = {};
  List restdata = [];
  List storyview = [];
  bool isLoading = false;
  List relatedrest = [];
  hoteldetail({String? id}) async {
    HomeController homeController = Get.find<HomeController>();
    var data = {
      "rest_id": id,
      "lats": homeController.lat.toString(),
      "longs": homeController.long.toString(),
      "uid": getData.read("UserLogin")["id"]
    };
    await ApiWrapper.dataPost(AppUrl.restdetails, data).then((val) {
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          hoteldetails = val["restdata"];
          restdata = val["restdata"]["featurelist"];
          storyview = val["restdata"]["img"];
          relatedrest = val["related_rest"];

          isLoading = true;
          update();
          // save("currency", "currency");
        } else {
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
        update();
      }
    });
  }
}
