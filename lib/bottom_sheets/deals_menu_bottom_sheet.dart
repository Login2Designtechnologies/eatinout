import 'package:dineout/Getx_Controller/Controller.dart';
import 'package:dineout/models/deal_model.dart';
import 'package:dineout/models/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class DealsMenuBottomSheet extends StatelessWidget {
  DealModel data;
  bool loading;
  List<MenuModel> list;
  DealsMenuBottomSheet(
      {required this.list, required this.loading, required this.data});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (
      controller,
    ) {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with logo and close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo and company name
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: AssetImage('assets/l-icon.jpeg'))),
                      // child: Center(
                      //   child: Text(
                      //     'LOGO',
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 10,
                      //     ),
                      // ),
                      // ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Included Items',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        // Text(
                        //   'Special Offers',
                        //   style: TextStyle(
                        //     color: Colors.grey,
                        //     fontSize: 12,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
                // Close button
                IconButton(
                  icon: Icon(Icons.close, size: 24),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 16),
            // List of deals

            // controller.loading
            //     ? Center(child: CircularProgressIndicator())

            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                // itemCount: controller.menuModelList.length,
                itemCount: data.menu?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Icon(Icons.local_offer, color: Colors.orange, size: 20),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            data.menu![index],
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            // Action button
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       padding: EdgeInsets.symmetric(vertical: 16),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     child: Text('View All Deals'),
            //     onPressed: () {
            //       // Handle view all action
            //     },
            //   ),
            // ),
          ],
        ),
      );
    });
  }
}
