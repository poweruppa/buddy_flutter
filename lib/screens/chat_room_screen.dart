import 'package:buddy_flutter/custom_widgets/custom_dash_chat.dart';
import 'package:buddy_flutter/models/userData.dart';
import 'package:buddy_flutter/services/chatListProvider.dart';
import 'package:buddy_flutter/services/socketIOClient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:buddy_flutter/size_helpers.dart';
import 'package:provider/provider.dart';
import 'package:buddy_flutter/services/loading_chat.dart';
import 'package:buddy_flutter/services/database.dart';

class ChatRoomScreen extends StatefulWidget {
  final String userUID;
  ChatRoomScreen({this.userUID});

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 178, 223, 219),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: displayWidth(context) * 0.02),
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
                      builder: (BuildContext contextBuilder) => AlertDialog(
                        title: Text("Close"),
                        content: Text("Are you sure you want exit this chat?"),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              //Navigator.of(context, rootNavigator: true).pop();
                              socket.clearListeners();
                              socket.disconnect();
                              Provider.of<LoadingChat>(context, listen: false)
                                  .startLoadingChat();
                              Provider.of<ChatListProvider>(context,
                                      listen: false)
                                  .eraseChatMessages();
                              Navigator.pop(contextBuilder);
                              Navigator.pop(context);
                            },
                            child: Text('Yes'),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No'),
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
                    //This container is the entire chat pannel where messages should be displayed
                    //child: Container(
                    child: CustomDashChat(
                      loading: Provider.of<LoadingChat>(context).loadingChat,
                      uid: widget.userUID,
                    ),
                    //),
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
