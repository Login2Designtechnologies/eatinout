import 'package:dineout/HomeScreen/deals_page.dart';
import 'package:dineout/HomeScreen/offers_page.dart';
import 'package:dineout/Utils/dark_light_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryMenu extends StatelessWidget {
  CategoryMenu({Key? key}) : super(key: key);
  late ColorNotifier notifier;
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    var size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: size.width,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: cats
              .map((e) => GestureDetector(
                    onTap: () {
                      if (e == "Offers") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OffersPage()));
                      } else if (e == "Deals") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DealsPage()));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      margin: EdgeInsets.only(right: 8),
                      // width: 100,
                      child: Text(
                        e,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: notifier.textColor,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

List<String> cats = [
  "Offers",
  "Near & Top Rated",
  "Deals",
  // "Rating 4.5+",
  "Veg Only",
  "Best Deals",
  " Party Packs",
];
