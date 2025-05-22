// ignore_for_file: avoid_print, file_names

import 'dart:developer';

import 'package:dineout/Utils/db.dart';
import 'package:dineout/api/Api_werper.dart';
import 'package:dineout/api/Data_save.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:dineout/models/payment_history_model.dart';
import 'package:get/get.dart';

class PaymentgatewayController extends GetxController {
  List paymentGetway = [];
  bool isLoading = false;
  paymentgateway() {
    ApiWrapper.dataGet(AppUrl.paymentgetway).then((val) {
      print("/*/*/*/*/paymentdata*/*/*/*" "$val");
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          paymentGetway = val["paymentdata"];
          log(val["paymentdata"].length.toString(), name: "payment deta :: ");

          isLoading = true;
          update();
        } else {
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
      }
    });
  }

  paymentgatewaySuccessEmail() {
    ApiWrapper.dataGet(AppUrl.paymentgetwaySuccessEmail).then((val) {
      print("/*/*/*/*/paymentdata*/*/*/*" "$val");
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          isLoading = true;
          update();
        } else {
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
      }
    });
  }

  RxList<PaymentHistoryModel> paymentHistoryList = <PaymentHistoryModel>[].obs;

  getPaymentHistory() {
    isLoading = true;
    String userId = getData.read("UserLogin")["id"];
    var data = {"customer_id": userId};
    ApiWrapper.dataPost(AppUrl.getPaymentHistory, data).then((val) {
      print("/*/*/*/*/paymentdata*/*/*/*" "$val");
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          isLoading = false;
          paymentHistoryList.clear();
          for (var i = 0; i < val['Data'].length; i++) {
            PaymentHistoryModel data =
                PaymentHistoryModel.fromJson(val['Data'][i]);
            paymentHistoryList.add(data);
          }
          update();
        } else {
          isLoading = false;
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
      }
    });
  }

  paymentHistory({
    required String discountamount,
    required String discountvalue,
    required String payedamount,
    required String paymentid,
    required String restid,
    required String tipamount,
    required String totelamount,
    required String transactionid,
    required String wallatamount,
    required String tipcmt,
  }) async {
    String name = getData.read("UserLogin")["name"] ?? "";
    String email = getData.read("UserLogin")["email"] ?? "";
    String userPhoneNumber = await getPhoneNumber();
    String userId = getData.read("UserLogin")["id"];
    var data = {
      "restaurant_id": restid,
      "restaurant_name": "NA",
      "city": "NA",
      "location": "NA",
      "transaction_id": transactionid,
      "gst": "NA",
      "commission": "NA",
      "offer_claimed_title": "NA",
      "transaction_status": "SUCCESS",
      "refund_status": "NA",
      "customer_name": name,
      "customer_email": email,
      "customer_number": userPhoneNumber,
      "customer_id": userId,
      "total_amount": totelamount,
      "tip_amount": tipamount,
      "discount_amount": discountamount,
      "payed_amount": payedamount,
      "discount": discountvalue,
      "wallet_amount": wallatamount,
      "payment_method": "NA",
    };
    // print(data);
    // return;
    ApiWrapper.dataPost(AppUrl.paymentHistory, data).then((val) {
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          print("data has been saved succeffully");
          // update();
        } else {
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
      }
    });
  }
}
