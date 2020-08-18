import 'package:buddy_flutter/custom_widgets/customChatView.dart';
import 'package:buddy_flutter/services/database.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:buddy_flutter/size_helpers.dart';

class CustomDashChat extends StatefulWidget {
  final bool loading;
  final String uid;
  CustomDashChat({this.uid, this.loading});

  @override
  _CustomDashChatState createState() => _CustomDashChatState();
}

class _CustomDashChatState extends State<CustomDashChat> {
  String username;
  void userSend(ChatMessage message, ChatUser user) {}

  @override
  void initState() {
    DatabaseService()
        .userDataCollection
        .document(widget.uid)
        .get()
        .then((value) {
      username = value.data['username'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.loading
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
        :
        //ChangeNotifierProvider(
        //        create: (_) => ChatListProvider(),
        //   child:
        CustomChatView(
            username: username,
          );
    //     );
  }
}

//    CustomChatView(
//      username: username,
//    );
//DashChat(
//            //key: _chatViewKey,
//            textController: myTextEditingController,
//            //scrollController: myScrollController,
//            textInputAction: TextInputAction.send,
//            inputDecoration:
//                InputDecoration.collapsed(hintText: 'Type message here...'),
//            inputContainerStyle: BoxDecoration(
//              color: Color.fromARGB(255, 238, 238, 238),
//            ),
//            messages: messages,
//            user: ChatUser(
//              name: username,
//              uid: widget.uid,
//            ),
//            onSend: (ChatMessage message) {
//              messages.add(
//                ChatMessage(
//                  text: myTextEditingController.text,
//                  user: ChatUser(
//                    name: username,
//                    uid: userUID,
//                  ),
//                ),
//              );
//            },
//          );
