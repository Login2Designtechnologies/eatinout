import 'package:dineout/models/offer_model.dart';
import 'package:flutter/material.dart';

class OfferBox extends StatelessWidget {
  final OfferModel data;
  const OfferBox({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 13),
      height: 110,
      width: 170,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
            image: NetworkImage(
                // imageUrl,
                "https://admin.eatinout.in/${data.image}"
                // "https://images.pexels.com/photos/825661/pexels-photo-825661.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                ),
            fit: BoxFit.cover),
        color: const Color.fromARGB(255, 72, 68, 68),
      ),
      child: Container(
          padding: EdgeInsets.only(bottom: 8, left: 8),
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            // borderRadius: BorderRadius.only(
            //   topRight: Radius.circular(100),
            //   topLeft: Radius.circular(100),
            //   bottomLeft: Radius.circular(12),
            //   bottomRight: Radius.circular(12),
            // ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                data.dealTitle?.toUpperCase() ?? '',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              // SizedBox(
              //   height: 6,
              // ),
              // Text(
              //   data.description ?? '',
              //   style: TextStyle(color: Colors.white, fontSize: 14),
              // ),
              SizedBox(
                height: 6,
              ),
              Text(
                "${data.discount}% discount",
                style: TextStyle(color: Colors.amberAccent, fontSize: 14),
              ),
            ],
          )),
    );
  }
}
