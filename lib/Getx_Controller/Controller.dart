// ignore_for_file: file_names, non_constant_identifier_names, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:dineout/Getx_Controller/location_controller.dart';
import 'package:dineout/HomeScreen/HomePage.dart';
import 'package:dineout/Tabbar/Tab1.dart';
import 'package:dineout/Utils/printf.dart';
import 'package:dineout/api/Api_werper.dart';
import 'package:dineout/api/Data_save.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:dineout/models/deal_model.dart';
import 'package:dineout/models/deal_res_model.dart';
import 'package:dineout/models/delas_category_model.dart';
import 'package:dineout/models/menu_model.dart';
import 'package:dineout/models/offer_model.dart';
import 'package:dineout/models/restaurant_model.dart';
import 'package:dineout/models/restaurant_short_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

String? uID;

class HomeController extends GetxController {
  String _userAddress = '';
  String get userAddress => _userAddress;
  setUserAddress(add) {
    _userAddress = add;
    notifyChildrens();
  }

  Map homeDataList = {};

  List sliderimage = [];
  List CuisineList = [];
  List latestrest = [];
  List allrest = [];
  List viewmenu = [];
  List galleryimg = [];
  List FAQ = [];

  List PlanData = [];
  List cuisinerestlist = [];
  int currentIndex = 0;
  bool isLoading = false;
  List<RestaurantShortDetailModel> allRestaurantList = [];
  addToAllRestaurantList(list) {
    allRestaurantList.addAll(list);
    update();
  }

  chnageObjectIndex(int index) {
    currentIndex = 0;
    currentIndex = index;
    update();
  }

  // var lat;
  // var long;

  // LocationController locationController = Get.find<LocationController>();

  // bool isLoading = false;

  homeDataApi() {
    var data = {
      "uid": getData.read("UserLogin")["id"],
      "lats": lat.toString(),
      "longs": long.toString()
    };
    ApiWrapper.dataPost(AppUrl.Homedata, data).then((val) {
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          homeDataList = val["HomeData"];
          sliderimage = val["HomeData"]["Bannerlist"];
          CuisineList = val["HomeData"]["CuisineList"];
          latestrest = val["HomeData"]["latest_rest"];
          allrest = val["HomeData"]["all_rest"];

          List<RestaurantShortDetailModel> list = [];
          for (var i = 0; i < val["HomeData"]["all_rest"].length; i++) {
            RestaurantShortDetailModel data =
                RestaurantShortDetailModel.fromJson(
                    val["HomeData"]["all_rest"][i]);
            list.add(data);
          }
          addToAllRestaurantList(list);

          isLoading = true;
          update();
          // save("country", val["HomeData"]["currency"]);
        } else {
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
        update();
      }
    });
  }

  List<OfferModel> offersList = [];

  getOffers({String? id}) {
    var data = {
      // "rest_id": id,
    };
    ApiWrapper.dataPost(AppUrl.offerList, data).then((val) {
      print(" L LL L L  L" * 200);
      print(val.runtimeType);
      print(val);
      if (val != null) {
        if (val['ResponseCode'] == "200" && val['Result'] == "true") {
          print("o b j e c t" * 90);
          print(val.runtimeType);
          print(val);

          print('u u' * 90);
          print(val['offersdata']);

          for (var i = 0; i < val['offersdata'].length; i++) {
            OfferModel data = OfferModel.fromJson(val['offersdata'][i]);
            offersList.add((data));
          }
          print("0 9" * 90);
          print(offersList.length);
          // isLoading = true;
          update();
          // save("currency", "currency");
        } else {
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
        update();
      }
    });
  }

  List<DealModel> dealList = [];
  getDeals() {
    var data = {
      // "rest_id": id,
    };
    ApiWrapper.dataPost(AppUrl.dealsList, data).then((val) {
      print(" O O oooo O o OOOO" * 900);
      if (val != null && val.isNotEmpty) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          for (var i = 0; i < val['dealsdata'].length; i++) {
            DealModel data = DealModel.fromJson(val['dealsdata'][i]);
            dealList.add(data);
          }
          print("0 9 8 3" * 90);
          print(dealList.length);
          // isLoading = true;
          update();
          update();
          // save("currency", "currency");
        } else {
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
        update();
      }
    });
  }

  List<DealsCategoryModel> dealsCateList = [];
  getDealsCategory({String? id}) {
    dealsCateList.clear();
    var data = {
      // "rest_id": id,
    };
    ApiWrapper.dataPost(AppUrl.dealsCategoryList, data).then((val) {
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          for (var i = 0; i < val['dealsdata'].length; i++) {
            DealsCategoryModel data =
                DealsCategoryModel.fromJson(val['dealsdata'][i]);
            dealsCateList.add(data);
          }
          print(" sum su m bu m" * 90);
          print(dealsCateList.length);
          // isLoading = true;
          update();
          update();
          // save("currency", "currency");
        } else {
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
        update();
      }
    });
  }

  List<DealResModel> dealsRestList = [];

  getDealsRest({String? id}) {
    var data = {"category_id": id};
    ApiWrapper.dataPost(AppUrl.dealsRestList, data).then((val) {
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          dealsRestList.clear();
          for (var i = 0; i < val['dealsdata'].length; i++) {
            DealResModel data = DealResModel.fromJson(val['dealsdata'][i]);
            dealsRestList.add(data);
          }
          print(" o sa thi ya hum d iiiiii" * 90);
          print(dealsRestList.length);
          // isLoading = true;
          update();
          update();
          // save("currency", "currency");
        } else {
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
        update();
      }
    });
  }

  bool loading = false;

  List<MenuModel> menuModelList = [];
  viewmenulist({String? id}) async {
    loading = true;
    update();
    menuModelList.clear();
    var data = {
      "rest_id": id,
    };

    await ApiWrapper.dataPost(AppUrl.viewmenu, data).then((val) {
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          viewmenu = val["menudata"];
          for (var i = 0; i < val['menudata'].length; i++) {
            menuModelList.add(MenuModel.fromJson(val['menudata'][i]));
          }
          loading = false;
          print(
              'got =========================${menuModelList.length} menu data');
          update();
          // save("currency", "currency");
        } else {
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
        loading = false;
        update();
      }
    });
  }

  Faqdata() {
    var data = {
      "uid": getData.read("UserLogin")["id"],
    };
    ApiWrapper.dataPost(AppUrl.faq, data).then((val) {
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          FAQ = val["FaqData"];
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

  Tablebook(
      {String? restid,
      bookfor,
      booktime,
      bookdate,
      numpeople,
      fullname,
      Emailaddress,
      Mobile}) {
    var data = {
      "name": checkvalue ? fullname : getData.read("UserLogin")["name"],
      "email": checkvalue ? Emailaddress : getData.read("UserLogin")["email"],
      "mobile": checkvalue ? Mobile : getData.read("UserLogin")["mobile"],
      "ccode": getData.read("UserLogin")["ccode"],
      "rest_id": restid,
      "uid": getData.read("UserLogin")["id"],
      "book_for": bookfor,
      "book_time": booktime,
      "book_date": bookdate,
      "noofpeople": numpeople,
    };
    print("&&&&&&&&&&&&&&&&&&&&&&&&&" "$data");
    ApiWrapper.dataPost(AppUrl.tablebooking, data).then((val) {
      print("00000000000000 Tablebook ---------------" + val.toString());
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          // tablebooking = val["FaqData"];
          isLoading = true;
          update();
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
          update();
        } else {
          update();
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
        update();
      }
    });
  }

  selectplan() {
    var data = {
      "uid": getData.read("UserLogin")["id"],
    };
    ApiWrapper.dataPost(AppUrl.selectplan, data).then((val) {
      print("/*/*/*/*/plandata*/*/*/*" "$val");
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          PlanData = val["PlanData"];
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

  var first; // First-time location flag
  var address;
  var lat;
  var long;
  var isLocationSet = false.obs; // Flag to check if location is manually set
  // HomeController hData = Get.find<HomeController>();
  bool userLocated = false;

  @override
  void onInit() {
    super.onInit();
    // Call getUserLocation when the controller is initialized
    // getUserLocation();
  }

  // Function to get current user location (only for the first time)
  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // Function to get user's location only the first time
  Future getUserLocation() async {
    if (userLocated) {
      printf('we already have user device first coordinates');
      return;
    }

    // Request permission
    LocationPermission permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle denied permission
      return;
    }

    // Get current location using Geolocator
    var currentLocation = await locateUser();
    debugPrint('Location: ${currentLocation.latitude}');
    debugPrint('Location: ${currentLocation.longitude}');
    debugPrint('Location: ${currentLocation.latitude}');
    debugPrint('Location: ${currentLocation.latitude}');
    lat = currentLocation.latitude;
    long = currentLocation.longitude;

    // Fetch the address from coordinates
    List<Placemark> addresses = await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);
    await placemarkFromCoordinates(
            currentLocation.latitude, currentLocation.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      address =
          '${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      setUserAddress(address);
    }).catchError((e) {
      debugPrint(e);
    });

    // Mark that location is set
    isLocationSet.value = true; // Location is set after the first fetch
    userLocated = true;

    // Set the first address (used for debugging or other purposes)
    first = addresses.first.name;
    print("FIRST ${address}");

    // Fetch additional data
    homeDataApi();
    selectplan();
    getOffers();
    getDeals();
    getDealsCategory();
  }

  // Function to handle location update when the user manually changes it
  Future updateUserLocation(double newLat, double newLong) async {
    // Update the latitude and longitude manually
    lat = newLat;
    long = newLong;

    // Get the new address based on the new location
    List<Placemark> addresses = await placemarkFromCoordinates(newLat, newLong);
    await placemarkFromCoordinates(newLat, newLong)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      address =
          '${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      setUserAddress(address);
    }).catchError((e) {
      debugPrint(e);
    });

    // Fetch data again after the user manually updates location
    homeDataApi();
    selectplan();
    getOffers();
    getDeals();
    getDealsCategory();
  }

  fetchAllData() {
    homeDataApi();
    selectplan();
    getOffers();
    getDeals();
    getDealsCategory();
  }
}
