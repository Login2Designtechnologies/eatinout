import 'package:dineout/Getx_Controller/Controller.dart';
// import 'package:dineout/HomeScreen/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationControlleraf extends GetxController {
  var first; // First-time location flag
  var address;
  var lat;
  var long;
  var isLocationSet = false.obs; // Flag to check if location is manually set
  HomeController hData = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
    // Call getUserLocation when the controller is initialized
    getUserLocation();
  }

  // Function to get current user location (only for the first time)
  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // Function to get user's location only the first time
  Future getUserLocation() async {
    print("*" * 100);
    print('Getting user location for the first time in getUserLocation');

    // Request permission
    LocationPermission permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle denied permission
      return;
    }

    // Get current location using Geolocator
    var currentLocation = await locateUser();
    debugPrint('Location: ${currentLocation.latitude}');
    lat = currentLocation.latitude;
    long = currentLocation.longitude;

    // Fetch the address from coordinates
    List<Placemark> addresses = await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);
    await placemarkFromCoordinates(
            currentLocation.latitude, currentLocation.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      address =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      hData.setUserAddress(address);
    }).catchError((e) {
      debugPrint(e);
    });

    // Mark that location is set
    isLocationSet.value = true; // Location is set after the first fetch

    // Set the first address (used for debugging or other purposes)
    first = addresses.first.name;
    print("FIRST ${address}");

    // Fetch additional data
    hData.homeDataApi();
    hData.selectplan();
    hData.getOffers();
    hData.getDeals();
  }

  // Function to handle location update when the user manually changes it
  Future updateUserLocation(double newLat, double newLong) async {
    // Update the latitude and longitude manually
    lat = newLat;
    long = newLong;

    // Get the new address based on the new location
    List<Placemark> addresses = await placemarkFromCoordinates(newLat, newLong);
    await placemarkFromCoordinates(newLat, newLong)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      address =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      hData.setUserAddress(address);
    }).catchError((e) {
      debugPrint(e);
    });

    // Fetch data again after the user manually updates location
    hData.homeDataApi();
    hData.selectplan();
    hData.getOffers();
    hData.getDeals();
  }
}
