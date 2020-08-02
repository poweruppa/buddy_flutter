import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:buddy_flutter/size_helpers.dart';

class CustomDashChat extends StatelessWidget {
  final bool loading;
  final String uid;
  CustomDashChat({this.uid, this.loading});
  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitChasingDots(
                  color: Colors.blueGrey,
                  size: displayHeight(context) * 0.08,
                ),
                Padding(
                  padding: EdgeInsets.only(top: displayHeight(context) * 0.01),
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
  }
}
