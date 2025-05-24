import 'package:dineout/Getx_Controller/Controller.dart';
import 'package:dineout/HomeScreen/Hotel_Details.dart';
import 'package:dineout/Utils/Colors.dart';
import 'package:dineout/Utils/String.dart';
import 'package:dineout/Utils/dark_light_mode.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:dineout/widgets/nodata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TredingRestaurantList extends StatefulWidget {
  const TredingRestaurantList({Key? key}) : super(key: key);

  @override
  _TredingRestaurantListState createState() => _TredingRestaurantListState();
}

class _TredingRestaurantListState extends State<TredingRestaurantList> {
  int currentindex = 0;
  late ColorNotifier notifier;

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          provider.trending.tr,
          style: TextStyle(fontFamily: "Gilroy Bold", color: notifier.textColor, fontSize: 16),
        ),
        SizedBox(height: Get.height * 0.03),
        GetBuilder<HomeController>(builder: (hData) {
          return hData.latestrest.length > 0
              ? SizedBox(
                  height: hData.latestrest.length > 0 ? Get.height * 0.64 : null,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: hData.latestrest.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            currentindex = index;
                          });
                          Get.to(() => HotelDetails(detailId: hData.latestrest[index]["id"]));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: Get.height * 0.75,
                          width: Get.width * 0.78,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                height: Get.height * 0.5,
                                width: Get.width * 0.72,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Stack(children: [
                                    FadeInImage.assetNetwork(
                                      fadeInCurve: Curves.easeInCirc,
                                      placeholder: "assets/ezgif.com-crop.gif",
                                      height: Get.height * 0.70,
                                      width: Get.width * 0.8,
                                      placeholderCacheHeight: 320,
                                      placeholderCacheWidth: 240,
                                      placeholderFit: BoxFit.fill,
                                      // placeholderScale: 1.0,
                                      image: AppUrl.imageurl + hData.latestrest[index]["img"],
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                        top: -10,
                                        right: 40,
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          height: Get.height * 0.12,
                                          width: Get.width * 0.48,
                                          color: darkpurple.withOpacity(0.5),
                                          child: Container(
                                            height: Get.height * 0.08,
                                            width: Get.width * 0.34,
                                            decoration: BoxDecoration(border: Border.all(color: notifier.textColor)),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                GetBuilder<HomeController>(builder: (context) {
                                                  String currentdiscount = "";
                                                  DateTime date = DateTime.now();
                                                  String dateFormat = DateFormat('EEEE').format(date);
                                                  if (dateFormat == "Friday" || dateFormat == "Saturday" || dateFormat == "Sunday") {
                                                    currentdiscount = hData.latestrest[index]["frisun"];
                                                  } else {
                                                    currentdiscount = hData.latestrest[index]["monthru"];
                                                  }

                                                  return Text(
                                                    "${currentdiscount}% OFF",
                                                    style: TextStyle(fontFamily: "Gilroy Bold", color: notifier.textColor, fontSize: 20),
                                                  );
                                                }),
                                                SizedBox(height: Get.height * 0.01),
                                                Text(
                                                  "Today's Discount".tr.toUpperCase(),
                                                  style: TextStyle(fontFamily: "Gilroy Medium", color: notifier.textColor, fontSize: 12),
                                                )
                                              ],
                                            ),
                                          ),
                                        )),
                                  ]),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.02),
                              Text(
                                hData.latestrest[index]["title"],
                                style: TextStyle(color: notifier.textColor, fontFamily: "Gilroy Bold", fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star_rate_rounded, color: yelloColor, size: 22),
                                  Text(
                                    hData.latestrest[index]["rate"],
                                    style: TextStyle(color: greycolor, fontFamily: "Gilroy Bold", fontSize: 16),
                                  ),
                                  SizedBox(width: Get.width * 0.01),
                                  CircleAvatar(radius: 2, backgroundColor: greycolor),
                                  SizedBox(width: Get.width * 0.02),
                                  Text(
                                    hData.latestrest[index]["landmark"],
                                    style: TextStyle(color: greycolor, fontFamily: "Gilroy Bold", fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: Get.width * 0.45,
                                child: Text(
                                  hData.latestrest[index]["sdesc"],
                                  style: TextStyle(
                                    color: greycolor,
                                    fontFamily: "Gilroy Medium",
                                    fontSize: 14,
                                  ),
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Column(
                  children: [
                    Nodata(
                      text: "No trending restaurants found",
                    ),
                    SizedBox(
                      height: 16,
                    )
                  ],
                );
        }),
      ],
    );
  }
}
