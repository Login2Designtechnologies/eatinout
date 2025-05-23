// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, unused_import, sort_child_properties_last, non_constant_identifier_names, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, avoid_print, prefer_typing_uninitialized_variables, unused_local_variable, unused_field, prefer_final_fields, prefer_interpolation_to_compose_strings, avoid_types_as_parameter_names
import 'dart:convert';
import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dineout/Getx_Controller/Controller.dart';
import 'package:dineout/Getx_Controller/Hotel_details_Controller.dart';
import 'package:dineout/Getx_Controller/Membership_controller.dart';
import 'package:dineout/Getx_Controller/Near_By_controller.dart';
import 'package:dineout/Getx_Controller/PaymentGetwey_controller.dart';
import 'package:dineout/Getx_Controller/Plan_purchase_Controller.dart';
import 'package:dineout/Getx_Controller/bottom_bar_controller.dart';
import 'package:dineout/Getx_Controller/location_controller.dart';
import 'package:dineout/HomeScreen/Cuisines.dart';
import 'package:dineout/HomeScreen/Hotel_Details.dart';
import 'package:dineout/HomeScreen/Nearby_hotel.dart';
import 'package:dineout/HomeScreen/Notification.dart';
import 'package:dineout/HomeScreen/View_details.dart';
import 'package:dineout/HomeScreen/location_option_page.dart';
import 'package:dineout/HomeScreen/widgets/category_menu.dart';
import 'package:dineout/HomeScreen/widgets/explore_cuisines_menu.dart';
import 'package:dineout/HomeScreen/widgets/looking_for_list.dart';
import 'package:dineout/HomeScreen/widgets/must_try_item.dart';
import 'package:dineout/HomeScreen/widgets/related_restaurants_list.dart';
import 'package:dineout/HomeScreen/widgets/treding_restaurant_list.dart';
import 'package:dineout/IntroScreen/IntroScreen.dart';
import 'package:dineout/LoginFlow/Login_In.dart';
import 'package:dineout/Profile/Profile.dart';
import 'package:dineout/Search/screens/search_screen.dart';
import 'package:dineout/Search/widgets/search_field.dart';

// import 'package:dineout/Utils/Bottom_bar.dart';
import 'package:dineout/Utils/Colors.dart';
import 'package:dineout/Utils/Custom_widegt.dart';
import 'package:dineout/Utils/String.dart';
import 'package:dineout/Utils/image.dart';
import 'package:dineout/api/Api_werper.dart';
import 'package:dineout/api/Data_save.dart';
import 'package:dineout/api/confrigation.dart';

import 'package:dineout/paymentscreen/FlutterWave.dart';
import 'package:dineout/paymentscreen/InputFormater.dart';
import 'package:dineout/paymentscreen/PaymentCard.dart';
import 'package:dineout/paymentscreen/Paypal.dart';
import 'package:dineout/paymentscreen/Paytm.dart';
import 'package:dineout/paymentscreen/StripeWeb.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

// import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Payment/web_view.dart';
import '../Utils/dark_light_mode.dart';
import '../paymentscreen/PayStack.dart';

String? uID;
// bool tablebookscreen = false;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// var lat;
// var long;

class _HomePageState extends State<HomePage> {
  // Homepage? homepage;

  @override
  void dispose() {
    numberController.removeListener(_getCardTypeFrmNumber);
    numberController.dispose();
    // _razorpay.clear();
    super.dispose();
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardTypee cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      _paymentCard.type = cardType;
    });
  }

  String? SelectedIndex;
  String? plan1;
  String? plan2;

  bool selected = true;
  bool defultplan = false;

  var first;
  var address;
  String selectidPay = "0";
  String razorpaykey = "";
  String? paymenttital;
  int? _groupValue;
  String? planid;
  String planprice = "0";
  final _paymentCard = PaymentCardCreated();
  var currency;
  var _autoValidateMode = AutovalidateMode.disabled;
  int currentTotalprice = 0;
  final _formKey = GlobalKey<FormState>();
  final _card = PaymentCardCreated();
  var numberController = TextEditingController();

  // late Razorpay _razorpay;

  // final plugin = PaystackPlugin();
  PaystackController paystackCont = Get.put(PaystackController());
  HomeController hData = Get.put(HomeController());

  // LocationController locationController = Get.put(LocationController());

  PlanpurchaseController planpurchase = Get.put(PlanpurchaseController());
  PaymentgatewayController payment = Get.put(PaymentgatewayController());

  // MembershipController membership = Get.put(MembershipController());
  String? accessToken = "";
  String payerID = "";
  String totelbill = "0";

  @override
  void initState() {
    super.initState();
    setState(() {
      // lat == null ? getUserLocation() : getUserLocation1();
      // locationController.getUserLocation();
      hData.getUserLocation();
      payment.paymentgateway();
    });
    // plugin.initialize(publicKey: AppUrl.publicKeyTest);
    //   _razorpay = Razorpay();
    //   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    //   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    //   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // }

    // void _handlePaymentSuccess(PaymentSuccessResponse response) {
    //   // bookNowOrder(response.paymentId);
    //   planpurchase.planpurchase(
    //       planid: planid, pname: paymenttital, transactionid: response.paymentId);
    // }

    // void _handlePaymentError(PaymentFailureResponse response) {
    //   print(
    //       'Error Response: ${"ERROR: " + response.code.toString() + " - " + response.message!}');
    //   showToastMessage(response.message!);
    // }

    // void _handleExternalWallet(ExternalWalletResponse response) {
    //   showToastMessage(response.walletName!);
  }

  late ColorNotifier notifier;

  // BottomBarController bottomBarController = Get.put(BottomBarController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    Future.delayed(Duration(seconds: 0), () {
      setState(() {});
    });
    // ignore: deprecated_member_use
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () {
      // payment.paymentgatewaySuccessEmail();
      // payment.paymentHistory(
      //     discountamount: "12",
      //     discountvalue: "15",
      //     payedamount: "44",
      //     paymentid: "a;dks23jlrqkwejr",
      //     restid: "23",
      //     tipamount: "12",
      //     totelamount: "666",
      //     transactionid: "alkjdsf 32234qwer",
      //     wallatamount: "0",
      //     tipcmt: "13");
      // HomeController homeController = Get.find();
      // print(homeController.dealList.length);
      // }),
      // bottomNavigationBar: GetBuilder<HomeController>(builder: (context) {
      //   return hData.homeDataList["is_subscribe"] == 0
      //       ? bottombar(
      //           Hedingtext: "special prices only for you".tr.toUpperCase(),
      //           bgcolor: transparent,
      //           buttontext1: "select a plan".tr.toUpperCase(),
      //           onTap: bottomsheet)
      //       : SizedBox();
      // }),
      backgroundColor: notifier.background,
      appBar: AppBar(
          leadingWidth: 35,
          elevation: 0,
          backgroundColor: notifier.background,
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  Get.to(Profile());
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: orangeColor.withOpacity(.3),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "D",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: orangeColor),
                  ),
                ),
              ),
            )

            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: InkWell(
            //       onTap: () {
            //         Get.to(() => Notificationpage());
            //       },
            //       child: Image.asset("assets/onesignal.png",
            //           height: 20, color: orangeColor)),
            // )
          ],
          leading: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LocationOptionPage()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Image.asset(
                  "assets/livelocation.png",
                  height: 15,
                  color: orangeColor,
                ),
              )),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width * 0.64,
                      child: Text(
                        "My Place",
                        style: TextStyle(fontFamily: "Gilroy Bold", color: notifier.textColor, fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.64,
                      child: Text(
                        "${hData.userAddress}",
                        style: TextStyle(fontFamily: "Gilroy Bold", color: notifier.textLightColor, fontSize: 13),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            Duration(seconds: 2),
            () {
              hData.homeDataApi();
            },
          );
        },
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: GetBuilder<HomeController>(builder: (hData) {
              // return Container(
              //   child: Center(
              //     child: Text("data"),
              //   ),
              // );
              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: hData.isLoading == true
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: size.width,
                              child: SearchField(
                                showSearchIcon: true,
                                readOnly: true,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                                },
                              ),
                            ),
                            // banner section
                            // banner section
                            SizedBox(height: 8),
                            Container(
                              height: 200,
                              width: size.width,
                              // color: Colors.amber,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://images.pexels.com/photos/825661/pexels-photo-825661.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            // cate menu
                            CategoryMenu(),

                            SizedBox(height: 16),
                            Container(
                              child: Text(
                                "IN THE LIMELIGHT",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey, letterSpacing: 2),
                              ),
                            ),
                            SizedBox(height: 16),
                            RelatedRestaurantsList(),

                            SizedBox(height: 24),
                            Container(
                              child: Text(
                                "WHAT ARE YOU LOOKING FOR?",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey, letterSpacing: 2),
                              ),
                            ),
                            SizedBox(height: 16),
                            LookingForList(),
                            SizedBox(height: 24),
                            Container(
                              child: Text(
                                "Must tries Deals".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey, letterSpacing: 2),
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        for (var i = 0; i < hData.dealsCateList.length; i++)
                                          MustTryItem(
                                            data: hData.dealsCateList[i],
                                            imageUrl:
                                                "https://media.istockphoto.com/id/1079901206/photo/3d-render-of-luxury-restaurant-interior.jpg?s=1024x1024&w=is&k=20&c=PQmHArVArO8W1mTdl618qnyvbR4yOkhJgXzXVL7NszU=",
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Membership
                                ? Column(
                                    children: [
                                      Text(provider.saved.tr, style: TextStyle(color: orangeColor, fontFamily: "Gilroy ExtraBold", fontSize: 20)),
                                      Text(provider.days.tr, style: TextStyle(color: greycolor, fontFamily: "Gilroy Bold", fontSize: 16)),
                                      SizedBox(height: Get.height * 0.02),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => ViewDetails());
                                        },
                                        child: Container(
                                          width: Get.width * 0.32,
                                          height: Get.height * 0.05,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: greycolor.withOpacity(0.5)), borderRadius: BorderRadius.circular(30)),
                                          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                            SizedBox(width: Get.width * 0.026),
                                            Text(
                                              provider.view.tr,
                                              style: TextStyle(fontFamily: "Gilroy Bold", color: notifier.textColor, fontSize: 14),
                                            ),
                                            Icon(
                                              Icons.keyboard_arrow_right,
                                              size: 20,
                                              color: notifier.textColor,
                                            )
                                          ]),
                                        ),
                                      ),
                                      SizedBox(height: Get.height * 0.02),
                                      Row(
                                        children: [
                                          SizedBox(width: Get.width * 0.05),
                                          Container(
                                            height: Get.height * 0.04,
                                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                                            width: Get.width * 0.2,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: RedColor),
                                            child: Center(
                                              child: Text(provider.Active.tr,
                                                  style: TextStyle(fontFamily: "Gilroy Bold", color: orangeColor, fontSize: 10),
                                                  textAlign: TextAlign.center),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.015),
                                          SizedBox(
                                            width: Get.width * 0.65,
                                            child: Text(
                                              provider.membership.tr,
                                              style: TextStyle(fontFamily: "Gilroy Medium", color: greycolor, fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Get.height * 0.03),
                                      dottedline(),
                                    ],
                                  )
                                : SizedBox(),
                            SizedBox(height: Get.height * 0.03),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Image.asset(image.petals,
                            //         height: 20, color: BlackColor),
                            //     SizedBox(width: Get.width * 0.02),
                            //     Text(
                            //       provider.membershipBe.tr.toUpperCase(),
                            //       style: TextStyle(
                            //           fontFamily: "Gilroy Medium",
                            //           color: greycolor,
                            //           letterSpacing: 4,
                            //           fontSize: 12),
                            //     ),
                            //     Image.asset(image.petals,
                            //         height: 20, color: notifier.background),
                            //     SizedBox(width: Get.width * 0.02),
                            //   ],
                            // ),
                            // SizedBox(height: Get.height * 0.03),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Container(
                                //   padding: EdgeInsets.symmetric(
                                //       horizontal: 12, vertical: 12),
                                //   decoration: BoxDecoration(
                                //       border: Border.all(
                                //           color: greycolor.withOpacity(0.5)),
                                //       borderRadius: BorderRadius.circular(15)),
                                //   child: Column(
                                //     children: [
                                //       Row(
                                //         children: [
                                //           Column(
                                //             crossAxisAlignment:
                                //                 CrossAxisAlignment.start,
                                //             children: [
                                //               SizedBox(
                                //                 width: Get.width * 0.65,
                                //                 child: Text(
                                //                   provider.upto.tr,
                                //                   style: TextStyle(
                                //                       fontFamily: "Gilroy Bold",
                                //                       color: notifier.textColor,
                                //                       fontSize: 14),
                                //                 ),
                                //               ),
                                //               Text(
                                //                 provider.attop.tr,
                                //                 style: TextStyle(
                                //                     fontFamily: "Gilroy Medium",
                                //                     color: greycolor,
                                //                     fontSize: 12),
                                //               ),
                                //             ],
                                //           ),
                                //           Image.asset(image.group2, height: 55),
                                //         ],
                                //       ),
                                //       SizedBox(height: 4),
                                //       InkWell(
                                //         splashColor: transparent,
                                //         onTap: () {
                                //           // Get.to(() => Nearbyhotel());
                                //         },
                                //         child: Container(
                                //           padding: EdgeInsets.symmetric(
                                //               horizontal: 10, vertical: 6),
                                //           decoration: BoxDecoration(
                                //               border: Border.all(
                                //                   color: greycolor
                                //                       .withOpacity(0.5)),
                                //               borderRadius:
                                //                   BorderRadius.circular(15)),
                                //           child: Row(
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment
                                //                       .spaceBetween,
                                //               children: [
                                //                 Row(
                                //                   children: [
                                //                     Image.asset(image.New,
                                //                         height: 20),
                                //                     SizedBox(
                                //                         width:
                                //                             Get.width * 0.04),
                                //                     Text(
                                //                       provider.explore.tr
                                //                           .toUpperCase(),
                                //                       style: TextStyle(
                                //                           color: orangeColor,
                                //                           fontFamily:
                                //                               "Gilroy Bold",
                                //                           fontSize: 13),
                                //                     ),
                                //                   ],
                                //                 ),
                                //                 CircleAvatar(
                                //                   radius: 15,
                                //                   backgroundColor: BlackColor,
                                //                   backgroundImage:
                                //                       AssetImage(image.deniout),
                                //                 )
                                //               ]),
                                //         ),
                                //       ),
                                //       SizedBox(height: Get.height * 0.02),
                                //       InkWell(
                                //         onTap: () {
                                //           Get.to(() => Nearbyhotel());
                                //         },
                                //         child: Container(
                                //           padding: EdgeInsets.symmetric(
                                //               horizontal: 10, vertical: 6),
                                //           decoration: BoxDecoration(
                                //               border: Border.all(
                                //                   color: greycolor
                                //                       .withOpacity(0.5)),
                                //               borderRadius:
                                //                   BorderRadius.circular(15)),
                                //           child: Row(
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment
                                //                       .spaceBetween,
                                //               children: [
                                //                 Row(
                                //                   children: [
                                //                     Image.asset(image.New,
                                //                         height: 20,
                                //                         color: yelloColor),
                                //                     SizedBox(
                                //                         width:
                                //                             Get.width * 0.04),
                                //                     Text(
                                //                       "book a table"
                                //                           .tr
                                //                           .toUpperCase(),
                                //                       style: TextStyle(
                                //                           color: yelloColor,
                                //                           fontFamily:
                                //                               "Gilroy Bold",
                                //                           fontSize: 13),
                                //                     ),
                                //                   ],
                                //                 ),
                                //                 CircleAvatar(
                                //                   radius: 15,
                                //                   backgroundColor: yelloColor,
                                //                   backgroundImage: AssetImage(
                                //                       "assets/group3.png"),
                                //                 )
                                //               ]),
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),
                                SizedBox(height: Get.height * 0.02),
                                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  TredingRestaurantList(),
                                  // SizedBox(height: Get.height * 0.04),

                                  ExploreCuisinesMenu(),
                                  // SizedBox(height: Get.height * 0.02),
                                  RelatedRestaurantsList(
                                    showTitle: true,
                                  ),
                                ]),
                                SizedBox(height: Get.height * 0.02)
                              ],
                            ),
                          ],
                        )
                      : Center(
                          child: Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.4),
                          child: CircularProgressIndi(),
                        )));
            })),
      ),
    );
  }

  webViewPaymentMethod({required String initialUrl, required String status1, required String status2}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentWebVIew(
          initialUrl: initialUrl,
          navigationDelegate: (request) async {
            final uri = Uri.parse(request.url);

            debugPrint("************ URL:--- $initialUrl");
            debugPrint("************ Navigating to URL: ${request.url}");
            debugPrint("************ Parsed URI: $uri");
            debugPrint("************ 2435243254: ${uri.queryParameters[status1]}");

            // Check the status parameter instead of Result
            final status = uri.queryParameters[status1];
            debugPrint(" /*/*/*/*/*/*/*/*/*/*/*/*/*/ Status ---- $status");
            if (status == null) {
              debugPrint("No status parameter found.");
            } else {
              debugPrint("Status parameter: $status");
              if (status == status2) {
                debugPrint("Purchase successful.");
                Get.back();
                Get.back();
                planpurchase.planpurchase(planid: planid, pname: paymenttital, transactionid: "transactionid");

                return NavigationDecision.prevent;
              } else {
                debugPrint("Purchase failed with status: $status.");
                Navigator.pop(context);
                // ignore: unnecessary_string_interpolations
                tost("$status");
                return NavigationDecision.prevent;
              }
            }
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }

  bottomsheet() {
    // Get.back();
    return showModalBottomSheet(
        backgroundColor: RedColor.withOpacity(0.9),
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: Get.height * 0.35,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/confetti1.png", height: 25),
                      SizedBox(width: Get.width * 0.02),
                      Text("special prices only for you".tr.toUpperCase(),
                          style: TextStyle(fontFamily: "Gilroy Bold", color: Colors.white, fontSize: 15)),
                      SizedBox(width: Get.width * 0.02),
                      Image.asset("assets/confetti.png", height: 25)
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.2,
                    width: double.infinity,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: hData.PlanData.length,
                        itemBuilder: (context, index) {
                          return Stack(children: [
                            Container(
                              height: 150,
                              width: 172,
                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 6),
                              child: InkWell(
                                onTap: () {
                                  setState(() {});
                                  defultplan = true;
                                  SelectedIndex = hData.PlanData[index]["id"];
                                  print("*+*+*+*+*+*+*-+-/-+ hData PlanData-*-+*-*/-+*----*-+-*+-*+"
                                      "${hData.PlanData[index]["price"]}");
                                  plan1 = hData.PlanData[index]["title"];
                                  plan2 = hData.PlanData[index]["price"];
                                  planid = hData.PlanData[index]["id"];
                                  planprice = hData.PlanData[index]["price"];
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: WhiteColor,
                                      border: Border.all(color: SelectedIndex == hData.PlanData[index]["id"] ? orangeColor : transparent, width: 2)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(hData.PlanData[index]["title"],
                                          style: TextStyle(color: notifier.textColor, fontFamily: "Gilroy Bold", fontSize: 16)),
                                      SizedBox(height: Get.height * 0.015),
                                      Row(
                                        children: [
                                          Text("${hData.homeDataList["currency"]}${hData.PlanData[index]["price"]}",
                                              style: TextStyle(color: notifier.textColor, fontFamily: "Gilroy Bold", fontSize: 18)),
                                        ],
                                      ),
                                      SizedBox(height: Get.height * 0.015),
                                      Text("${hData.PlanData[index]["day"]}day",
                                          style: TextStyle(color: darkpurple, fontFamily: "Gilroy Bold", fontSize: 16))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: -0.2,
                              top: 4,
                              child: InkWell(
                                onTap: () {
                                  // selected = selected;
                                },
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: SelectedIndex == hData.PlanData[index]["id"] ? orangeColor : transparent,
                                  child: Icon(Icons.check, color: SelectedIndex == hData.PlanData[index]["id"] ? notifier.textColor : transparent),
                                ),
                              ),
                            )
                          ]);
                        }),
                  ),
                  InkWell(
                    onTap: () {
                      // ignore: unnecessary_null_comparison
                      if (planprice != null) {
                        Get.back();
                        paymentSheett();
                      } else {
                        ApiWrapper.showToastMessage("Please select at least one plan".tr);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            stops: [0.1, 0.8, 1],
                            colors: <Color>[
                              orangeColor,
                              orangeColor,
                              orangeColor,
                              // Colors.red
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: orangeColor),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "subscribe now".tr.toUpperCase(),
                              style: TextStyle(fontFamily: 'Gilroy Bold', fontSize: 16, color: WhiteColor),
                            ),
                            SizedBox(height: 2),
                            !defultplan
                                ? Text(
                                    "select plan".tr,
                                    style: TextStyle(fontFamily: 'Gilroy Bold', fontSize: 14, color: WhiteColor),
                                  )
                                : Text(
                                    "at ${hData.homeDataList["currency"]}${plan2} for ${plan1}",
                                    style: TextStyle(fontFamily: 'Gilroy Bold', fontSize: 14, color: WhiteColor),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  Future paymentSheett() {
    return showModalBottomSheet(
      backgroundColor: boxcolor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return Wrap(children: [
          StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Center(
                  child: Container(
                    height: Get.height / 80,
                    width: Get.width / 5,
                    decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
                SizedBox(height: Get.height / 50),
                Row(children: [
                  SizedBox(width: Get.width / 14),
                  Text("Select Payment Method".tr, style: TextStyle(color: WhiteColor, fontSize: Get.height / 40, fontFamily: "Gilroy Medium")),
                ]),
                SizedBox(height: Get.height / 50),
                //! --------- List view paymente ----------
                SizedBox(
                  height: Get.height * 0.50,
                  child: GetBuilder<PaymentgatewayController>(builder: (context) {
                    return payment.isLoading
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: payment.paymentGetway.length,
                            itemBuilder: (ctx, i) {
                              return payment.paymentGetway[i]["p_show"] == "1"
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      child: sugestlocationtype(
                                        borderColor: selectidPay == payment.paymentGetway[i]["id"] ? orangeColor : greycolor.withOpacity(0.5),
                                        title: payment.paymentGetway[i]["title"],
                                        titleColor: WhiteColor,
                                        val: 0,
                                        image: AppUrl.imageurl + payment.paymentGetway[i]["img"],
                                        adress: payment.paymentGetway[i]["subtitle"],
                                        ontap: () async {
                                          setState(() {
                                            razorpaykey = payment.paymentGetway[i]["attributes"];
                                            paymenttital = payment.paymentGetway[i]["title"];
                                            selectidPay = payment.paymentGetway[i]["id"];
                                            _groupValue = i;
                                          });
                                        },
                                        radio: Radio(
                                          activeColor: orangeColor,
                                          value: i,
                                          // fillColor:
                                          //     MaterialStateColor.resolveWith(
                                          //         (states) => orangeColor),
                                          groupValue: _groupValue,
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    )
                                  : SizedBox();
                            },
                          )
                        : Center(
                            child: CircularProgressIndi(),
                          );
                  }),
                ),
                Container(
                  height: 80,
                  width: Get.size.width,
                  alignment: Alignment.center,
                  child: GestButton(
                    Width: Get.size.width,
                    height: 50,
                    buttoncolor: orangeColor,
                    margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                    buttontext: "Continue".tr,
                    style: TextStyle(
                      fontFamily: "",
                      color: WhiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    onclick: () {
                      //!---- Stripe Payment ------

                      print("*+*+*+*+*+*+*-+-/-+ planprice-*-+*-*/-+*----*-+-*+-*+"
                          "${planprice}");

                      if (paymenttital == "Razorpay") {
                        Get.back();
                        openCheckout();
                      } else if (paymenttital == "Pay TO Owner") {
                        planpurchase.planpurchase(
                          planid: planid,
                          pname: paymenttital,
                        );
                        Get.back();
                      } else if (paymenttital == "Paypal") {
                        payplepayment(onSuccess: (Map params) {
                          planpurchase.planpurchase(planid: planid, pname: paymenttital, transactionid: params["paymentId"]);
                        });
                      } else if (paymenttital == "Stripe") {
                        Get.back();
                        stripePayment();
                      } else if (paymenttital == "PayStack") {
                        paystackCont.getPaystack(amount: planprice).then(
                          (value) {
                            Get.to(() => PaymentWebVIew(
                                      initialUrl: value["data"]["authorization_url"],
                                      navigationDelegate: (NavigationRequest request) async {
                                        final uri = Uri.parse(request.url);
                                        print("PAYSTACK RESPONSE ${request}");
                                        print("PAYSTACK URL  ${request.url}");
                                        Get.back();
                                        Get.back();
                                        paystackCont
                                            .checkPaystack(
                                                sKey: planpurchase.planpurchase(planid: planid, pname: paymenttital, transactionid: "transactionid"))
                                            .then(
                                              (value) {},
                                            );

                                        return NavigationDecision.navigate;
                                      },
                                    ))!
                                .then((otid) {
                              //! order Api call
                              if (otid != null) {
                                planpurchase.planpurchase(planid: planid, pname: paymenttital, transactionid: otid);
                              } else {}
                            });
                          },
                        );
                      } else if (paymenttital == "Payfast") {
                        debugPrint("payFast");
                        webViewPaymentMethod(
                          initialUrl: "${AppUrl.paymentBaseUrl + AppUrl.payFast}amt=$planprice",
                          status1: "status",
                          status2: "success",
                        );
                      } else if (paymenttital == "Midtrans") {
                        webViewPaymentMethod(
                          initialUrl:
                              "${AppUrl.paymentBaseUrl}Midtrans/index.php?name=test&email=${getData.read("UserLogin")["email"]}&phone=${getData.read("UserLogin")["ccode"] + getData.read("UserLogin")["mobile"]}&amt=${planprice}",
                          status1: "status_code",
                          status2: "200",
                        );
                      } else if (paymenttital == "Khalti Payment") {
                        print("===================:-------");
                        Get.to(() => PaymentWebVIew(
                                  initialUrl: "${AppUrl.paymentBaseUrl}Khalti/index.php?amt=${planprice}",
                                  navigationDelegate: (NavigationRequest request) async {
                                    final uri = Uri.parse(request.url);
                                    print("URL + ${uri.queryParameters}");
                                    if (uri.queryParameters["status"] == null) {
                                      // accessToken = uri.queryParameters["token"]!;
                                    } else {
                                      if (uri.queryParameters["status"] == "Completed") {
                                        payerID = uri.queryParameters["transaction_id"]!;
                                        print("PAYER ID $payerID");
                                        Get.back(result: payerID);
                                      } else {
                                        Get.back();
                                        Fluttertoast.showToast(msg: "${uri.queryParameters["status"]}", timeInSecForIosWeb: 4);
                                      }
                                    }
                                    return NavigationDecision.navigate;
                                  },
                                ))!
                            .then((otid) {
                          if (otid != null) {
                            planpurchase.planpurchase(planid: planid, pname: paymenttital, transactionid: otid);
                          } else {
                            Get.back();
                          }
                        });
                      } else if (paymenttital == "2checkout") {
                        debugPrint("2checkout");
                        webViewPaymentMethod(
                          initialUrl: "${AppUrl.paymentBaseUrl}2checkout/index.php?amt=${planprice}",
                          status1: "status",
                          status2: "successful",
                        );
                      }
                      //===================================== done
                      else if (paymenttital == "MercadoPago") {
                        print("===================:-------");

                        webViewPaymentMethod(
                            initialUrl: "${AppUrl.paymentBaseUrl}merpago/index.php?amt=${planprice}", status1: "status", status2: "successful");
                      } else if (paymenttital == "FlutterWave") {
                        Get.to(() => Flutterwave(
                                  totalAmount: currentTotalprice.toString(),
                                  email: getData.read("UserLogin")["email"].toString(),
                                ))!
                            .then((otid) {
                          if (otid != null) {
                            planpurchase.planpurchase(planid: planid, pname: paymenttital, transactionid: otid);
                          } else {
                            Get.back();
                          }
                        });
                      } else if (paymenttital == "Paytm") {
                        Get.to(() => PayTmPayment(
                                  totalAmount: currentTotalprice.toString(),
                                  uid: getData.read("UserLogin")["id"].toString(),
                                ))!
                            .then((otid) {
                          if (otid != null) {
                            planpurchase.planpurchase(planid: planid, pname: paymenttital, transactionid: otid);
                          } else {
                            Get.back();
                          }
                        });
                      } else if (paymenttital == "SenangPay") {
                        print(paymenttital.toString());
                      }
                    },
                  ),
                  decoration: BoxDecoration(
                    color: BlackColor,
                  ),
                ),
              ],
            );
          }),
        ]);
      },
    );
  }

  Widget sugestlocationtype({Function()? ontap, title, val, image, adress, radio, Color? borderColor, Color? titleColor}) {
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return InkWell(
        splashColor: Colors.transparent,
        onTap: ontap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 18),
          child: Container(
            height: Get.height / 9,
            decoration:
                BoxDecoration(border: Border.all(color: borderColor!, width: 1), color: Colors.transparent, borderRadius: BorderRadius.circular(11)),
            child: Row(
              children: [
                SizedBox(width: Get.width / 55),
                Container(
                    height: Get.height / 12,
                    width: Get.width / 5.5,
                    decoration: BoxDecoration(color: const Color(0xffF2F4F9), borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: FadeInImage(placeholder: const AssetImage("assets/loading2.gif"), image: NetworkImage(image)),
                      // Image.network(image, height: Get.height / 08)
                    )),
                SizedBox(width: Get.width / 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.01),
                    Text(title,
                        style: TextStyle(
                          fontSize: Get.height / 55,
                          fontFamily: "Gilroy Bold",
                          color: titleColor,
                        )),
                    SizedBox(
                      width: Get.width * 0.50,
                      child: Text(adress,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: Get.height / 65, fontFamily: "Gilroy Medium", color: Colors.grey)),
                    ),
                  ],
                ),
                const Spacer(),
                radio
              ],
            ),
          ),
        ),
      );
    });
  }

  //!-------- Razorpay ----------//

  void openCheckout() async {
    var username = getData.read("UserLogin")["name"] ?? "";
    var mobile = getData.read("UserLogin")["mobile"] ?? "";
    var email = getData.read("UserLogin")["email"] ?? "";
    print("razorpaykeyrazorpaykey" "$razorpaykey");
    var options = {
      'key': razorpaykey,
      'amount': (double.parse(planprice.toString()) * 100).toString(),
      'name': username,
      'description': "",
      'timeout': 500,
      'prefill': {'contact': mobile, 'email': email},
    };
    print("#################" "$username");

    print("%%%%%%%%%%%%%%%%%" "$mobile");
    print("&&&&&&&&&&&&&&&&&" "$email");

    print("*****************" "$options");
    try {
      // _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  stripePayment() {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: boxcolor,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Ink(
                child: Column(
                  children: [
                    SizedBox(height: Get.height / 45),
                    Center(
                      child: Container(
                        height: Get.height / 85,
                        width: Get.width / 5,
                        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.4), borderRadius: const BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height * 0.03),
                          Text("Add Your payment information".tr,
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 0.5)),
                          SizedBox(height: Get.height * 0.02),
                          Form(
                            key: _formKey,
                            autovalidateMode: _autoValidateMode,
                            child: Column(
                              children: [
                                const SizedBox(height: 16),
                                TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(19),
                                    CardNumberInputFormatter()
                                  ],
                                  controller: numberController,
                                  onSaved: (String? value) {
                                    _paymentCard.number = CardUtils.getCleanedNumber(value!);

                                    CardTypee cardType = CardUtils.getCardTypeFrmNumber(_paymentCard.number.toString());
                                    setState(() {
                                      _card.name = cardType.toString();
                                      _paymentCard.type = cardType;
                                    });
                                  },
                                  onChanged: (val) {
                                    CardTypee cardType = CardUtils.getCardTypeFrmNumber(val);
                                    setState(() {
                                      _card.name = cardType.toString();
                                      _paymentCard.type = cardType;
                                    });
                                  },
                                  validator: CardUtils.validateCardNum,
                                  decoration: InputDecoration(
                                    prefixIcon: SizedBox(
                                      height: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 14,
                                          horizontal: 6,
                                        ),
                                        child: CardUtils.getCardIcon(
                                          _paymentCard.type,
                                        ),
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: orangeColor,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: orangeColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: orangeColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: orangeColor,
                                      ),
                                    ),
                                    hintText: "What number is written on card?".tr,
                                    hintStyle: TextStyle(color: Colors.grey),
                                    labelStyle: TextStyle(color: Colors.grey),
                                    labelText: "Number".tr,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 4,
                                      child: TextFormField(
                                        style: TextStyle(color: Colors.grey),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                        ],
                                        decoration: InputDecoration(
                                            prefixIcon: SizedBox(
                                              height: 10,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 14),
                                                child: Image.asset(
                                                  'assets/card_cvv.png',
                                                  width: 6,
                                                  color: orangeColor,
                                                ),
                                              ),
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: orangeColor,
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: orangeColor,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: orangeColor,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: orangeColor)),
                                            hintText: "Number behind the card".tr,
                                            hintStyle: TextStyle(color: Colors.grey),
                                            labelStyle: TextStyle(color: Colors.grey),
                                            labelText: 'CVV'.tr),
                                        validator: CardUtils.validateCVV,
                                        keyboardType: TextInputType.number,
                                        onSaved: (value) {
                                          _paymentCard.cvv = int.parse(value!);
                                        },
                                      ),
                                    ),
                                    SizedBox(width: Get.width * 0.03),
                                    Flexible(
                                      flex: 4,
                                      child: TextFormField(
                                        style: TextStyle(color: Colors.black),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                          CardMonthInputFormatter()
                                        ],
                                        decoration: InputDecoration(
                                          prefixIcon: SizedBox(
                                            height: 10,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 14),
                                              child: Image.asset(
                                                'assets/calender.png',
                                                width: 10,
                                                color: orangeColor,
                                              ),
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: orangeColor,
                                            ),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: orangeColor,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: orangeColor,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: orangeColor,
                                            ),
                                          ),
                                          hintText: 'MM/YY'.tr,
                                          hintStyle: TextStyle(color: Colors.black),
                                          labelStyle: TextStyle(color: Colors.grey),
                                          labelText: "Expiry Date".tr,
                                        ),
                                        validator: CardUtils.validateDate,
                                        keyboardType: TextInputType.number,
                                        onSaved: (value) {
                                          List<int> expiryDate = CardUtils.getExpiryDate(value!);
                                          _paymentCard.month = expiryDate[0];
                                          _paymentCard.year = expiryDate[1];
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: Get.height * 0.055),
                                Container(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: Get.width,
                                    child: CupertinoButton(
                                      onPressed: () {
                                        _validateInputs();
                                      },
                                      color: orangeColor,
                                      child: Text(
                                        "Pay".tr,
                                        style: TextStyle(fontSize: 17.0),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.065),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  void _validateInputs() {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      setState(() {
        _autoValidateMode = AutovalidateMode.always; // Start validating on every change.
      });
      showToastMessage("Please fix the errors in red before submitting.".tr);
    } else {
      var username = getData.read("UserLogin")["name"];
      var email = getData.read("UserLogin")["email"];
      _paymentCard.name = username;
      _paymentCard.email = email;
      _paymentCard.amount = currentTotalprice.toString();
      form.save();

      Get.to(() => StripePaymentWeb(paymentCard: _paymentCard))!.then((otid) {
        Get.back();
        //! order Api call
        if (otid != null) {
          //! Api Call Payment Success
          planpurchase.planpurchase();
        }
      });

      showToastMessage("Payment card is valid".tr);
    }
  }

  payplepayment({required Function onSuccess}) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return UsePaypal(
            sandboxMode: true,
            clientId: "Aa0Yim_XLAz89S4cqO-kT4pK3QbFsruHvEm8zDYX_Y-wIKgsGyv4TzL84dGgtWYUoJqTvKUh0JonIaKa",
            secretKey: "ECZEZmIjx0j_3_RStM7eT3Bc0Ehdd_yW4slqTnCtNI8WtVOVL1qwRh__u1W_8qKygnPDs0XaviNlb7-z",
            returnURL: "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=EC-35S7886705514393E",
            cancelURL: "https://dineout.zozostudio.tech/paypal/cancle.php",
            transactions: [
              {
                "amount": {
                  "total": plan2,
                  "currency": "USD",
                  "details": {"subtotal": plan2, "shipping": '0', "shipping_discount": 0}
                },
                "description": "The payment transaction description.",
                // "payment_options": {
                //   "allowed_payment_method":
                //       "INSTANT_FUNDING_SOURCE"
                // },
                "item_list": {
                  "items": [
                    {"name": "A demo product", "quantity": 1, "price": plan2, "currency": "USD"}
                  ],

                  // shipping address is not required though
                  "shipping_address": {
                    "recipient_name": "Jane Foster",
                    "line1": "Travis County",
                    "line2": "",
                    "city": "Austin",
                    "country_code": "US",
                    "postal_code": "73301",
                    "phone": "+00000000",
                    "state": "Texas"
                  },
                }
              }
            ],
            note: "Contact us for any questions on your order.",
            onSuccess: onSuccess,
            onError: (error) {
              print("onError: $error");
            },
            onCancel: (params) {
              print('cancelled: $params');
            });
      },
    ));
  }
}

Future tost(String text) {
  return Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM_LEFT,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.grey.shade300,
    textColor: Colors.black,
    fontSize: 16.0,
  );
}

// class Slide {
//   String image;

//   Slide(this.image);
// }
