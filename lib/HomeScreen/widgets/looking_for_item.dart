import 'package:dineout/HomeScreen/Nearby_hotel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LookingForItem extends StatelessWidget {
  final String imageUrl;
  final String title;

  const LookingForItem(
      {Key? key,
      this.title = "change this",
      this.imageUrl =
          "https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.to(Nearbyhotel(
          pageTitle: title,
        ));
      },
      child: Container(
        margin: EdgeInsets.all(4),
        height: 130,
        width: size.width * .28,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                imageUrl,
                // "https://images.pexels.com/photos/825661/pexels-photo-825661.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              ),
              fit: BoxFit.cover),
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: 8, left: 8, right: 8),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.grey.withOpacity(0.0),
                Colors.black,
              ],
              stops: [0.0, 1.0],
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
