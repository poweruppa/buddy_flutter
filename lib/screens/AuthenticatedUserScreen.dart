import 'dart:convert';
import 'package:buddy_flutter/custom_widgets/active_chat_button.dart';
import 'package:buddy_flutter/services/active_chats_provider.dart';
import 'package:buddy_flutter/services/loading_chat.dart';
import 'package:buddy_flutter/custom_widgets/custom_widgets.dart';
import 'package:buddy_flutter/custom_widgets/getUsernameForTitle.dart';
import 'package:buddy_flutter/custom_widgets/loading.dart';
import 'package:buddy_flutter/models/user.dart';
import 'package:buddy_flutter/screens/chat_room_screen.dart';
import 'package:buddy_flutter/services/auth.dart';
import 'package:buddy_flutter/services/socketIOClient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:buddy_flutter/size_helpers.dart';
import 'package:provider/provider.dart';
import 'package:buddy_flutter/services/database.dart';
import 'package:buddy_flutter/models/userData.dart';
import 'package:buddy_flutter/services/chatListProvider.dart';
import 'package:buddy_flutter/custom_widgets/MessageBubble.dart';

class AuthenticatedUserScreen extends StatefulWidget {
  final String userUID;

  AuthenticatedUserScreen({this.userUID});
  @override
  _AuthenticatedUserScreenState createState() =>
      _AuthenticatedUserScreenState();
}

class _AuthenticatedUserScreenState extends State<AuthenticatedUserScreen> {
  final AuthService _auth = AuthService();
  bool loading = false;
  String username;

  void _getUsername() {
    if (username == null) {
      print('username is null');
      loading = true;
      DatabaseService()
          .userDataCollection
          .document(Provider.of<User>(context, listen: false).uid)
          .get()
          .then((value) {
        username = value.data['username'];
      }).then((value) {
        if (!mounted) {
          return;
        }
        setState(() {
          loading = false;
        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(username + ' ' + 'this is the username');
    return loading
        ? Loading()
        : MultiProvider(
            providers: [
              StreamProvider<UserData>.value(
                value: DatabaseService(uid: Provider.of<User>(context).uid)
                    .userDataStream(),
                initialData: UserData(username: 'loading', coins: 0),
                catchError: (_, error) {
                  print(error);
                },
              ),
            ],
            child: SafeArea(
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
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Log Out"),
                                content:
                                    Text("Are you sure you want to log out?"),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () async {
                                      await _auth.signOut();
                                      Navigator.pushNamed(context, '/');
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
                                        username: username,
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
                                      username: username,
                                    )
//                                  customRaisedButton('Look for someone',
//                                      () {
//                                    socket.connect();
//                                    socket.on('connect', (_) {
//                                      Provider.of<LoadingChat>(context,
//                                              listen: false)
//                                          .stopLoadingChat();
//                                      Provider.of<ActiveChatsProvider>(context,
//                                              listen: false)
//                                          .addUsernameToActiveChatList(
//                                              'otherUserUsername');
//                                      print(Provider.of<ActiveChatsProvider>(
//                                              context,
//                                              listen: false)
//                                          .activeChatsUsername
//                                          .length);
//                                    });
//                                    socket.on('disconnect', (_) {
//                                      Provider.of<LoadingChat>(context,
//                                              listen: false)
//                                          .startLoadingChat();
//                                      Provider.of<ActiveChatsProvider>(context,
//                                              listen: false)
//                                          .eraseUsernameFromActiveChatList(
//                                              'otherUserUsername');
//                                      print(Provider.of<ActiveChatsProvider>(
//                                              context,
//                                              listen: false)
//                                          .activeChatsUsername
//                                          .length);
//                                    });
//                                    socket.on('sentAMessage', (data) {
//                                      print(jsonDecode(data));
//                                      var decodedData = jsonDecode(data);
//                                      Provider.of<ChatListProvider>(context,
//                                              listen: false)
//                                          .addMessageToChat(MessageBubble(
//                                        sender: decodedData['sender'],
//                                        text: decodedData['text'],
//                                        isMe: false,
//                                      ));
//                                    });
//                                    Navigator.of(context).push(
//                                        MaterialPageRoute(
//                                            builder: (context) =>
//                                                ChatRoomScreen(
//                                                  userUID: widget.userUID,
//                                                )));
//                                  }, displayHeight(context) * 0.03),
                                    )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
