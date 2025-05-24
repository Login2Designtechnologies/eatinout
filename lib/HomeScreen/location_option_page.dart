// import 'dart:convert';

// import 'package:dineout/Getx_Controller/Controller.dart';
// import 'package:dineout/HomeScreen/add_address_screen.dart';
// import 'package:dineout/Utils/Colors.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:uuid/uuid.dart';
// import 'package:http/http.dart' as http;

// class LocationOptionPage extends StatefulWidget {
//   LocationOptionPage({Key? key}) : super(key: key);

//   @override
//   State<LocationOptionPage> createState() => _LocationOptionPageState();
// }

// class _LocationOptionPageState extends State<LocationOptionPage> {
//   HomeController controller = Get.put(HomeController());

//   TextEditingController searchController = TextEditingController();

//   var uuid = const Uuid();

//   List<dynamic> listOfLocation = [];
//   String token = '1234567890';

//   @override
//   void initState() {
//     super.initState();
//     searchController.addListener(() {
//       _onChange();
//     });
//   }

//   _onChange() {
//     placeSuggestion(searchController.text);
//   }

//   void placeSuggestion(String input) async {
//     const String apiKey = "AIzaSyBhBx2dnF3XhS9t0P1QB-g4uFWBq8aHwK8";
//     try {
//       String BaseUrl =
//           "https://maps.googleapis.com/maps/api/place/autocomplete/json";

//       String request = "$BaseUrl?input=$input&key=$apiKey&sessiontoken=$token";

//       if (searchController.text.length < 3) return;

//       var response = await http.get(Uri.parse(request));
//       var data = jsonDecode(response.body);
//       if (kDebugMode) {
//         print('data is +++++++++++++++++++++++');
//         print(data);
//       }
//       if (response.statusCode == 200) {
//         setState(() {
//           listOfLocation = json.decode(response.body)['predictions'];
//         });
//       } else {
//         throw Exception("Failed to load");
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Navigator.pop(context); // Pop the current screen from the stack
//           },
//         ),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: Text(
//           "Enter your area or apartment name",
//           style: TextStyle(color: Colors.black, fontSize: 16),
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//               child: ListView(
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//             children: [
//               Column(
//                 children: [
//                   TextField(
//                     controller: searchController,
//                     onChanged: (v) {
//                       setState(() {});
//                     },
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.symmetric(
//                           vertical: 16.0, horizontal: 16.0),
//                       hintText: 'Search place...',
//                       prefixIcon: Icon(Icons.search),
//                       hintStyle: TextStyle(color: Colors.grey),
//                       filled: true,
//                       fillColor: Colors.white,
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey, width: 1.5),
//                         borderRadius: BorderRadius.circular(16.0),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey, width: 1.5),
//                         borderRadius: BorderRadius.circular(16.0),
//                       ),
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey, width: 1.5),
//                         borderRadius: BorderRadius.circular(16.0),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => AddAddressScreen()));
//                     },
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Image.asset(
//                           "assets/icon-target.png",
//                           color: orangeColor,
//                           width: 22,
//                         ),
//                         SizedBox(width: 8),
//                         Expanded(
//                             child: Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Use Current Location",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: orangeColor,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   // Text(
//                                   //   "${controller.userAddress}",
//                                   //   style: TextStyle(fontSize: 14),
//                                   // )
//                                 ],
//                               ),
//                             ),
//                             Icon(
//                               Icons.arrow_forward_ios_rounded,
//                               color: Colors.grey[500],
//                               size: 16,
//                             )
//                           ],
//                         ))
//                       ],
//                     ),
//                   ),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: listOfLocation.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         onTap: () {},
//                         title: Text(listOfLocation[index]['description']),
//                       );
//                     },
//                   )
//                 ],
//               )
//             ],
//           ))
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';

import 'package:dineout/Getx_Controller/Controller.dart';
import 'package:dineout/HomeScreen/add_address_screen.dart';
import 'package:dineout/Utils/Colors.dart';
import 'package:dineout/Utils/config.dart';
import 'package:dineout/Utils/dark_light_mode.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class LocationOptionPage extends StatefulWidget {
  LocationOptionPage({Key? key}) : super(key: key);

  @override
  State<LocationOptionPage> createState() => _LocationOptionPageState();
}

class _LocationOptionPageState extends State<LocationOptionPage> {
  HomeController controller = Get.put(HomeController());

  TextEditingController searchController = TextEditingController();

  var uuid = const Uuid();

  List<dynamic> listOfLocation = [];
  String token = '1234567890';
  late ColorNotifier notifier;

  // Debounce Timer
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    getDarkMode();
    searchController.addListener(() {
      _onChange();
    });
  }

  @override
  void dispose() {
    // Cancel debounce timer when the widget is disposed
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previousState = prefs.getBool("setIsDark");
    if (previousState == null) {
      notifier.setIsDark = false;
    } else {
      notifier.setIsDark = previousState;
    }
  }

  // Called on text change
  _onChange() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    // Start a new debounce timer
    _debounce = Timer(const Duration(seconds: 1), () {
      placeSuggestion(searchController.text);
    });
  }

  void placeSuggestion(String input) async {
    const String apiKey = Config.googlePlaceApiKey;
    try {
      String BaseUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json";

      String request = "$BaseUrl?input=$input&key=$apiKey&sessiontoken=$token";

      if (input.length < 3) return; // Don't search if input is less than 3 characters

      var response = await http.get(Uri.parse(request));
      var data = jsonDecode(response.body);
      if (kDebugMode) {
        print('data is +++++++++++++++++++++++');
        print(data);
      }
      if (response.statusCode == 200) {
        setState(() {
          listOfLocation = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception("Failed to load");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: notifier.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: notifier.textColor),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context); // Pop the current screen from the stack
          },
        ),
        elevation: 0,
        backgroundColor: notifier.background,
        title: Text(
          "Enter your area or apartment name",
          style: TextStyle(fontSize: 16, color: notifier.textColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: [
                  Column(
                    children: [
                      TextField(
                        controller: searchController,
                        onChanged: (v) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                          hintText: 'Search place...',
                          prefixIcon: Icon(Icons.search),
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.5),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.5),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.5),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => AddAddressScreen()));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(width: 8),
                            Image.asset(
                              "assets/icon-target.png",
                              color: orangeColor,
                              width: 22,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen()));
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Use Current Location",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: orangeColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "${controller.userAddress}",
                                              style: TextStyle(fontSize: 14, color: notifier.textColor),
                                            )
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Colors.grey[500],
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: listOfLocation.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              // controller.setUserAddress(
                              //     listOfLocation[index]['description']);
                              // Get.back();

                              print(listOfLocation[index]['place_id']);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MapScreen(
                                            placeId: listOfLocation[index]['place_id'],
                                          )));
                              // return;
                              // Get.to(AddAddressScreen());
                            },
                            title: Text(
                              listOfLocation[index]['description'],
                              style: TextStyle(color: notifier.textColor),
                            ),
                          );
                        },
                      )
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
