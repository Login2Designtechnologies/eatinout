import 'package:dineout/Getx_Controller/Controller.dart';
import 'package:dineout/HomeScreen/HomePage.dart';
import 'package:dineout/Utils/Bottom_bar.dart';
import 'package:dineout/Utils/Colors.dart';
import 'package:dineout/Utils/Custom_widegt.dart';
import 'package:dineout/Utils/config.dart';
import 'package:dineout/Utils/dark_light_mode.dart';
import 'package:dineout/Utils/printf.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapScreen extends StatefulWidget {
  final String? placeId;

  MapScreen({this.placeId});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  LatLng _center = LatLng(0.0, 0.0); // Default value to avoid uninitialized error
  late Marker _marker;
  String _address = '';
  bool _isLoading = true; // Loading state to track when data is ready
  late ColorNotifier notifier;

  @override
  void initState() {
    super.initState();
    getDarkMode();
    // Initialize the marker with a default position.
    _marker = Marker(
      markerId: MarkerId("default_marker"),
      position: _center,
      infoWindow: InfoWindow(title: "Loading..."),
    );
    if (widget.placeId == null) {
      fillPlace();
    } else {
      _getPlaceDetails(widget.placeId!);
    }
    print('z z z' * 90);
  }

  fillPlace() {
    HomeController homeController = Get.find<HomeController>();
    setState(() {
      _address = homeController.address;
      _center = LatLng(homeController.lat, homeController.long);
      _marker = Marker(
        markerId: MarkerId("place_marker"),
        position: _center,
        infoWindow: InfoWindow(title: _address),
      );
      _isLoading = false; // Set loading to false once data is fetched
    });
  }

  // Fetch place details from Google API
  Future<void> _getPlaceDetails(String placeId) async {
    printf("t t t" * 090);

    final String apiKey = Config.googlePlaceApiKey; // Replace with your API key
    final String url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final result = data["result"];
        printf("*" * 90);
        printf(result);
        printf("*" * 90);

        if (result != null && result.containsKey("formatted_address")) {
          setState(() {
            _address = result["formatted_address"];
            final location = result["geometry"]["location"];
            _center = LatLng(location["lat"], location["lng"]);
            _marker = Marker(
              markerId: MarkerId("place_marker"),
              position: _center,
              infoWindow: InfoWindow(title: _address),
            );
            _isLoading = false; // Set loading to false once data is fetched
          });
        } else {
          throw Exception("Formatted address not found in response");
        }
      } else {
        throw Exception("Failed to load place details: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching place details: $error");
      setState(() {
        _isLoading = false; // Set loading to false if error occurs
      });
    }
  }

  // Fetch address based on latitude and longitude
  Future<void> _fetchAddressFromLatLng(LatLng latLng) async {
    print('object' * 90);
    final String apiKey = Config.googlePlaceApiKey; // Replace with your API key
    final String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data["results"];
        if (results.isNotEmpty) {
          setState(() {
            _address = results[0]["formatted_address"];
            print(results[0]);
            print('new address');
          });
        }
      } else {
        throw Exception("Failed to fetch address: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching address: $error");
    }
  }

  // This will be called when the user stops dragging the map
  void _onCameraIdle() async {
    // After the camera stops moving, fetch the address for the current center
    _fetchAddressFromLatLng(_center);

    setState(() {
      _marker = Marker(
        markerId: MarkerId("place_marker"),
        position: _center,
        infoWindow: InfoWindow(title: _address), // This will show the updated address
      );
    });
  }

  // This will be called when the user drags the map
  void _onCameraMove(CameraPosition position) {
    setState(() {
      _center = position.target;
      _marker = Marker(
        markerId: MarkerId("place_marker"),
        position: _center,
        infoWindow: InfoWindow(title: _address), // Update marker but don't fetch address yet
      );
    });
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

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        elevation: 0,
        backgroundColor: notifier.background,
        title: Text(
          "Select your location",
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Show a loading indicator
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                    mapController.moveCamera(CameraUpdate.newLatLng(_center));
                  },
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 15.0,
                  ),
                  markers: {_marker},
                  onCameraMove: _onCameraMove, // Update marker position while moving
                  onCameraIdle: _onCameraIdle, // Fetch the address when dragging stops
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: notifier.background,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: orangeColor),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                _address,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: notifier.textColor,
                                ),
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        AppButton(
                          buttonColor: orangeColor,
                          buttontext: "Confirm Location",
                          onTap: () async {
                            // Get.to(() => const HomePage());
                            HomeController homeController = Get.find<HomeController>();
                            homeController.setUserAddress(_address);
                            homeController.lat = _center.latitude;
                            homeController.long = _center.longitude;
                            homeController.fetchAllData();
                            Get.to(() => BottomBar());

                            // Navigator.of(context).pushAndRemoveUntil(
                            //   MaterialPageRoute(
                            //     builder: (context) => HomePage(),
                            //   ),
                            //   (Route<dynamic> route) => false,
                            // );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 20,
                  right: 20,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2, offset: Offset(1, 1), spreadRadius: 1, color: const Color.fromARGB(255, 166, 166, 166).withOpacity(.3))
                      ],
                    ),
                    child: TextField(
                      onTap: () {
                        Get.back();
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                        hintText: 'Search place...',
                        prefixIcon: Icon(Icons.search),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
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
                  ),
                )
              ],
            ),
    );
  }
}
