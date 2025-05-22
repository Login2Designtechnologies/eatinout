import 'package:dineout/HomeScreen/Hotel_Details.dart';
import 'package:dineout/Utils/Colors.dart';
import 'package:dineout/Utils/String.dart';
import 'package:dineout/Utils/dark_light_mode.dart';
import 'package:dineout/Utils/image.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:dineout/models/deal_res_model.dart';
import 'package:dineout/models/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RestaurantCardOne extends StatefulWidget {
  DealResModel data;
  RestaurantCardOne({Key? key, required this.data}) : super(key: key);

  @override
  State<RestaurantCardOne> createState() => _RestaurantCardOneState();
}

class _RestaurantCardOneState extends State<RestaurantCardOne> {
  late ColorNotifier notifier;

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return InkWell(
      onTap: () {
        // selectedbox = true;
        Get.to(() => HotelDetails(detailId: widget.data.restaurant));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: notifier.textColor),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(children: [
                  FadeInImage.assetNetwork(
                    fadeInCurve: Curves.easeInCirc,
                    placeholder: "assets/ezgif.com-crop.gif",
                    height: 160,
                    width: 130,
                    placeholderCacheHeight: 160,
                    placeholderCacheWidth: 130,
                    placeholderFit: BoxFit.fill,
                    // placeholderScale: 1.0,
                    image: AppUrl.imageurl + widget.data.dealImage.toString(),
                    fit: BoxFit.cover,
                  ),
                ]),
              ),
            ),
            SizedBox(width: Get.width * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data.dealTitle ?? '',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Gilroy Bold",
                      color: notifier.textColor),
                ),
                SizedBox(height: Get.height * 0.01),
                Row(
                  children: [
                    Image.asset(image.star, height: 20),
                    SizedBox(width: Get.width * 0.015),
                    Text(
                      widget.data.amount ?? '',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Gilroy Bold",
                          color: notifier.textColor),
                    ),
                    SizedBox(width: Get.width * 0.015),
                  ],
                ),
                SizedBox(height: Get.height * 0.01),
                // SizedBox(
                //   width: Get.width * 0.53,
                //   child: Text(
                //     widget.data.landmark ?? '',
                //     style: TextStyle(
                //         fontSize: 14,
                //         fontFamily: "Gilroy Medium",
                //         color: greycolor),
                //   ),
                // ),
                SizedBox(height: Get.height * 0.01),
                SizedBox(
                  width: Get.width * 0.53,
                  child: Text(
                    widget.data.description ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Gilroy Medium",
                        color: greycolor),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  // height: 40,
                  width: Get.width * 0.54,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(stops: const [
                        0.6,
                        0.8,
                        1
                      ], colors: [
                        Colors.transparent,
                        Colors.red.withOpacity(0.1),
                        Colors.red.withOpacity(0.1)
                      ]),
                      border: Border.all(color: lightgrey),
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Get.width * 0.32,
                            child: Builder(builder: (context) {
                              String currentdiscount = "";
                              DateTime date = DateTime.now();
                              String dateFormat =
                                  DateFormat('EEEE').format(date);
                              // if (dateFormat == "Friday" ||
                              //     dateFormat == "Saturday" ||
                              //     dateFormat == "Sunday") {
                              //   currentdiscount = widget.data.frisun ?? '';
                              // } else {
                              //   currentdiscount = widget.data.monthru ?? '';
                              // }
                              return Text(
                                "EXTRA ${widget.data.discount}% OFF",
                                style: TextStyle(
                                    fontFamily: "Gilroy Bold",
                                    color: orangeColor,
                                    fontSize: 14),
                              );
                            }),
                          ),
                          SizedBox(
                            width: Get.width * 0.32,
                            child: Text(
                              provider.andfree.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 10,
                                  color: orangeColor,
                                  fontFamily: "Gilroy Medium"),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            provider.gold.toUpperCase(),
                            style: TextStyle(
                                fontSize: 13,
                                color: goldColor,
                                fontFamily: "Gilroy Bold"),
                          ),
                          Text(
                            provider.benefits.toUpperCase(),
                            style: TextStyle(
                                fontSize: 10,
                                color: orangeColor,
                                fontFamily: "Gilroy Medium"),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
