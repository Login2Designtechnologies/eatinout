// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, avoid_print, must_be_immutable, prefer_interpolation_to_compose_strings, unnecessary_new, unused_element, use_build_context_synchronously, avoid_types_as_parameter_names, sort_child_properties_last, deprecated_member_use

import 'dart:convert';
import 'package:dineout/Getx_Controller/bottom_bar_controller.dart';
import 'package:dineout/Utils/printf.dart';
import 'package:provider/provider.dart';
import 'package:dineout/Getx_Controller/Delete_controller.dart';
import 'package:dineout/HomeScreen/View_details.dart';
import 'package:dineout/Utils/dark_light_mode.dart';
import 'package:dineout/LoginFlow/Login_In.dart';
import 'package:dineout/Profile/FAQ.dart';
import 'package:dineout/Profile/My_Account.dart';
import 'package:dineout/Profile/Table_Booking_TabBar.dart';
import 'package:dineout/Utils/Colors.dart';
import 'package:dineout/Utils/Custom_widegt.dart';
import 'package:dineout/api/Api_werper.dart';
import 'package:dineout/api/Data_save.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:dineout/api/terms_condition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Getx_Controller/Membership_controller.dart';

class Profile extends StatefulWidget {
  String? people;
  String? title;
  String? bookingdate;
  String? time;
  String? discount;
  String? discountamount;
  Profile({this.people, this.title, this.bookingdate, this.time, this.discount, this.discountamount, super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  TextEditingController Name = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController password = TextEditingController();
  MembershipController membership = Get.put(MembershipController());
  DeleteAccountController deleteaccount = Get.put(DeleteAccountController());
  BottomBarController bottomBarController = Get.put(BottomBarController());
  String edprofile = "";

  @override
  void initState() {
    getDarkMode();
    super.initState();
    getData.read("UserLogin") != null
        ? setState(() {
            Name.text = getData.read("UserLogin")["name"] ?? "";
            Email.text = getData.read("UserLogin")["email"] ?? "";
            password.text = getData.read("UserLogin")["password"] ?? "";
          })
        : null;
    getWebData();
    membership.membership();
  }

  int selectedIndex1 = 0;
  List<DynamicPageData> dynamicPageDataList = [];
  String? text;
  bool isLodding = false;
  bool darkMode = false;
  late ColorNotifier notifier;

  getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previousState = prefs.getBool("setIsDark");
    if (previousState == null) {
      notifier.setIsDark = false;
    } else {
      notifier.setIsDark = previousState;
      darkMode = previousState;
    }
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   notifier.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    darkMode = notifier.isDark;

    return WillPopScope(
      onWillPop: () {
        // if (selectedIndex == 3) {
        if (bottomBarController.selectedIndex == 3) {
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        backgroundColor: notifier.background,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              color: notifier.background,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.03),
                    InkWell(
                      onTap: () {
                        printf('tabbed');
                        printf('tabbed');
                        printf('tabbed');
                        printf('tabbed');
                        Get.back();
                      },
                      // child: selectedIndex == 3
                      child: bottomBarController.selectedIndex == 3
                          ? SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Image.asset("assets/arrowleft.png", height: 20, color: notifier.textColor),
                              ],
                            ),
                    ),
                    SizedBox(height: Get.height * 0.015),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(getData.read("UserLogin")["name"],
                              style: TextStyle(fontFamily: "Gilroy Bold", color: notifier.textColor, fontSize: 16)),
                        ),
                        InkWell(
                          onTap: bottomsheet,
                          child: Text("edit".tr.toUpperCase(), style: TextStyle(fontFamily: "Gilroy Bold", color: notifier.textColor, fontSize: 16)),
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    // SizedBox(height: Get.height * 0.015),
                    Builder(builder: (context) {
                      String userDetails =
                          '${getData.read("UserLogin")["ccode"]} ${getData.read("UserLogin")["mobile"]} ${getData.read("UserLogin")["email"]}';
                      return SizedBox(
                        width: Get.width * 0.94,
                        child: Row(
                          children: [
                            // Text(getData.read("UserLogin")["ccode"],
                            Expanded(
                              child: Text(userDetails, style: TextStyle(fontFamily: "Gilroy Medium", color: greycolor, fontSize: 14)),
                            ),
                            // SizedBox(width: Get.width * 0.02),
                            // Text(getData.read("UserLogin")["mobile"],
                            //     style: TextStyle(
                            //         fontFamily: "Gilroy Medium",
                            //         color: greycolor,
                            //         fontSize: 16)),
                            // SizedBox(width: Get.width * 0.005),
                            // Text(".",
                            //     style: TextStyle(
                            //         fontFamily: "Gilroy Medium",
                            //         color: greycolor,
                            //         fontSize: 16)),
                            // SizedBox(width: Get.width * 0.015),
                            // Text(getData.read("UserLogin")["email"],
                            //     style: TextStyle(
                            //         fontFamily: "Gilroy Medium",
                            //         color: greycolor,
                            //         fontSize: 16))
                          ],
                        ),
                      );
                    }),
                    membership.member["is_subscribe"] == 1
                        ? InkWell(
                            onTap: () {
                              Get.to(() => ViewDetails(
                                    discount: widget.discount,
                                    discountamt: widget.discountamount,
                                  ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: Get.height * 0.01),
                                    Divider(color: notifier.textColor),
                                    Row(
                                      children: [
                                        Text("Gold".tr, style: TextStyle(fontFamily: "Gilroy ExtraBold", color: goldColor, fontSize: 18)),
                                        SizedBox(width: Get.width * 0.01),
                                        Text("Membership".tr, style: TextStyle(fontFamily: "Gilroy Medium", color: notifier.textColor, fontSize: 16)),
                                        SizedBox(width: Get.width * 0.015),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                          width: 70,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.topRight,
                                              stops: [0.1, 0.3, 1],
                                              colors: <Color>[orangeColor, orangeColor, Colors.red],
                                            ),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Text("Active".tr, style: TextStyle(fontFamily: "Gilroy Bold", color: WhiteColor, fontSize: 16)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    GetBuilder<MembershipController>(builder: (context) {
                                      return SizedBox(
                                        width: Get.width * 0.84,
                                        child: Text(
                                            "${membership.member["membersip_title"]} for ${membership.member["valid_till"]} Explore More Benefits",
                                            style: TextStyle(fontFamily: "Gilroy Medium", color: greycolor, fontSize: 14)),
                                      );
                                    }),
                                    SizedBox(height: Get.height * 0.02),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Account(
                          onTap: () {
                            Get.to(() => TableBooking(
                                  noofpeople: widget.people,
                                  bookingdate: widget.bookingdate,
                                  time: widget.time,
                                ));
                            print("#############################${widget.title}");
                          },
                          icon: Icons.keyboard_arrow_right,
                          titletext: "Table Reservations".tr,
                          subtitletext: "Booking Details information".tr),
                      SizedBox(height: Get.height * 0.01),
                      Divider(color: greycolor),
                      SizedBox(height: Get.height * 0.01),
                      Account(
                          onTap: () {
                            print("#############################${widget.title}");
                            Get.to(() => MyAccount(
                                  hotelname: widget.title,
                                  booktime: widget.time,
                                  bookdate: widget.bookingdate,
                                ));
                          },
                          icon: Icons.keyboard_arrow_right,
                          titletext: "Bill Payment History".tr,
                          subtitletext: "Bill details".tr),
                      Divider(color: greycolor),
                      SizedBox(height: Get.height * 0.01),
                      // Account(
                      //     onTap: () {
                      //       print(
                      //           "#############################${widget.title}");
                      //       Get.to(() => LanguageScreen());
                      //     },
                      //     icon: Icons.keyboard_arrow_right,
                      //     titletext: "Language".tr,
                      //     subtitletext: "Select Language"),
                      // Divider(color: greycolor),
                      // SizedBox(height: Get.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Dark Mode".tr, style: TextStyle(fontFamily: "Gilroy Bold", color: notifier.textColor, fontSize: 18)),
                              SizedBox(height: Get.height * 0.007),
                              Text("Change Theme".tr, style: TextStyle(fontFamily: "Gilroy Medium", color: greycolor, fontSize: 14)),
                            ],
                          ),
                          Transform.scale(
                            scale: 0.7,
                            child: Transform.translate(
                              offset: const Offset(4, 0),
                              child: CupertinoSwitch(
                                trackColor: GreyColor,
                                activeColor: orangeColor,
                                thumbColor: Colors.white,
                                value: darkMode,
                                onChanged: (bool value) async {
                                  setState(() {
                                    darkMode = value;
                                  });
                                  final prefs = await SharedPreferences.getInstance();
                                  setState(
                                    () {
                                      notifier.setIsDark = value;
                                      prefs.setBool("setIsDark", value);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(height: Get.height * 0.01),
                          Divider(color: greycolor),
                          SizedBox(height: Get.height * 0.01),
                        ],
                      ),
                      Account(
                          onTap: () {
                            Get.to(() => faqsandhelp());
                          },
                          icon: Icons.keyboard_arrow_right,
                          titletext: "Help".tr,
                          subtitletext: "FAQ's & Links".tr),
                      SizedBox(height: Get.height * 0.01),
                      Divider(color: greycolor),
                      SizedBox(height: Get.height * 0.01),
                      // ListView.builder(
                      //   itemCount: dynamicPageDataList.length,
                      //   shrinkWrap: true,
                      //   itemExtent: 60,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   padding: EdgeInsets.zero,
                      //   itemBuilder: (context, index) {
                      //     return Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         GestureDetector(
                      //           onTap: () {
                      //             Get.to(() =>
                      //                 Loream(dynamicPageDataList[index].title));
                      //           },
                      //           child: Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text(
                      //                       "${dynamicPageDataList[index].title}",
                      //                       style: TextStyle(
                      //                           fontFamily: "Gilroy Bold",
                      //                           color: notifier.textColor,
                      //                           fontSize: 18)),
                      //                   SizedBox(height: Get.height * 0.007),
                      //                 ],
                      //               ),
                      //               Icon(Icons.keyboard_arrow_right,
                      //                   color: greycolor, size: 27)
                      //             ],
                      //           ),
                      //         ),
                      //         Divider(color: greycolor),
                      //       ],
                      //     );
                      //   },
                      // ),
                      GetBuilder<DeleteAccountController>(builder: (BuildContext) {
                        return Account(
                            onTap: () async {
                              setState(() {
                                // getData.remove('Firstuser');
                                // getData.remove('Remember');
                                // getData.remove("UserLogin");
                                deleteSheet();
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => LoginPage()));
                              });
                            },
                            icon: Icons.keyboard_arrow_right,
                            titletext: "Delete Account".tr,
                            subtitletext: "The option to delete the account".tr);
                      }),
                      SizedBox(height: Get.height * 0.01),
                      Divider(color: greycolor),
                      SizedBox(height: Get.height * 0.01),
                      GetBuilder<MembershipController>(builder: (BuildContext) {
                        return Account(
                            onTap: () async {
                              getData.remove('Firstuser');
                              getData.remove('Remember');
                              getData.remove("UserLogin");
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                            },
                            icon: Icons.keyboard_arrow_right,
                            titletext: "Logout".tr,
                            subtitletext: "Sign Out From Device".tr);
                      }),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Account({IconData? icon, String? titletext, subtitletext, Function()? onTap}) {
    return InkWell(
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titletext!, style: TextStyle(fontFamily: "Gilroy Bold", color: notifier.textColor, fontSize: 18)),
              SizedBox(height: Get.height * 0.007),
              SizedBox(
                width: Get.width * 0.85,
                child: Text(subtitletext, style: TextStyle(fontFamily: "Gilroy Medium", color: greycolor, fontSize: 14)),
              ),
            ],
          ),
          Icon(icon, color: greycolor, size: 27)
        ],
      ),
    );
  }

  bottomsheet() {
    return showModalBottomSheet(
        backgroundColor: notifier.containerColor,
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return Container(
                height: 380,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Scaffold(
                  backgroundColor: notifier.containerColor,
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
                  floatingActionButton: Container(
                      transform: Matrix4.translationValues(0.0, -80, 0.0), // translate up by 30
                      child: FloatingActionButton(
                        backgroundColor: notifier.textColor.withOpacity(0.5),
                        onPressed: () {
                          Get.back();
                        },
                        child: Icon(Icons.close),
                      )),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: Get.height * 0.01),
                        Text("Edit Profile".tr, style: TextStyle(fontFamily: "Gilroy Bold", color: notifier.textColor, fontSize: 16)),
                        SizedBox(height: Get.height * 0.02),
                        SizedBox(height: Get.height * 0.01),
                        passwordtextfield(controller: Name, color: notifier.textColor, obscureText: false, lebaltext: "Full Name".tr),
                        SizedBox(height: Get.height * 0.03),
                        passwordtextfield(controller: Email, obscureText: false, color: notifier.textColor, lebaltext: "Email Address".tr),
                        SizedBox(height: Get.height * 0.02),
                        passwordtextfield(controller: password, obscureText: false, color: notifier.textColor, lebaltext: "Password".tr),
                        SizedBox(height: Get.height * 0.02),
                        AppButton(
                          buttonColor: gradientColor,
                          buttontext: "Update Profile".tr,
                          onTap: () {
                            Editprofile(Name.text, password.text, Email.text);
                          },
                        )
                      ],
                    ),
                  ),
                ));
          });
        });
  }

  Editprofile(String name, String password, String email) async {
    try {
      Map map = {"name": name, "password": password, "email": email, "uid": getData.read("UserLogin")["id"]};
      Uri uri = Uri.parse(AppUrl.editprofile);
      var response = await http.post(uri, body: jsonEncode(map));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        edprofile = result["Result"];
        save("Firstuser", true);
        setState(() {
          save("UserLogin", result["UserLogin"]);
        });
        print("*********************${edprofile}");

        if (edprofile == "true") {
          Get.back();
          ApiWrapper.showToastMessage(result["ResponseMsg"]);
        } else {
          ApiWrapper.showToastMessage(result["ResponseMsg"]);
        }
      }
      // update();
    } catch (e) {
      print(e.toString());
    }
  }

  void getWebData() {
    Map<String, dynamic> data = {};

    dynamicPageDataList.clear();
    ApiWrapper.dataPost(AppUrl.pagelist, data).then((value) {
      if ((value != null) && (value.isNotEmpty) && (value['ResponseCode'] == "200")) {
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
        print("jwgqdskdjchsjdilcuhsilcjsailkfhcjilsjfcsilkjfchidshfcid" + dynamicPageDataList.length.toString());
        setState(() {
          isLodding = true;
        });
      }
    });
  }

  Future deleteSheet() {
    return Get.bottomSheet(
      Container(
        height: 220,
        width: Get.size.width,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Delete Account".tr,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Gilroy Bold",
                color: orangeColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Divider(
                color: greycolor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Are you sure you want to delete account?".tr,
              style: TextStyle(
                fontFamily: "Gilroy Medium",
                fontSize: 16,
                color: notifier.textColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text(
                        "Cancel".tr,
                        style: TextStyle(
                          color: notifier.background,
                          fontFamily: "Gilroy Bold",
                          fontSize: 16,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: notifier.textColor,
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      deleteaccount.deleteAccount();
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text(
                        "Yes, Remove".tr,
                        style: TextStyle(
                          color: WhiteColor,
                          fontFamily: "Gilroy Bold",
                          fontSize: 16,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: orangeColor,
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
          color: notifier.containerColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
