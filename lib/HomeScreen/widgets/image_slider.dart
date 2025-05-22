// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dineout/api/confrigation.dart';
// import 'package:flutter/material.dart';

// class ImageSlider extends StatelessWidget {
//   const ImageSlider({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Container(
//       // height: Get.height * 0.4,
//       width: double.infinity,
//       child: CarouselSlider.builder(
//         options: CarouselOptions(
//           autoPlay: true,
//           // aspectRatio: 2.0,
//           // height: Get.height * 0.4,
//           enlargeCenterPage: true,
//           height: 200,
//           aspectRatio: 16 / 9,
//           viewportFraction: 1,
//         ),
//         // itemCount: hData.sliderimage.length,
//         itemCount: 1,
//         itemBuilder: (BuildContext context, int index, int realIndex) {
//           return Container(
//             // margin: EdgeInsets.only(left: 6, right: 6),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(15),
//               child: hData.sliderimage.isEmpty
//                   ? Center(
//                       child: CircularProgressIndicator(color: Colors.white))
//                   : FadeInImage.assetNetwork(
//                       fadeInCurve: Curves.easeInCirc,
//                       placeholder: "assets/ezgif.com-crop.gif",
//                       // height: Get.height * 0.4,
//                       width: size.width,
//                       imageErrorBuilder: (context, error, stackTrace) {
//                         return Image.asset("assets/ezgif.com-crop.gif");
//                       },
//                       placeholderCacheHeight: 320,
//                       placeholderCacheWidth: 240,
//                       placeholderFit: BoxFit.fill,
//                       // placeholderScale: 1.0,
//                       image: AppUrl.imageurl + hData.sliderimage[index]["img"],

//                       // "${AppUrl.imageurl} + ${home_controller.homeDatakmodal?.homeData.bannerlist}",
//                       fit: BoxFit.cover,
//                     ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
