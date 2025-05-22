// ignore_for_file: file_names, avoid_print

import 'package:dineout/Getx_Controller/Controller.dart';
import 'package:dineout/api/Api_werper.dart';
import 'package:dineout/api/Data_save.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:dineout/api/gallery_model.dart';
import 'package:dineout/models/restaurant_short_detail_model.dart';
import 'package:get/get.dart';

import '../HomeScreen/HomePage.dart';

class NearybyController extends GetxController {
  List cuisinerestlist = [];
  List cuisinewise = [];
  List notificationdata = [];

  List<RestaurantShortDetailModel> nearByRestaurantList = [];
  addToNearByRestaurantList(list) {
    nearByRestaurantList.addAll(list);
    update();
  }

  Gallerydata? gallerydatas;
  bool isLoading = false;
  int currentindex = 0;

  changeindex(int index) {
    currentindex = index;
    update();
  }

  nearbyrest() {
    HomeController homeController = Get.find<HomeController>();
    var data = {
      "uid": getData.read("UserLogin")["id"],
      "lats": homeController.lat.toString(),
      "longs": homeController.long.toString()
    };
    ApiWrapper.dataPost(AppUrl.nearbyrest, data).then((val) {
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          nearByRestaurantList.clear();
          cuisinerestlist = val["cuisinerestlist"];
          List<RestaurantShortDetailModel> list = [];
          for (var i = 0; i < val["cuisinerestlist"].length; i++) {
            RestaurantShortDetailModel data =
                RestaurantShortDetailModel.fromJson(val["cuisinerestlist"][i]);
            list.add(data);
          }
          addToNearByRestaurantList(list);
          isLoading = true;

          print(
              "near by rest list count is ::::::::::::${nearByRestaurantList.length}");
          update();
          // save("currency", "currency");
        } else {
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
        update();
      }
    });
  }

  cuisinewiserest({String? cuisineid}) {
    HomeController homeController = Get.find<HomeController>();
    var data = {
      "uid": getData.read("UserLogin")["id"],
      "lats": homeController.lat.toString(),
      "longs": homeController.long.toString(),
      "cuisine_id": cuisineid
    };
    ApiWrapper.dataPost(AppUrl.cuisinewiserest, data).then((val) {
      print(")())()()()()()()())()()()()()()()" "$val");
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          cuisinewise = val["cuisinerestlist"];
          isLoading = true;
          update();
        } else {
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
        update();
      }
    });
  }

  notification({String? cuisineid}) {
    var data = {
      "uid": getData.read("UserLogin")["id"],
    };
    ApiWrapper.dataPost(AppUrl.notification, data).then((val) {
      print(")))))))))))))))))))))))))))" "$val");
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          notificationdata = val["NotificationData"];
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
