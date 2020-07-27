import 'package:buddy_flutter/custom_widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buddy_flutter/custom_widgets/custom_widgets.dart';
import 'package:buddy_flutter/services/auth.dart';
import 'package:buddy_flutter/size_helpers.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String confirmedPassword = '';
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
                                  top: displayHeight(context) * 0.15),
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: displayHeight(context) * 0.06),
                                  child: Center(
                                    child: Text(
                                      'Sign In',
                                      style: GoogleFonts.satisfy(
                                          fontSize:
                                              displayHeight(context) * 0.065),
                                    ),
                                  ),
                                ),
                                customTextField(
                                  textToDisplay: 'Enter Email',
                                  checkValid: (value) =>
                                      value.isEmpty ? 'Enter an email' : null,
                                  obscured: false,
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
                                    });
                                  },
                                ),
                                SizedBox(height: displayHeight(context) * 0.10),
                                Container(
                                  padding: EdgeInsets.only(
                                      right: displayHeight(context) * 0.08,
                                      left: displayHeight(context) * 0.08),
                                  height: displayHeight(context) * 0.08,
                                  child: customRaisedButton(
                                    'Submit',
                                    () async {
                                      if (_formKey.currentState.validate()) {
                                        print('data is valid');
                                        setState(() {
                                          loading = true;
                                        });
                                        dynamic result = await _auth
                                            .signInWithEmailAndPassword(
                                                email, password);
                                        if (result == null) {
                                          setState(
                                            () {
                                              error =
                                                  'Could not sign in with those credentials';
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
                                  height: displayHeight(context) * 0.03,
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
