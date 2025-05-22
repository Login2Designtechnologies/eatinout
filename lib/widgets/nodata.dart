import 'package:dineout/Utils/Colors.dart';
import 'package:flutter/material.dart';

class Nodata extends StatelessWidget {
  final String text;
  const Nodata({Key? key, this.text = "change this"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        // textAlign: TextAlign.center,
        style: TextStyle(
            color: greycolor, fontFamily: "Gilroy Bold", fontSize: 14),
      ),
    );
  }
}
