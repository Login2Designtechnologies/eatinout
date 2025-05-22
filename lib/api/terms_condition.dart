// ignore_for_file: avoid_print, unused_local_variable, prefer_typing_uninitialized_variables, must_be_immutable, unused_import, depend_on_referenced_packages

import 'package:dineout/Utils/Colors.dart';
import 'package:dineout/api/Api_werper.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/dark_light_mode.dart';

List<DynamicPageData> dynamicPageDataList = [];

class Loream extends StatefulWidget {
  String? title;
  // ignore: use_super_parameters
  Loream(this.title, {Key? key}) : super(key: key);
  @override
  State<Loream> createState() => _LoreamState();
}

class _LoreamState extends State<Loream> {
  String? text;

  @override
  void initState() {
    getDarkMode();
    super.initState();
    getWebData();
  }
  late ColorNotifier notifier;
  getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previousState = prefs.getBool("setIsDark");
    if (previousState == null) {
      notifier.setIsDark = false;
    } else {
      notifier.setIsDark = previousState;
    }
  }

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: boxcolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: notifier.background,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back, color: notifier.textColor)),
        title: Text(
          widget.title!,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              fontFamily: 'Gilroy Medium',
              color: notifier.textColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Get.height / 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
              child: (text != null && text!.isNotEmpty)
                  ? HtmlWidget(
                  text ?? "",
                      textStyle: TextStyle(
                          color: notifier.textColor,
                          fontSize: Get.height / 50,
                          fontFamily: 'Gilroy Normal'))
                  : Text("",
                      style: TextStyle(
                          color: notifier.textColor,
                          fontSize: Get.height / 50,
                          fontFamily: 'Gilroy Normal')),
            ),
          ],
        ),
      ),
    );
  }

  void getWebData() {
    Map<String, dynamic> data = {};

    dynamicPageDataList.clear();
    ApiWrapper.dataPost(AppUrl.pagelist, data).then((value) {
      if ((value != null) &&
          (value.isNotEmpty) &&
          (value['ResponseCode'] == "200")) {
        List da = value['pagelist'];
        for (int i = 0; i < da.length; i++) {
          Map<String, dynamic> mapData = da[i];
          DynamicPageData a = DynamicPageData.fromJson(mapData);
          dynamicPageDataList.add(a);
        }

        for (int i = 0; i < dynamicPageDataList.length; i++) {
          if ((widget.title == dynamicPageDataList[i].title)) {
            text = dynamicPageDataList[i].description;
            setState(() {});
            return;
          } else {
            text = "";
          }
        }
      }
    });
  }
}

class DynamicPageData {
  DynamicPageData(this.title, this.description);

  String? title;
  String? description;

  DynamicPageData.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    description = json["description"];
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "description": description};
  }
}
