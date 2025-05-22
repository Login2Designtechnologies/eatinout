// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dineout/Getx_Controller/Controller.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dineout/Getx_Controller/Controller.dart';
import 'package:dineout/HomeScreen/Hotel_Details.dart';
import 'package:dineout/Utils/Colors.dart';
import 'package:dineout/Utils/Custom_widegt.dart';
import 'package:dineout/Utils/dark_light_mode.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:dineout/widgets/nodata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RelatedRestaurantsList extends StatefulWidget {
  final bool showTitle;
  const RelatedRestaurantsList({Key? key, this.showTitle = false})
      : super(key: key);

  @override
  State<RelatedRestaurantsList> createState() => _RelatedRestaurantsListState();
}

class _RelatedRestaurantsListState extends State<RelatedRestaurantsList> {
  late ColorNotifier notifier;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return GetBuilder<HomeController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showTitle)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Related Restaurants".tr,
                  style: TextStyle(
                      fontSize: 16,
                      color: notifier.textColor,
                      fontFamily: "Gilroy Bold"),
                ),
                SizedBox(height: Get.height * 0.02),
              ],
            ),
          Container(
            // color: Colors.pink,
            width: double.infinity,
            // height: controller.allrest.length > 0 ? Get.height * 0.4 : null,
            child: controller.allrest.length > 0
                ? CarouselSlider.builder(
                    itemCount: controller.allrest.length,
                    itemBuilder:
                        (BuildContext context, int index, int pageViewIndex) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => HotelDetails(
                              detailId: controller.allrest[index]["id"]));
                        },
                        child: Stack(
                          children: [
                            Container(
                              // margin: EdgeInsets.only(left: 6, right: 6),

                              // height: Get.height / 6,
                              width: double.infinity,

                              decoration: BoxDecoration(
                                // color: Colors.amber,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: FadeInImage.assetNetwork(
                                  fadeInCurve: Curves.easeInCirc,
                                  placeholder: "assets/ezgif.com-crop.gif",
                                  height: Get.height * 0.70,
                                  // width: Get.width * 0.8,
                                  placeholderCacheHeight: 320,
                                  placeholderCacheWidth: 240,
                                  placeholderFit: BoxFit.fill,
                                  // placeholderScale: 1.0,

                                  image: AppUrl.imageurl +
                                      controller.allrest[index]["img"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: const [
                                      0.4,
                                      0.8,
                                      1
                                    ],
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.6),
                                      Colors.black.withOpacity(0.8),
                                    ]),
                              ),
                            ),
                            Positioned(
                                top: -10,
                                right: 45,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  height: Get.height * 0.12,
                                  width: Get.width * 0.48,
                                  color: orangeshadow.withOpacity(0.5),
                                  child: Container(
                                    height: Get.height * 0.08,
                                    width: Get.width * 0.34,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: WhiteColor)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GetBuilder<HomeController>(
                                            builder: (context) {
                                          String currentdiscount = "";
                                          DateTime date = DateTime.now();
                                          String dateFormat =
                                              DateFormat('EEEE').format(date);
                                          if (dateFormat == "Friday" ||
                                              dateFormat == "Saturday" ||
                                              dateFormat == "Sunday") {
                                            currentdiscount = controller
                                                .allrest[index]["frisun"];
                                          } else {
                                            currentdiscount = controller
                                                .allrest[index]["monthru"];
                                          }

                                          return Text(
                                            "${currentdiscount}% OFF",
                                            style: TextStyle(
                                                fontFamily: "Gilroy Bold",
                                                color: notifier.textColor,
                                                fontSize: 20),
                                          );
                                        }),
                                        SizedBox(height: Get.height * 0.01),
                                        Text(
                                          "Today's Discount".tr.toUpperCase(),
                                          style: TextStyle(
                                              fontFamily: "Gilroy Medium",
                                              color: notifier.textColor,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                            Positioned(
                              left: 14,
                              bottom: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: Get.height * 0.08),
                                  Text(
                                    controller.allrest[index]["title"],
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: WhiteColor,
                                        fontFamily: "Gilroy Medium"),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.star_rate_rounded,
                                          color: yelloColor, size: 22),
                                      Text(
                                        controller.allrest[index]["rate"],
                                        style: TextStyle(
                                            color: greycolor,
                                            fontFamily: "Gilroy Bold",
                                            fontSize: 16),
                                      ),
                                      SizedBox(width: Get.width * 0.01),
                                      CircleAvatar(
                                          radius: 2,
                                          backgroundColor: greycolor),
                                      SizedBox(width: Get.width * 0.02),
                                      Text(
                                        controller.allrest[index]["landmark"],
                                        style: TextStyle(
                                            color: greycolor,
                                            fontFamily: "Gilroy Bold",
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.4,
                                    child: Text(
                                        controller.allrest[index]["sdesc"],
                                        style: TextStyle(
                                            color: greycolor,
                                            fontFamily: "Gilroy Medium",
                                            fontSize: 14)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      // aspectRatio: 12,
                      // enlargeCenterPage: true,
                      autoPlay: true,
                      // height: Get.height * 0.5,
                      enlargeCenterPage: true,
                      height: 200,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                    ),
                  )
                : Nodata(
                    text: "No restaurants found",
                  ),
          ),
        ],
      );
    });
  }
}


// import 'package:dineout/HomeScreen/Hotel_Details.dart';
// import 'package:dineout/Utils/Colors.dart';
// import 'package:dineout/Utils/Custom_widegt.dart';
// import 'package:dineout/Utils/dark_light_mode.dart';
// import 'package:dineout/api/confrigation.dart';
// import 'package:dineout/widgets/nodata.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class RelatedRestaurantsList extends StatefulWidget {
//   const RelatedRestaurantsList({Key? key}) : super(key: key);

//   @override
//   State<RelatedRestaurantsList> createState() => _RelatedRestaurantsListState();
// }

// class _RelatedRestaurantsListState extends State<RelatedRestaurantsList> {
//   late ColorNotifier notifier;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     notifier = Provider.of<ColorNotifier>(context, listen: true);
//     return GetBuilder<HomeController>(builder: (controller) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Related Restaurants".tr,
//             style: TextStyle(
//                 fontSize: 16,
//                 color: notifier.textColor,
//                 fontFamily: "Gilroy Bold"),
//           ),
//           SizedBox(height: Get.height * 0.02),
//           SizedBox(
//             width: double.infinity,
//             height: controller.allrest.length > 0 ? Get.height * 0.4 : null,
//             child: controller.allrest.length > 0
//                 ? CarouselSlider.builder(
//                     itemCount: controller.allrest.length,
//                     itemBuilder:
//                         (BuildContext context, int index, int pageViewIndex) {
//                       return InkWell(
//                         onTap: () {
//                           Get.to(() => HotelDetails(
//                               detailId: controller.allrest[index]["id"]));
//                         },
//                         child: Stack(
//                           children: [
//                             Container(
//                               margin: EdgeInsets.only(left: 6, right: 6),
//                               // height: Get.height / 6,

//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(15),
//                                 child: FadeInImage.assetNetwork(
//                                   fadeInCurve: Curves.easeInCirc,
//                                   placeholder: "assets/ezgif.com-crop.gif",
//                                   height: Get.height * 0.70,
//                                   width: Get.width * 0.8,
//                                   placeholderCacheHeight: 320,
//                                   placeholderCacheWidth: 240,
//                                   placeholderFit: BoxFit.fill,
//                                   // placeholderScale: 1.0,

//                                   image: AppUrl.imageurl +
//                                       controller.allrest[index]["img"],
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                     begin: Alignment.topCenter,
//                                     end: Alignment.bottomCenter,
//                                     stops: const [
//                                       0.6,
//                                       0.8,
//                                       1
//                                     ],
//                                     colors: [
//                                       Colors.transparent,
//                                       Colors.black.withOpacity(0.9),
//                                       Colors.black.withOpacity(0.8),
//                                     ]),
//                               ),
//                             ),
//                             Positioned(
//                                 top: -10,
//                                 right: 45,
//                                 child: Container(
//                                   padding: EdgeInsets.all(8),
//                                   height: Get.height * 0.12,
//                                   width: Get.width * 0.48,
//                                   color: orangeshadow.withOpacity(0.5),
//                                   child: Container(
//                                     height: Get.height * 0.08,
//                                     width: Get.width * 0.34,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(color: WhiteColor)),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         GetBuilder<HomeController>(
//                                             builder: (context) {
//                                           String currentdiscount = "";
//                                           DateTime date = DateTime.now();
//                                           String dateFormat =
//                                               DateFormat('EEEE').format(date);
//                                           if (dateFormat == "Friday" ||
//                                               dateFormat == "Saturday" ||
//                                               dateFormat == "Sunday") {
//                                             currentdiscount = controller
//                                                 .allrest[index]["frisun"];
//                                           } else {
//                                             currentdiscount = controller
//                                                 .allrest[index]["monthru"];
//                                           }

//                                           return Text(
//                                             "${currentdiscount}% OFF",
//                                             style: TextStyle(
//                                                 fontFamily: "Gilroy Bold",
//                                                 color: notifier.textColor,
//                                                 fontSize: 20),
//                                           );
//                                         }),
//                                         SizedBox(height: Get.height * 0.01),
//                                         Text(
//                                           "Today's Discount".tr.toUpperCase(),
//                                           style: TextStyle(
//                                               fontFamily: "Gilroy Medium",
//                                               color: notifier.textColor,
//                                               fontSize: 12),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 )),
//                             Positioned(
//                               left: 14,
//                               bottom: 10,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(height: Get.height * 0.08),
//                                   Text(
//                                     controller.allrest[index]["title"],
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         color: WhiteColor,
//                                         fontFamily: "Gilroy Medium"),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Icon(Icons.star_rate_rounded,
//                                           color: yelloColor, size: 22),
//                                       Text(
//                                         controller.allrest[index]["rate"],
//                                         style: TextStyle(
//                                             color: greycolor,
//                                             fontFamily: "Gilroy Bold",
//                                             fontSize: 16),
//                                       ),
//                                       SizedBox(width: Get.width * 0.01),
//                                       CircleAvatar(
//                                           radius: 2,
//                                           backgroundColor: greycolor),
//                                       SizedBox(width: Get.width * 0.02),
//                                       Text(
//                                         controller.allrest[index]["landmark"],
//                                         style: TextStyle(
//                                             color: greycolor,
//                                             fontFamily: "Gilroy Bold",
//                                             fontSize: 16),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     width: Get.width * 0.4,
//                                     child: Text(
//                                         controller.allrest[index]["sdesc"],
//                                         style: TextStyle(
//                                             color: greycolor,
//                                             fontFamily: "Gilroy Medium",
//                                             fontSize: 14)),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                     options: CarouselOptions(
//                         // aspectRatio: 12,
//                         enlargeCenterPage: true,
//                         autoPlay: true,
//                         height: Get.height * 0.5),
//                   )
//                 : Nodata(
//                     text: "No restaurants found",
//                   ),
//           ),
//         ],
//       );
//     });
//   }
// }
