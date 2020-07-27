import 'package:buddy_flutter/services/auth.dart';
import 'package:buddy_flutter/size_helpers.dart';
import 'package:flutter/material.dart';
import 'package:buddy_flutter/custom_widgets/custom_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final textSizeForButtom = displayHeight(context) * 0.025;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color.fromARGB(255, 178, 223, 219),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(bottom: displayHeight(context) * 0.12),
                  child: Text(
                    'Welcome to Buddy',
                    style: GoogleFonts.satisfy(
                        fontSize: displayHeight(context) * 0.065),
                  ),
                ),
                Container(
                  width: displayWidth(context) * 0.50,
                  height: displayHeight(context) * 0.08,
                  child: customRaisedButton('Log In', () {
                    Navigator.pushNamed(context, '/loginScreen');
                  }, textSizeForButtom),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.04,
                ),
                Container(
                  width: displayWidth(context) * 0.50,
                  height: displayHeight(context) * 0.08,
                  child: customRaisedButton('Sign Up', () {
                    Navigator.pushNamed(context, '/signUpScreen');
                  }, textSizeForButtom),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
