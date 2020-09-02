import 'dart:convert';
import 'package:buddy_flutter/services/chatListProvider.dart';
import 'package:buddy_flutter/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:buddy_flutter/services/socketIOClient.dart';
import 'package:buddy_flutter/services/loading_chat.dart';
import 'package:buddy_flutter/custom_widgets/MessageBubble.dart';
import 'package:buddy_flutter/screens/chat_room_screen.dart';
import 'package:buddy_flutter/size_helpers.dart';

class ActiveChatsListView extends StatelessWidget {
  final String userUID;
  final String username;
  ActiveChatsListView({this.userUID, this.username});
  @override
  Widget build(BuildContext context) {
    return Provider.of<LoadingChat>(context).loadingChat
        ? MaterialButton(
            onPressed: () {
              socket.connect();
              socket.on('connect', (_) {
                Provider.of<LoadingChat>(context, listen: false)
                    .stopLoadingChat();
                socket.emit('sendUsernameToServer', username);
              });
              socket.on('disconnect', (_) {
                socket.clearListeners();
                Provider.of<LoadingChat>(context, listen: false)
                    .startLoadingChat();
              });
              socket.on('sentAMessage', (data) {
                print(jsonDecode(data));
                var decodedData = jsonDecode(data);
                Provider.of<ChatListProvider>(context, listen: false)
                    .addMessageToChat(MessageBubble(
                  sender: decodedData['sender'],
                  text: decodedData['text'],
                  isMe: false,
                ));
              });
              socket.on('sendUsernameToServer', (data) {
                print(data + " " + 'this is the data');
                Provider.of<LoadingChat>(context, listen: false)
                    .changeOtherUserUsername(data);
                print(Provider.of<LoadingChat>(context, listen: false)
                    .otherUserUsername);
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StreamProvider<DocumentSnapshot>.value(
                    value: DatabaseService(uid: userUID).userDataStream,
                    child: ChatRoomScreen(
                      userUID: userUID,
                    ),
                  ),
                ),
              );
            },
            child: Text(
              'Look for Someone',
              style: GoogleFonts.mPlusRounded1c(
                  color: Colors.white, fontSize: displayHeight(context) * 0.03),
            ),
            color: Colors.black,
            elevation: 10.0,
          )
        : MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StreamProvider<DocumentSnapshot>.value(
                    value: DatabaseService(uid: userUID).userDataStream,
                    child: ChatRoomScreen(
                      userUID: userUID,
                    ),
                  ),
                ),
              );
            },
            color: Colors.black,
            elevation: 10.0,
            child: Provider.of<LoadingChat>(context).otherUserUsername == null
                ? Text(
                    'Return to Random Chat',
                    style: GoogleFonts.mPlusRounded1c(
                        color: Colors.white,
                        fontSize: displayHeight(context) * 0.025),
                  )
                : Text(
                    'Keep Chatting with' +
                        " " +
                        Provider.of<LoadingChat>(context, listen: false)
                            .otherUserUsername
                            .toString(),
                    style: GoogleFonts.mPlusRounded1c(
                        color: Colors.white,
                        fontSize: displayHeight(context) * 0.02)),
          );
  }
}
