import 'package:buddy_flutter/custom_widgets/loading.dart';
import 'package:buddy_flutter/services/auth.dart';
import 'package:buddy_flutter/size_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buddy_flutter/custom_widgets/custom_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String confirmedPassword = '';
  String username = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final textSizeForButtom = displayHeight(context) * 0.03;
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              backgroundColor: Color.fromARGB(255, 178, 223, 219),
              body: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: displayWidth(context) * 0.02),
                          child: Text(
                            'Buddy',
                            style: GoogleFonts.satisfy(
                                fontSize: displayHeight(context) * 0.045),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 50.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: Form(
                            key: _formKey,
                            child: ListView(
                              padding: EdgeInsets.only(
                                  top: displayHeight(context) * 0.10),
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Text('Sign Up',
                                      style: GoogleFonts.satisfy(
                                          fontSize:
                                              displayHeight(context) * 0.065)),
                                ),
                                SizedBox(height: 20.0),
                                customTextField(
                                    textToDisplay: 'Enter Username',
                                    obscured: false,
                                    checkValid: (value) => value.isEmpty
                                        ? 'Enter a username'
                                        : null,
                                    whenChanged: (value) {
                                      setState(() {
                                        username = value;
                                      });
                                    }),
                                SizedBox(height: 20.0),
                                customTextField(
                                  textToDisplay: 'Enter Email',
                                  obscured: false,
                                  checkValid: (value) =>
                                      value.isEmpty ? 'Enter an email' : null,
                                  whenChanged: (value) {
                                    setState(() {
                                      email = value;
                                    });
                                  },
                                ),
                                SizedBox(height: 20.0),
                                customTextField(
                                  textToDisplay: 'Enter Password',
                                  checkValid: (value) => value.length < 6
                                      ? 'Enter a password longer than 6 characters'
                                      : null,
                                  obscured: true,
                                  whenChanged: (value) {
                                    setState(() {
                                      password = value;
                                      print(password);
                                    });
                                  },
                                ),
                                SizedBox(height: 20.0),
                                customTextField(
                                  textToDisplay: 'Confirm Password',
                                  checkValid: (value) => value != password
                                      ? 'Passwords do not match'
                                      : null,
                                  obscured: true,
                                  whenChanged: (value) {
                                    setState(() {
                                      confirmedPassword = value;
                                      print(confirmedPassword);
                                    });
                                  },
                                ),
                                SizedBox(height: 50.0),
                                Container(
                                  padding: EdgeInsets.only(
                                      right: displayHeight(context) * 0.08,
                                      left: displayHeight(context) * 0.08),
                                  height: displayHeight(context) * 0.08,
                                  child: customRaisedButton(
                                    'Submit',
                                    () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        dynamic result = await _auth
                                            .registerWithEmailAndPassword(
                                                email, password, username);
                                        if (result == null) {
                                          setState(
                                            () {
                                              error =
                                                  'Please supply a valid email';
                                              loading = false;
                                            },
                                          );
                                        } else {
                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                    textSizeForButtom,
                                  ),
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                Center(
                                  child: Text(
                                    error,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
