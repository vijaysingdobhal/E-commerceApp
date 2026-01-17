import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiHelper {
  static Widget CostomImage({required String img}) {
    return Image.asset("Assets/images/$img");
  }

  static Widget customText({
    required String text,
    required Color color,
    required FontWeight fontWeight,
    required fontFamily,
    required double fontSize,
    TextAlign textAlign = TextAlign.start, // Responsive Change: Added textAlign to support multi-line alignment
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        fontSize: fontSize,
      ),
    );
  }

  static Widget customTextField({required TextEditingController Controller}) {
    return Container(
      height: 40,
      // width: 360, // Responsive Change: Removed fixed width to allow the text field to fill available space
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CupertinoColors.white,
        border: Border.all(color: CupertinoColors.black, width: 1),
      ),
      child: TextField(
        controller: Controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: CupertinoColors.black),
          suffixIcon: Icon(Icons.mic, color: CupertinoColors.black),
          hintText: "Search",
          hintStyle: TextStyle(
            color: CupertinoColors.black,
            fontSize: 16,
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }

  static CustomButton(VoidCallback callback) {
    return Container(
      // Responsive Change: Using padding instead of fixed height/width for better scaling across devices
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0XFF27AF34)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          "Add",
          style: TextStyle(fontSize: 12, color: Color(0XFF27AF34), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
