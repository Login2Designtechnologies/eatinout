import 'package:dineout/Getx_Controller/Controller.dart';
import 'package:dineout/Getx_Controller/Near_By_controller.dart';
import 'package:dineout/HomeScreen/widgets/restaurant_card.dart';
import 'package:dineout/Search/widgets/search_field.dart';
import 'package:dineout/Utils/Colors.dart';
import 'package:dineout/Utils/Custom_widegt.dart';
import 'package:dineout/Utils/dark_light_mode.dart';
import 'package:dineout/Utils/printf.dart';
import 'package:dineout/models/restaurant_short_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// bool selectedbox = false;

class SearchScreen extends StatefulWidget {
  final String pageTitle;
  const SearchScreen(
      {super.key, this.pageTitle = "Popular Restaurant around you"});
  // {super.key, this.pageTitle = "Popular Restaurant around you"});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  HomeController homeController = Get.put(HomeController());
  TextEditingController _searchController = TextEditingController();
  List<RestaurantShortDetailModel> filteredRestaurantList = [];
  @override
  void initState() {
    filteredRestaurantList = homeController.allRestaurantList;
    getDarkMode();
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      // Filter the list based on search input
      filteredRestaurantList = homeController.allRestaurantList
          .where((e) => e.title!
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
    printf('filtered result length is:::::');
    printf(filteredRestaurantList.length);
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
    var size = MediaQuery.of(context).size;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.background,
      body: SafeArea(
        child: GetBuilder<HomeController>(builder: (context) {
          return homeController.isLoading
              ? homeController.allRestaurantList.isNotEmpty
                  ? Column(
                      children: [
                        SizedBox(height: 12),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 50,
                          width: size.width,
                          // color: Colors.amber,
                          child: Row(
                            children: [
                              Expanded(
                                child: SearchField(
                                  controller: _searchController,
                                  showBackButton: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: filteredRestaurantList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return RestaurantCard(
                                    data: filteredRestaurantList[index]);
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.35),
                      child: Center(
                        child: Text(
                          "We do not currently have any restaurants Popular."
                              .tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: greycolor,
                              fontFamily: "Gilroy Bold",
                              fontSize: 16),
                        ),
                      ),
                    )
              : Center(
                  child: Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.4),
                  child: CircularProgressIndi(),
                ));
        }),
      ),
    );
  }
}
