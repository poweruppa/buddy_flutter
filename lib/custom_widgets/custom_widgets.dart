import 'package:flutter/material.dart';
import 'package:buddy_flutter/size_helpers.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customTextField(
    {String textToDisplay,
    bool obscured,
    Function whenChanged,
    Function checkValid}) {
  return TextFormField(
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(10.0),
      hintText: textToDisplay,
    ),
    obscureText: obscured,
    onChanged: whenChanged,
    validator: checkValid,
  );
}

Widget customRaisedButton(
    String textToDisplay, Function whenClicked, double textSize) {
  return MaterialButton(
    onPressed: whenClicked,
    child: Text(
      textToDisplay,
      style:
          GoogleFonts.mPlusRounded1c(color: Colors.white, fontSize: textSize),
    ),
    color: Colors.black,
    elevation: 10.0,
  );
}