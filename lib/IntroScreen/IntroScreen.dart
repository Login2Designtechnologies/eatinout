// ignore_for_file: camel_case_types, use_key_in_widget_constructors, annotate_overrides, prefer_const_literals_to_create_immutables, file_names, unused_field, unused_element, avoid_unnecessary_containers, non_constant_identifier_names, unused_import, deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:dineout/Getx_Controller/auth_controller.dart';
import 'package:dineout/HomeScreen/HomePage.dart';
import 'package:dineout/LoginFlow/Login_In.dart';
import 'package:dineout/Utils/Bottom_bar.dart';
import 'package:dineout/Utils/Colors.dart';
import 'package:dineout/Utils/db.dart';
import 'package:dineout/Utils/printf.dart';
import 'package:dineout/api/Data_save.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Getx_Controller/Controller.dart';
import '../Utils/dark_light_mode.dart';

// String long = "", lat = "";
bool Membership = false;

class onbording extends StatefulWidget {
  // ignore: use_super_parameters
  const onbording({Key? key}) : super(key: key);

  @override
  State<onbording> createState() => _onbordingState();
}

class _onbordingState extends State<onbording> {
  AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    // getCurrentLatAndLong();
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      String? password = '';
      String? userPhoneNumber = '';
      String? countryCode = '';
      // String? num = await getPhoneNumber() ?? '';
      // // print(num);

      password = await getUserPassword() ?? '';
      userPhoneNumber = await getPhoneNumber() ?? '';
      countryCode = await getCountryCode() ?? '';
      // print('passcode is  $passcode');
      // print('your passcode is ');
      if (password == '' || userPhoneNumber == '' || countryCode == "") {
        Get.offAll(BoardingPage(), transition: Transition.fadeIn);
      } else {
        print('now user can login');
        authController.login();
        // Get.offAll(LoginPage(), transition: Transition.fadeIn);
      }
    }
        // () => getData.read("Firstuser") != true
        //     ? Get.to(() => BoardingPage())
        //     : getData.read("Remember") != true
        //         ? Get.to(() => const LoginPage())
        //         : Get.to(() => BottomBar()),
        );
  }

  HomeController hData = Get.put(HomeController());
  gethome() {
    hData.homeDataApi().then(
      (value) {
        Get.offAll(() => BottomBar());
      },
    );
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BlackColor,
        body: Center(child: Image.asset("assets/l-icon.jpeg", height: 150)));
  }
}

class BoardingPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingPage> {
  // creating all the widget before making our home screeen

  void initState() {
    super.initState();

    _currentPage = 0;

    _slides = [
      Slide("assets/intro1.png", "Discover a world of opportunity",
          "10,000+ top resturant"),
      Slide("assets/intro3.png", "Reserve a table for dine-in",
          "Gain access to special rates and exclusive experiance"),
      Slide("assets/intro2.png", "Make traveling very easy",
          "Book, check in and make request from anywhere"),
      Slide("assets/intro4.png", "Never miss out on deals",
          "Book, check in and make request from anywhere"),
      Slide("assets/intro5.png", "Unlock full member experience",
          "Book, check in and make request from anywhere"),
    ];
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  int _currentPage = 0;
  List<Slide> _slides = [];
  PageController _pageController = PageController();

  // the list which contain the build slides
  List<Widget> _buildSlides() {
    return _slides.map(_buildSlide).toList();
  }

  Widget _buildSlide(Slide slide) {
    return Scaffold(
        backgroundColor: transparent,
        body: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topRight,
              children: [
                InkWell(
                  onTap: () {
                    _pageController.nextPage(
                        duration: const Duration(microseconds: 300),
                        curve: Curves.easeIn);
                  },
                  child: Image.asset(
                    slide.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: Get.height,
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 14,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width * 0.80,
                        child: Text(
                          slide.heading,
                          style: TextStyle(
                              fontSize: 30,
                              color: WhiteColor,
                              fontFamily: "Gilroy Bold"),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      SizedBox(
                        width: Get.width * 0.80,
                        child: Text(
                          slide.subtext,
                          style: TextStyle(
                              fontSize: 20,
                              color: WhiteColor,
                              fontFamily: "Gilroy Medium"),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }

  // handling the on page changed
  void _handlingOnPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  // building page indicator
  Widget _buildPageIndicator() {
    Row row = Row(mainAxisAlignment: MainAxisAlignment.center, children: []);
    for (int i = 0; i < _slides.length; i++) {
      row.children.add(_buildPageIndicatorItem(i));
      if (i != _slides.length - 1)
        // ignore: curly_braces_in_flow_control_structures
        row.children.add(const SizedBox(
          width: 6,
        ));
    }
    return row;
  }

  Widget _buildPageIndicatorItem(int index) {
    return Container(
      width: index == _currentPage ? 25 : 25,
      height: index == _currentPage ? 6 : 6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color:
              index == _currentPage ? WhiteColor : greycolor.withOpacity(0.5)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: transparent,
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: _handlingOnPageChanged,
              children: _buildSlides(),
            ),
            Positioned(
              top: 45,
              left: 12,
              child: InkWell(
                onTap: () {
                  Get.to(() => const LoginPage());
                },
                child: Container(
                  height: 30,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: orangeColor),
                  child: Center(
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          color: WhiteColor,
                          fontFamily: "Gilroy Bold",
                          fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(top: 55, right: 12, child: _buildPageIndicator()),
            SizedBox(height: Get.height * 0.9),
            Positioned(
              bottom: 30,
              child: InkWell(
                  onTap: () {
                    _pageController.nextPage(
                        duration: const Duration(microseconds: 300),
                        curve: Curves.easeIn);
                  },
                  child: _currentPage == 4
                      ? InkWell(
                          onTap: () {
                            Get.to(() => const LoginPage());
                          },
                          child: Container(
                            height: 50,
                            width: Get.width * 0.95,
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: boxcolor),
                            child: Center(
                                child: Text(
                              "Started",
                              style: TextStyle(
                                  color: WhiteColor,
                                  fontFamily: "Gilroy Bold",
                                  fontSize: 15),
                            )),
                          ),
                        )
                      : Container(
                          height: 50,
                          width: Get.width * 0.95,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: boxcolor),
                          child: Center(
                              child: Text(
                            "Get Started",
                            style: TextStyle(
                                color: WhiteColor,
                                fontFamily: "Gilroy Bold",
                                fontSize: 15),
                          )),
                        )),
            )
          ],
        ));
  }
}

class Slide {
  String image;
  String heading;
  String subtext;

  Slide(this.image, this.heading, this.subtext);
}
