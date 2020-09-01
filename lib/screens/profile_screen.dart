import 'package:buddy_flutter/custom_widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:buddy_flutter/size_helpers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.of<DocumentSnapshot>(context) == null
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
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: displayHeight(context) * 0.05,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: displayHeight(context) * 0.1,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: displayHeight(context) * 0.02),
                                child: Text(
                                  Provider.of<DocumentSnapshot>(context)
                                      .data['username'],
                                  style: TextStyle(
                                      fontSize: displayHeight(context) * 0.05),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: displayHeight(context) * 0.02),
                                child: Icon(
                                  Icons.star,
                                  size: displayHeight(context) * 0.05,
                                  color: Colors.yellow,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: displayHeight(context) * 0.02),
                                    child: Text(
                                      Provider.of<DocumentSnapshot>(context)
                                          .data['coins']
                                          .toString(),
                                      style: TextStyle(
                                          fontSize:
                                              displayHeight(context) * 0.05),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: displayHeight(context) * 0.02),
                                    child: Icon(
                                      Icons.monetization_on,
                                      size: displayHeight(context) * 0.05,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: displayHeight(context) * 0.02),
                                child: Text(
                                  Provider.of<DocumentSnapshot>(context)
                                          .data['listOfFriends']
                                          .length
                                          .toString() +
                                      ' Friends',
                                  style: TextStyle(
                                      fontSize: displayHeight(context) * 0.05),
                                ),
                              ),
                            ],
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
