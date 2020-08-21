import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:buddy_flutter/size_helpers.dart';

class UserName extends StatelessWidget {
  final username;
  UserName({this.username});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
//        Text(
//          'Welcome to buddy,',
//          style: GoogleFonts.satisfy(fontSize: displayHeight(context) * 0.045),
//        ),
        Text(
          '$username',
          style: GoogleFonts.satisfy(fontSize: displayHeight(context) * 0.045),
        ),
      ],
    );
  }
}
