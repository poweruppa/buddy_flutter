import 'package:buddy_flutter/custom_widgets/active_chat_button.dart';
import 'package:buddy_flutter/custom_widgets/getUsernameForTitle.dart';
import 'package:buddy_flutter/custom_widgets/loading.dart';
import 'package:buddy_flutter/models/user.dart';
import 'package:buddy_flutter/screens/profile_screen.dart';
import 'package:buddy_flutter/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:buddy_flutter/size_helpers.dart';
import 'package:provider/provider.dart';
import 'package:buddy_flutter/services/database.dart';
import 'package:buddy_flutter/services/loading_chat.dart';
import 'package:buddy_flutter/services/socketIOClient.dart';

class AuthenticatedUserScreen extends StatefulWidget {
  final String userUID;

//  final GlobalKey inheritedContext;
  AuthenticatedUserScreen({this.userUID});
  @override
  _AuthenticatedUserScreenState createState() =>
      _AuthenticatedUserScreenState();
}

class _AuthenticatedUserScreenState extends State<AuthenticatedUserScreen> {
  final AuthService _auth = AuthService();
  String username;
  GlobalKey _scaffoldKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    print(widget.userUID + 'this is the uid');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<User>(context).uid);
    return Provider.of<DocumentSnapshot>(context) == null
        ? Loading()
        : SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
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
//                        IconButton(
//                          icon: Icon(Icons.close),
//                          onPressed: () {
//                            showDialog(
//                              context: context,
//                              builder: (context) => AlertDialog(
//                                title: Text("Log Out"),
//                                content:
//                                    Text("Are you sure you want to log out?"),
//                                actions: <Widget>[
//                                  FlatButton(
//                                    onPressed: () async {
//                                      await _auth.signOut();
//                                      Navigator.pop(context);
//                                      //socket.disconnect();
//                                    },
//                                    child: Text('Yes'),
//                                  ),
//                                  FlatButton(
//                                    onPressed: () {
//                                      Navigator.of(context).pop();
//                                    },
//                                    child: Text('Close'),
//                                  ),
//                                ],
//                              ),
//                            );
//                          },
//                        ),
                      PopupMenuButton(
                        onSelected: (value) {
                          if (value == 2) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Log Out"),
                                content:
                                    Text("Are you sure you want to log out?"),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () async {
                                      socket.clearListeners();
                                      socket.disconnect();
                                      Provider.of<LoadingChat>(context,
                                              listen: false)
                                          .startLoadingChat();
                                      await _auth.signOut();
                                      Navigator.pop(context);
                                    },
                                    child: Text('Yes'),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Close'),
                                  ),
                                ],
                              ),
                            );
                          } else if (value == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    StreamProvider<DocumentSnapshot>.value(
                                  value: DatabaseService(uid: widget.userUID)
                                      .userDataStream,
                                  child: ProfileScreen(),
                                ),
                              ),
                            );
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: Text('Profile'),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Text('Log Out'),
                          )
                        ],
                      )
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
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: displayHeight(context) * 0.02),
                                    //alignment: Alignment.center,
                                    child: UserName(
                                        //username: username,
                                        ),
                                  ),
                                ],
                              ),
//                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: [
//                                    Text(
//                                      "Your friend list is empty. It's time to find some friends! ",
//                                    ),
//                                  ],
//                                ),
                              Container(
                                height: displayHeight(context) * 0.7,
                                //child: ActiveChatsListView(),
                              ),
                              Container(
                                height: displayHeight(context) * 0.08,
                                width: displayWidth(context) * 0.7,
                                child: ActiveChatsListView(
                                  userUID: widget.userUID,
                                  username:
                                      Provider.of<DocumentSnapshot>(context)
                                          .data['username'],
                                ),
                              ),
                            ],
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
