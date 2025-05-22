import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchField extends StatefulWidget {
  final bool readOnly;
  final bool showBackButton;
  final bool showSearchIcon;
  final VoidCallback? onTap;
  final String hintText;
  TextEditingController? controller;
  SearchField({
    this.showBackButton = false,
    this.readOnly = false,
    this.showSearchIcon = false,
    this.onTap,
    Key? key,
    this.controller,
    this.hintText = "change ths",
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  // TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        // border: Border.all(
        //   color: Colors.grey[500]!,
        // ),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            color: Colors.grey.withOpacity(.3),
            blurRadius: 2,
            spreadRadius: 1,
          )
        ],
      ),
      height: 45,
      child: Row(
        children: [
          if (widget.showBackButton)
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 20,
              ),
            ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TextField(
                // textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                onTap: widget.onTap,
                readOnly: widget.readOnly,
                controller: widget.controller,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  // suffixIcon:
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey[500]!, fontSize: 14),
                  hintText: "restaurant name or dish name",
                ),
              ),
            ),
          ),
          IconButton(
              icon: Icon(
                !widget.showSearchIcon ? Icons.clear : Icons.search,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  if (widget.controller != null) widget.controller!.clear();
                });
              }),
        ],
      ),
    );
  }
}
