// ignore_for_file: file_names, prefer_const_constructors, deprecated_member_use

import 'package:dineout/Getx_Controller/Controller.dart';
import 'package:dineout/Getx_Controller/bottom_bar_controller.dart';

// import 'package:dineout/Getx_Controller/Near_By_controller.dart';
import 'package:dineout/HomeScreen/Hotel_Details.dart';
import 'package:dineout/HomeScreen/widgets/restaurant_card.dart';
import 'package:dineout/HomeScreen/widgets/restaurant_card_one.dart';
import 'package:dineout/Utils/Bottom_bar.dart';
import 'package:dineout/Utils/Colors.dart';
import 'package:dineout/Utils/String.dart';
import 'package:dineout/Utils/image.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/Custom_widegt.dart';
import '../Utils/dark_light_mode.dart';

// bool selectedbox = false;

class DealsHotalList extends StatefulWidget {
  final String pageTitle;
  final String id;

  const DealsHotalList({super.key, this.pageTitle = "Deals", this.id = ""});

  // {super.key, this.pageTitle = "Popular Restaurant around you"});

  @override
  State<DealsHotalList> createState() => _DealsHotalListState();
}

class _DealsHotalListState extends State<DealsHotalList> {
  HomeController homeController = Get.put(HomeController());
  BottomBarController bottomBarController = Get.put(BottomBarController());

  @override
  void initState() {
    getDarkMode();
    super.initState();
    homeController.getDealsRest(id: widget.id);
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
      backgroundColor: notifier.background,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: notifier.background,
          // centerTitle: true,
          leading: Transform.translate(
            offset: const Offset(-2, 0),
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: InkWell(
                    onTap: () {
                      Get.to(() => BottomBar());
                    },
                    // child: selectedIndex == 1
                    child: bottomBarController.selectedIndex == 1
                        ? SizedBox()
                        : Image.asset("assets/arrowleft.png",
                        height: 20, color: notifier.textColor))),
          ),
          title: Text(
            widget.pageTitle.tr,
            style: TextStyle(
                fontFamily: "Gilroy Bold",
                fontSize: 16,
                color: notifier.textColor),
          )),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: GetBuilder<HomeController>(builder: (context) {
              return homeController.isLoading
                  ? homeController.dealsRestList.isNotEmpty
                  ? Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: homeController.dealsRestList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RestaurantCardOne(data: homeController.dealsRestList[index]);
                    },
                  )
                ],
              )
                  : Padding(
                padding: EdgeInsets.only(top: Get.height * 0.35),
                child: Center(
                  child: Text(
                    "We do not currently have any Deals.".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: greycolor, fontFamily: "Gilroy Bold", fontSize: 16),
                  ),
                ),
              )
                  : Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.4),
                    child: CircularProgressIndi(),
                  ));
            })),
      ),
    );
  }
}
