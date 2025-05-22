import 'package:dineout/Getx_Controller/Controller.dart';
import 'package:dineout/HomeScreen/Cuisines.dart';
import 'package:dineout/Utils/Colors.dart';
import 'package:dineout/Utils/dark_light_mode.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ExploreCuisinesMenu extends StatefulWidget {
  const ExploreCuisinesMenu({Key? key}) : super(key: key);

  @override
  State<ExploreCuisinesMenu> createState() => _ExploreCuisinesMenuState();
}

class _ExploreCuisinesMenuState extends State<ExploreCuisinesMenu> {
  late ColorNotifier notifier;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return GetBuilder<HomeController>(builder: (hData) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Explore cuisines".tr,
            style: TextStyle(
                color: notifier.textColor,
                fontFamily: "Gilroy Bold",
                fontSize: 16),
          ),
          SizedBox(height: Get.height * 0.02),
          SizedBox(
            height: Get.height * 0.15,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: hData.CuisineList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => Cuisines(
                          title: hData.CuisineList[index]["title"],
                          hotelid: hData.CuisineList[index]["id"],
                        ));
                  },
                  child: Container(
                    width: Get.width * 0.25,
                    child: Column(
                      children: [
                        CircleAvatar(
                            backgroundImage: NetworkImage(AppUrl.imageurl +
                                hData.CuisineList[index]["img"]),
                            radius: 35,
                            backgroundColor: transparent),
                        SizedBox(height: Get.height * 0.01),
                        SizedBox(
                          width: Get.width * 0.23,
                          child: Center(
                            child: Text(
                              hData.CuisineList[index]["title"],
                              style: TextStyle(
                                  fontSize: 13,
                                  color: WhiteColor,
                                  fontFamily: "Gilroy Medium"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
