// ignore_for_file: file_names

import 'package:dineout/api/Api_werper.dart';
import 'package:dineout/api/Data_save.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:get/get.dart';

class DiscountorderController extends GetxController {
  bool isLoading = false;
  List relatedrest = [];
  discountnow(
      {String? discountvalue,
      tipamount,
      totelamount,
      discountamount,
      payedamount,
      restid,
      wallatamount,
      paymentid,
      tipcmt,
      transactionid}) {
    var data = {
      "discount_value": discountvalue,
      "tip_amt": tipcmt != "" ? tipamount : "0",
      "total_amt": totelamount,
      "discount_amt": discountamount,
      "payed_amt": payedamount,
      "rest_id": restid,
      "wall_amt": wallatamount,
      "uid": getData.read("UserLogin")["id"],
      "payment_id": paymentid,
      "transaction_id": transactionid
    };
    ApiWrapper.dataPost(AppUrl.discountnow, data).then((val) {
      // print("+_++++++++++++++datadatatatatatat+++++++++++++++++++++" +
      //     data.toString());
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          isLoading = true;
          update();
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
          // save("currency", "currency");
        } else {
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
        update();
      }
    });
  }
}
