import 'package:buddy_flutter/models/userData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:buddy_flutter/size_helpers.dart';

class UserName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    final String username = userData.username;
    return Text(
      'Welcome to buddy,\n $username ',
      style: GoogleFonts.satisfy(fontSize: displayHeight(context) * 0.045),
    );
  }
}
