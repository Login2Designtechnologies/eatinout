import 'package:dineout/Utils/Colors.dart';
import 'package:dineout/Utils/Custom_widegt.dart';
import 'package:dineout/Utils/dark_light_mode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookTablePage extends StatefulWidget {
  final int guestsSelcted;
  const BookTablePage({Key? key, required this.guestsSelcted}) : super(key: key);

  @override
  State<BookTablePage> createState() => _BookTablePageState();
}

class _BookTablePageState extends State<BookTablePage> {
  int guests = 1;
  int selectedDateIndex = 0;
  bool isLunchSelected = true;

  final List<Map<String, String>> dates = [
    {'day': '24', 'weekday': 'Sat'},
    {'day': '25', 'weekday': 'Sun'},
    {'day': '26', 'weekday': 'Mon'},
    {'day': '27', 'weekday': 'Tue'},
    {'day': '28', 'weekday': 'Wed'},
    {'day': '29', 'weekday': 'Thu'},
  ];

  final List<String> timeSlots = [
    '1:15 PM',
    '1:45 PM',
    '2:15 PM',
    '2:45 PM',
    '3:15 PM',
    '3:45 PM',
  ];

  DateTime _currentWeekStart = _findWeekStart(DateTime.now());
  int _selectedDateIndex = 0;

  static DateTime _findWeekStart(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  List<DateTime> getWeekDates(DateTime weekStart) {
    return List.generate(7, (index) => weekStart.add(Duration(days: index)));
  }

  late ColorNotifier notifier;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    guests = widget.guestsSelcted;
  }

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);

    return Scaffold(
      backgroundColor: notifier.background,
      body: Column(
        children: [
          Container(
            // height: Get.height,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 60,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  orangeColor,
                  notifier.background,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: notifier.textColor, size: 28),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Book a table',
                          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22, color: notifier.textColor),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Fannito Pizza',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: notifier.textColor),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Select number of guests
                  Container(
                    height: Get.height * 0.080,
                    decoration: BoxDecoration(
                      color: notifier.background,
                      border: Border.all(
                        color: notifier.borderColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select number of guests',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: notifier.textColor),
                          ),
                          Container(
                            height: Get.height * 0.050,
                            decoration: BoxDecoration(
                              color: notifier.background,
                              border: Border.all(
                                color: notifier.borderColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                            child: Center(
                              child: DropdownButton<int>(
                                value: guests,
                                dropdownColor: notifier.background,
                                underline: const SizedBox(),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: notifier.textColor,
                                ),
                                style: TextStyle(color: notifier.textColor, fontWeight: FontWeight.w600, fontSize: 16),
                                items: List.generate(
                                  10,
                                  (index) => DropdownMenuItem(
                                    value: index + 1,
                                    child: Text(
                                      '${index + 1}',
                                    ),
                                  ),
                                ),
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() {
                                      guests = val;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Select day and time',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: notifier.textColor),
                  ),
                  const SizedBox(height: 16),
                  // Date selector with vertical MAY label
                  SizedBox(
                    height: 80,
                    child: PageView.builder(
                      controller: PageController(initialPage: 0),
                      onPageChanged: (page) {
                        // When user scrolls to next/previous week, update _currentWeekStart accordingly
                        setState(() {
                          _currentWeekStart = _findWeekStart(DateTime.now()).add(Duration(days: page * 7));
                          _selectedDateIndex = 0; // Reset selected date to first day of week
                        });
                      },
                      itemBuilder: (context, page) {
                        // Calculate week start for this page
                        final weekStart = _findWeekStart(DateTime.now()).add(Duration(days: page * 7));
                        final weekDates = getWeekDates(weekStart);

                        // Month name from first date of the week
                        final monthName = DateFormat.MMMM().format(weekStart).toUpperCase();

                        return Row(
                          children: [
                            // Rotated month label
                            Container(
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade800,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  monthName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.white,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ),

                            // Dates of the week horizontally
                            Expanded(
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: weekDates.length,
                                separatorBuilder: (_, __) => const SizedBox(width: 12),
                                itemBuilder: (context, index) {
                                  final date = weekDates[index];
                                  final isSelected = index == _selectedDateIndex;

                                  return Container(
                                    width: 56,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isSelected ? orangeColor : notifier.borderColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _selectedDateIndex = index;
                                        });
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            DateFormat.d().format(date), // Day number
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                              color: isSelected ? orangeColor : notifier.textColor,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            DateFormat.E().format(date).toUpperCase(), // Weekday short name
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: isSelected ? orangeColor : notifier.textColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  // SizedBox(
                  //   height: 80,
                  //   child: ListView(
                  //     scrollDirection: Axis.horizontal,
                  //     children: [
                  //       Container(
                  //         margin: const EdgeInsets.only(right: 12),
                  //         decoration: BoxDecoration(
                  //           // color: const Color(0xFF1a1a1a),
                  //           color: notifier.containerColor,
                  //           borderRadius: BorderRadius.circular(50),
                  //         ),
                  //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  //         child: RotatedBox(
                  //           quarterTurns: 3,
                  //           child: Text(
                  //             'MAY',
                  //             style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: notifier.textColor, letterSpacing: 2),
                  //           ),
                  //         ),
                  //       ),
                  //       ...List.generate(dates.length, (index) {
                  //         final date = dates[index];
                  //         final isSelected = index == selectedDateIndex;
                  //         return Container(
                  //           margin: EdgeInsets.only(right: index == dates.length - 1 ? 0 : 12),
                  //           decoration: BoxDecoration(
                  //             color: isSelected ? Colors.white : Colors.transparent,
                  //             borderRadius: BorderRadius.circular(20),
                  //             border: isSelected ? null : Border.all(color: Colors.transparent),
                  //           ),
                  //           width: 56,
                  //           child: TextButton(
                  //             style: TextButton.styleFrom(
                  //               padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(20),
                  //               ),
                  //             ),
                  //             onPressed: () {
                  //               setState(() {
                  //                 selectedDateIndex = index;
                  //               });
                  //             },
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Text(
                  //                   date['day']!,
                  //                   style: TextStyle(
                  //                     fontWeight: FontWeight.w600,
                  //                     fontSize: 20,
                  //                     color: isSelected ? Colors.black : Colors.white,
                  //                   ),
                  //                 ),
                  //                 const SizedBox(height: 4),
                  //                 Text(
                  //                   date['weekday']!,
                  //                   style: TextStyle(
                  //                     fontWeight: FontWeight.w400,
                  //                     fontSize: 12,
                  //                     color: isSelected ? Colors.black : Colors.white.withOpacity(0.7),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         );
                  //       }),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // // Lunch/Dinner toggle
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     ChoiceChip(
                  //       label: const Padding(
                  //         padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  //         child: Text(
                  //           'Lunch',
                  //           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  //         ),
                  //       ),
                  //       selected: isLunchSelected,
                  //       selectedColor: Colors.white,
                  //       backgroundColor: const Color(0xFF121212),
                  //       labelStyle: TextStyle(color: isLunchSelected ? Colors.black : Colors.white),
                  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  //       onSelected: (selected) {
                  //         setState(() {
                  //           isLunchSelected = true;
                  //         });
                  //       },
                  //     ),
                  //     const SizedBox(width: 16),
                  //     ChoiceChip(
                  //       label: const Padding(
                  //         padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  //         child: Text(
                  //           'Dinner',
                  //           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  //         ),
                  //       ),
                  //       selected: !isLunchSelected,
                  //       selectedColor: Colors.white,
                  //       backgroundColor: const Color(0xFF121212),
                  //       labelStyle: TextStyle(color: !isLunchSelected ? Colors.black : Colors.white),
                  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  //       onSelected: (selected) {
                  //         setState(() {
                  //           isLunchSelected = false;
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 30),
                  // // Time slots grid
                  // Wrap(
                  //   spacing: 12,
                  //   runSpacing: 12,
                  //   children: timeSlots.map((time) {
                  //     return SizedBox(
                  //       width: (MediaQuery.of(context).size.width - 64) / 3,
                  //       child: OutlinedButton(
                  //         style: OutlinedButton.styleFrom(
                  //           side: const BorderSide(color: Color(0xFF1a1a1a)),
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(16),
                  //           ),
                  //           padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  //           backgroundColor: Colors.transparent,
                  //         ),
                  //         onPressed: () {},
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               time,
                  //               style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
                  //             ),
                  //             const SizedBox(height: 4),
                  //             const Text(
                  //               '2 offers',
                  //               style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF8a82f7)),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   }).toList(),
                  // ),
                  // const SizedBox(height: 20),
                  // // View all slots button
                  // Center(
                  //   child: TextButton.icon(
                  //     onPressed: () {},
                  //     icon: Icon(
                  //       Icons.keyboard_arrow_down,
                  //       color: notifier.textColor,
                  //     ),
                  //     label: Text(
                  //       'View all slots',
                  //       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: notifier.textColor),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: notifier.background,
        padding: const EdgeInsets.all(20),
        child: InkWell(
          onTap: null,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: orangeColor.withOpacity(0.40)),
            height: 50,
            width: width,
            child: Center(child: Text("Proceed to book".tr, style: TextStyle(color: WhiteColor, fontFamily: "Gilroy Bold", fontSize: 16))),
          ),
        ),
      ),
    );
  }
}
