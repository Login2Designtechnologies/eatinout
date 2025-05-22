import 'package:dineout/HomeScreen/widgets/looking_for_item.dart';
import 'package:flutter/material.dart';

class LookingForList extends StatelessWidget {
  const LookingForList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      // color: Colors.pink,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          LookingForItem(
            title: "Cafes",
            imageUrl:
                "https://images.pexels.com/photos/842571/pexels-photo-842571.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          ),
          LookingForItem(
            title: "Nightlife",
            imageUrl:
                "https://images.pexels.com/photos/1640772/pexels-photo-1640772.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          ),
          LookingForItem(
            title: "Premium dining",
            imageUrl:
                "https://images.pexels.com/photos/825661/pexels-photo-825661.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          ),
          LookingForItem(
            title: "Family dining",
            imageUrl:
                "https://images.pexels.com/photos/1640774/pexels-photo-1640774.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1 ",
          ),
          LookingForItem(
            title: "Street food",
            imageUrl:
                "https://images.pexels.com/photos/6217958/pexels-photo-6217958.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          ),
          LookingForItem(
            title: "Casual dining",
          ),
        ],
      ),
    );
  }
}
