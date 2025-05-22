import 'package:dineout/HomeScreen/Hotel_Details.dart';
import 'package:dineout/HomeScreen/deals_hotal_list.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:dineout/models/delas_category_model.dart';
import 'package:dineout/models/restaurant_short_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MustTryItem extends StatelessWidget {
  final DealsCategoryModel data;
  final String imageUrl;
  final String title;
  const MustTryItem(
      {Key? key,
      this.imageUrl = "",
      this.title = 'change this',
      required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        // selectedbox = true;
        print(data.id);
        Get.to(() => DealsHotalList(id: data.id.toString()));
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(right: 16),
        height: size.height * .2,
        width: size.width * .38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(100),
            topLeft: Radius.circular(100),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          image: DecorationImage(
              image: NetworkImage(
                  // imageUrl,
                  "https://placehold.co/600x400/png"
                  // "https://images.pexels.com/photos/825661/pexels-photo-825661.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                  ),
              fit: BoxFit.cover),
          color: const Color.fromARGB(255, 72, 68, 68),
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: 8),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(100),
              topLeft: Radius.circular(100),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
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
            data.categoryName ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
