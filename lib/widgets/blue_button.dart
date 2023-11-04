// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/text_style.dart';

Widget blueButton(BuildContext context, String btnText,bool isVisible,Function callbackAction) {
  return Container(
    width: double.infinity,
    height: 60,
    child: TextButton(
      onPressed: () => callbackAction(),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
        primary: Colors.white,
        backgroundColor: richTextColor,
      ),
      child: Padding(
        padding:  EdgeInsets.all(2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('  '),
            // SizedBox(width: 90),
             Text(btnText,style: btnTextStyle),
            // SizedBox(width: 100),
            isVisible?Icon(Icons.arrow_forward,
              color: whiteColor,
            ):Container(),
          ],
        ),
      ),
    ),
  );
}
