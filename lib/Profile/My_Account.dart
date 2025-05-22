// ignore_for_file: prefer_const_constructors, file_names, must_be_immutable

import 'package:dineout/Getx_Controller/Controller.dart';
import 'package:dineout/Getx_Controller/Discount_order_list_controller.dart';
import 'package:dineout/Getx_Controller/PaymentGetwey_controller.dart';
import 'package:dineout/Utils/Colors.dart';
import 'package:dineout/Utils/Custom_widegt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/dark_light_mode.dart';

class MyAccount extends StatefulWidget {
  String? hotelname;
  String? hoteladdress;
  String? payamount;
  String? billdiscount;
  String? bookdate;
  String? booktime;
  MyAccount(
      {this.hotelname,
      this.hoteladdress,
      this.payamount,
      this.billdiscount,
      this.bookdate,
      this.booktime,
      super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  void initState() {
    getDarkMode();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      PaymentgatewayController paymentgatewayController = Get.find();
      paymentgatewayController.getPaymentHistory();
    });
    // discountorderlist.discountorderlist();
  }

  DiscountorderlistController discountorderlist =
      Get.put(DiscountorderlistController());
  HomeController homedata = Get.put(HomeController());
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
    PaymentgatewayController paymentgatewayController = Get.find();
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: notifier.background,
        leading: Transform.translate(
          offset: const Offset(-2, 0),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Image.asset("assets/arrowleft.png",
                    height: 20, color: notifier.textColor)),
          ),
        ),
        title: Text("Your Eat In Out".tr,
            style: TextStyle(
                fontFamily: "Gilroy ExtraBold", color: notifier.textColor)),
      ),
      body: GetBuilder<PaymentgatewayController>(builder: (controller) {
        if (paymentgatewayController.isLoading) {
          return Center(
            child: CircularProgressIndi(),
          );
        }
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 16),
          // itemCount: discountorderlist.discountorder.length,
          itemCount: paymentgatewayController.paymentHistoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              // onTap: () {
              //   Get.to(() => const OrderDetails());
              // },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.67,
                        child: Text(
                          // discountorderlist.discountorder[index]["rest_title"],
                          paymentgatewayController
                                  .paymentHistoryList[index].restaurantTitle ??
                              '',
                          style: TextStyle(
                              fontFamily: "Gilroy Bold",
                              color: notifier.textColor,
                              fontSize: 18),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Bill paid".tr,
                            style: TextStyle(
                                fontFamily: "Gilroy Medium",
                                color: notifier.textColor,
                                fontSize: 16),
                          ),
                          SizedBox(width: Get.width * 0.018),
                          Image.asset("assets/Checkmark.png", height: 20)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: Get.height * 0.015),
                  Row(
                    children: [
                      Text(
                        // "Total Bill: ${homedata.homeDataList["currency"]}${discountorderlist.discountorder[index]["total_amt"]}",
                        "Total Bill: ${paymentgatewayController.paymentHistoryList[index].totalAmount ?? ''}",
                        style: TextStyle(
                            fontFamily: "Gilroy Medium",
                            color: greycolor,
                            fontSize: 17),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.015),
                  Text(
                    // "Payed amount: ${homedata.homeDataList["currency"]}${discountorderlist.discountorder[index]["payed_amt"]}",
                    "Payed amount: ${paymentgatewayController.paymentHistoryList[index].payedAmount ?? ''}",
                    style: TextStyle(
                        fontFamily: "Gilroy Medium",
                        color: greycolor,
                        fontSize: 17),
                  ),
                  SizedBox(height: Get.height * 0.015),

                  // discountorderlist.discountorder[index]["transaction_id"] !=
                  // "0"
                  // ? Text(
                  Text(
                    // "Transaction id: ${discountorderlist.discountorder[index]["transaction_id"]}",
                    "Transaction id: ${paymentgatewayController.paymentHistoryList[index].transactionId ?? ''}",
                    style: TextStyle(
                        fontFamily: "Gilroy Medium",
                        color: notifier.textColor,
                        fontSize: 16),
                  )
                  // : SizedBox(),
                  ,
                  // discountorderlist.discountorder[index]["transaction_id"] !=
                  // "0"
                  // ? SizedBox(height: Get.height * 0.015)
                  SizedBox(height: Get.height * 0.015),
                  // : SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // "Tip amount: ${homedata.homeDataList["currency"]}${discountorderlist.discountorder[index]["tip_amt"]}",
                        "Tip amount: ${paymentgatewayController.paymentHistoryList[index].tipAmount ?? ''}",
                        style: TextStyle(
                            fontFamily: "Gilroy Medium",
                            color: greycolor,
                            fontSize: 16),
                      ),
                      SizedBox(
                        child: Text(
                          // "Discount amount: ${homedata.homeDataList["currency"]}${discountorderlist.discountorder[index]["discount_amt"]}",
                          "Discount amount: ${paymentgatewayController.paymentHistoryList[index].discountAmount ?? ''}",
                          style: TextStyle(
                              fontFamily: "Gilroy Medium",
                              color: notifier.background,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.015),
                  Builder(builder: (context) {
                    DateTime parsedDate = DateTime.parse(
                        paymentgatewayController
                            .paymentHistoryList[index].createdAt
                            .toString());

                    // Step 2: DateFormat use karo desired format me
                    String formattedDate =
                        DateFormat("d MMMM y").format(parsedDate);
                    return Text(
                      // "Date: ${discountorderlist.discountorder[index]["order_date"]}",
                      "Date: $formattedDate",
                      style: TextStyle(
                          fontFamily: "Gilroy Medium",
                          color: greytext,
                          fontSize: 16),
                    );
                  }),
                  SizedBox(height: Get.height * 0.015),
                  Text(
                    // "Discount value: ${discountorderlist.discountorder[index]["discount_value"]}%",
                    "Discount value: ${paymentgatewayController.paymentHistoryList[index].discountAmount ?? ''}%",
                    style: TextStyle(
                        fontFamily: "Gilroy Medium",
                        color: greentext,
                        fontSize: 16),
                  ),
                  SizedBox(height: Get.height * 0.015),
                  dottedline(),
                  SizedBox(height: Get.height * 0.015),
                  // Text(
                  //   paymentgatewayController.paymentHistoryList[index].pa ?? '',
                  //   // "${discountorderlist.discountorder[index]["payment_title"]}",
                  //   style: TextStyle(
                  //       fontFamily: "Gilroy Medium",
                  //       color: greentext,
                  //       fontSize: 16),
                  // ),
                  // SizedBox(height: Get.height * 0.01),
                  Divider(color: notifier.background),
                  SizedBox(height: Get.height * 0.01),
                ],
              ),
            );
          },
        );
        // return Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        //   child: SingleChildScrollView(
        //     child: discountorderlist.isLoading
        //         ? discountorderlist.discountorder.isNotEmpty
        //             ? ListView.builder(
        //                 physics: NeverScrollableScrollPhysics(),
        //                 shrinkWrap: true,
        //                 padding: EdgeInsets.zero,
        //                 itemCount: discountorderlist.discountorder.length,
        //                 itemBuilder: (BuildContext context, int index) {
        //                   return InkWell(
        //                     // onTap: () {
        //                     //   Get.to(() => const OrderDetails());
        //                     // },
        //                     child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Row(
        //                           mainAxisAlignment:
        //                               MainAxisAlignment.spaceBetween,
        //                           children: [
        //                             SizedBox(
        //                               width: Get.width * 0.67,
        //                               child: Text(
        //                                 discountorderlist.discountorder[index]
        //                                     ["rest_title"],
        //                                 style: TextStyle(
        //                                     fontFamily: "Gilroy Bold",
        //                                     color: notifier.textColor,
        //                                     fontSize: 18),
        //                               ),
        //                             ),
        //                             Row(
        //                               children: [
        //                                 Text(
        //                                   "Bill paid".tr,
        //                                   style: TextStyle(
        //                                       fontFamily: "Gilroy Medium",
        //                                       color: notifier.textColor,
        //                                       fontSize: 16),
        //                                 ),
        //                                 SizedBox(width: Get.width * 0.018),
        //                                 Image.asset("assets/Checkmark.png",
        //                                     height: 20)
        //                               ],
        //                             )
        //                           ],
        //                         ),
        //                         SizedBox(height: Get.height * 0.015),
        //                         Row(
        //                           children: [
        //                             Text(
        //                               "Total Bill: ${homedata.homeDataList["currency"]}${discountorderlist.discountorder[index]["total_amt"]}",
        //                               style: TextStyle(
        //                                   fontFamily: "Gilroy Medium",
        //                                   color: greycolor,
        //                                   fontSize: 17),
        //                             ),
        //                           ],
        //                         ),
        //                         SizedBox(height: Get.height * 0.015),
        //                         Text(
        //                           "Payed amount: ${homedata.homeDataList["currency"]}${discountorderlist.discountorder[index]["payed_amt"]}",
        //                           style: TextStyle(
        //                               fontFamily: "Gilroy Medium",
        //                               color: greycolor,
        //                               fontSize: 17),
        //                         ),
        //                         SizedBox(height: Get.height * 0.015),
        //                         discountorderlist.discountorder[index]
        //                                     ["transaction_id"] !=
        //                                 "0"
        //                             ? Text(
        //                                 "Transaction id: ${discountorderlist.discountorder[index]["transaction_id"]}",
        //                                 style: TextStyle(
        //                                     fontFamily: "Gilroy Medium",
        //                                     color: notifier.textColor,
        //                                     fontSize: 16),
        //                               )
        //                             : SizedBox(),
        //                         discountorderlist.discountorder[index]
        //                                     ["transaction_id"] !=
        //                                 "0"
        //                             ? SizedBox(height: Get.height * 0.015)
        //                             : SizedBox(),
        //                         Row(
        //                           mainAxisAlignment:
        //                               MainAxisAlignment.spaceBetween,
        //                           children: [
        //                             Text(
        //                               "Tip amount: ${homedata.homeDataList["currency"]}${discountorderlist.discountorder[index]["tip_amt"]}",
        //                               style: TextStyle(
        //                                   fontFamily: "Gilroy Medium",
        //                                   color: greycolor,
        //                                   fontSize: 16),
        //                             ),
        //                             SizedBox(
        //                               child: Text(
        //                                 "Discount amount: ${homedata.homeDataList["currency"]}${discountorderlist.discountorder[index]["discount_amt"]}",
        //                                 style: TextStyle(
        //                                     fontFamily: "Gilroy Medium",
        //                                     color: notifier.background,
        //                                     fontSize: 16),
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                         SizedBox(height: Get.height * 0.015),
        //                         Text(
        //                           "Date: ${discountorderlist.discountorder[index]["order_date"]}",
        //                           style: TextStyle(
        //                               fontFamily: "Gilroy Medium",
        //                               color: greytext,
        //                               fontSize: 16),
        //                         ),
        //                         SizedBox(height: Get.height * 0.015),
        //                         Text(
        //                           "Discount value: ${discountorderlist.discountorder[index]["discount_value"]}%",
        //                           style: TextStyle(
        //                               fontFamily: "Gilroy Medium",
        //                               color: greentext,
        //                               fontSize: 16),
        //                         ),
        //                         SizedBox(height: Get.height * 0.015),
        //                         dottedline(),
        //                         SizedBox(height: Get.height * 0.015),
        //                         Text(
        //                           "${discountorderlist.discountorder[index]["payment_title"]}",
        //                           style: TextStyle(
        //                               fontFamily: "Gilroy Medium",
        //                               color: greentext,
        //                               fontSize: 16),
        //                         ),
        //                         SizedBox(height: Get.height * 0.01),
        //                         Divider(color: notifier.background),
        //                         SizedBox(height: Get.height * 0.01),
        //                       ],
        //                     ),
        //                   );
        //                 },
        //               )
        //             : Padding(
        //                 padding: EdgeInsets.only(top: Get.height * 0.35),
        //                 child: Center(
        //                   child: Text(
        //                     "You have no upcoming dinning history.".tr,
        //                     style: TextStyle(
        //                         color: greycolor,
        //                         fontFamily: "Gilroy Bold",
        //                         fontSize: 16),
        //                   ),
        //                 ),
        //               )
        //         : Padding(
        //             padding: EdgeInsets.only(top: Get.height * 0.35),
        //             child: Center(child: CircularProgressIndi()),
        //           ),
        //   ),
        // );
      }),
    );
  }
}
