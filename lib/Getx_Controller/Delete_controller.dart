// ignore_for_file: avoid_print, file_names

import 'dart:convert';

import 'package:dineout/api/Data_save.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../LoginFlow/Login_In.dart';

class DeleteAccountController extends GetxController {
  bool isLoading = false;
  List delete = [];

  deleteAccount() async {
    var headers = {
      'content': 'application/json',
      'Content-Type': 'application/json',
      'Cookie': 'PHPSESSID=nv9e1qa7929ns6dujpokn53m0o'
    };
    var request = http.Request(
        'POST', Uri.parse('https://admin.eatinout.in/api/account_delete.php'));
    request.body = json.encode({
      "user_id": getData.read("UserLogin")["id"],
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print("one2");
      getData.remove('Firstuser');
      getData.remove('Remember');
      getData.remove("UserLogin");
      print("one3");

      update();
      print("one4");
      Get.offAll(() => const LoginPage());
    } else {
      print(response.reasonPhrase);
    }
  }

  // deleteaccount({String? cuisineid}) {
  //   var data = {
  //     "user_id": getData.read("UserLogin")["id"],
  //   };
  //   ApiWrapper.dataPost(AppUrl.accountDelete, data).then((val) {
  //     print("===============accountdelete====================" "");
  //     if ((val != null)) {
  //       print("one1");

  //       if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
  //         isLoading = true;
  //         print("one2");
  //         getData.remove('Firstuser');
  //         getData.remove('Remember');
  //         getData.remove("UserLogin");
  //         print("one3");

  //         update();
  //         print("one4");
  //         Get.to(() => const LoginPage());
  //       } else {
  //         print("one5");

  //         ApiWrapper.showToastMessage(val["ResponseMsg"]);
  //       }
  //       update();
  //     }
  //     print("one6");
  //   });
  // }
}
