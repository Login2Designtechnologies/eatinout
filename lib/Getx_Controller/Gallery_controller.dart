// ignore_for_file: file_names

import 'package:dineout/api/Api_werper.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:dineout/api/gallery_model.dart';
import 'package:get/get.dart';

class GalleryController extends GetxController {
  Gallerydata? gallerydatas;
  bool isLoading = false;
  int currentindex = 0;
  List<String> imagePaths = [];

  changeindex(int index) {
    currentindex = index;
    update();
  }

  galleryview({String? id}) {
    var data = {
      "rest_id": id,
    };
    ApiWrapper.dataPost(AppUrl.viewgallery, data).then((val) {
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          gallerydatas = Gallerydata.fromJson(val);
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
