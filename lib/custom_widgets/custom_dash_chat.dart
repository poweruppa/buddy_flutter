import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:buddy_flutter/size_helpers.dart';

class CustomDashChat extends StatelessWidget {
  final bool loading;
  final String uid;
  final BuildContext scaffoldContext;
  CustomDashChat({this.uid, this.loading, this.scaffoldContext});
  //final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();
  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitRing(
                  color: Colors.blueGrey,
                  size: displayHeight(context) * 0.08,
                ),
                Padding(
                  padding: EdgeInsets.only(top: displayHeight(context) * 0.02),
                  child: Text('Connecting to server...'),
                ),
              ],
            ),
          )
        : DashChat(
            inputDecoration:
                InputDecoration.collapsed(hintText: 'Type message here...'),
            inputContainerStyle: BoxDecoration(
              color: Color.fromARGB(255, 238, 238, 238),
            ),
            messages: List<ChatMessage>(),
            user: ChatUser(
              name: 'Provider.of<UserData>(context).username',
              uid: 'uid == null ? ' ' : uid',
            ),
            onSend: null,
          );
//        : Container(
//            child: Text('you are online'),
//          );
  }
}
