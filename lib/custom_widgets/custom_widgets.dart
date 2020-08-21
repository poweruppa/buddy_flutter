import 'package:flutter/material.dart';

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

//ChatUser meChatUser(
//  String username,
//) {
//  return ChatUser();
//}

Widget customAlert(
    {String customTitle,
    String customDescription,
    Function firstButtonOnPressed,
    String firstButtonText,
    Function secondButtonPressed,
    String secondButtonText}) {
  return AlertDialog(
    title: Text(customTitle),
    content: Text(customDescription),
    actions: [
      FlatButton(onPressed: firstButtonOnPressed, child: Text(firstButtonText)),
      FlatButton(onPressed: secondButtonPressed, child: Text(secondButtonText)),
    ],
  );
}
