import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:buddy_flutter/size_helpers.dart';
import 'package:provider/provider.dart';

class UserName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //UserData user = Provider.of<UserData>(context);
    //print(user);
    return Column(
      children: [
//        Text(
//          'Welcome to buddy,',
//          style: GoogleFonts.satisfy(fontSize: displayHeight(context) * 0.045),
//        ),
        Text(
          Provider.of<DocumentSnapshot>(context).data['username'],
          style: GoogleFonts.satisfy(fontSize: displayHeight(context) * 0.045),
        ),
      ],
    );
  }
}
