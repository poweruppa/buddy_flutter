import 'dart:convert';
import 'package:buddy_flutter/services/chatListProvider.dart';
import 'package:buddy_flutter/services/loading_chat.dart';
import 'package:buddy_flutter/services/socketIOClient.dart';
import 'package:buddy_flutter/size_helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:buddy_flutter/custom_widgets/MessageBubble.dart';
import 'package:provider/provider.dart';

class CustomChatView extends StatefulWidget {
//  final String username;
//  CustomChatView({this.username});
  @override
  _CustomChatViewState createState() => _CustomChatViewState();
}

class _CustomChatViewState extends State<CustomChatView> {
  final messageTextController = TextEditingController();
  String messageText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didUpdateWidget(CustomChatView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: displayHeight(context) * 0.03,
          child: Text(
            Provider.of<LoadingChat>(context).otherUserIsTyping == true
                ? 'Typing'
                : 'data',
          ),
        ),
        Expanded(
          child: ListView.builder(
            reverse: true,
            itemCount: Provider.of<ChatListProvider>(context).messages.length,
            itemBuilder: (context, index) {
              return Container(
                child: Provider.of<ChatListProvider>(context).messages[index],
              );
            },
          ),
        ),
        Container(
          child: Provider.of<LoadingChat>(context).showDisconnectedPartnerDialog
              ? AlertDialog(
                  title: Text("Partner has disconnected"),
                  content: Text("Would you like to look for a new partner?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Yes'),
                      onPressed: () {
                        Provider.of<LoadingChat>(context, listen: false)
                            .startLoadingChat();
                        Provider.of<ChatListProvider>(context, listen: false)
                            .eraseChatMessages();
                        socket.emit('lookForANewPartner');
                        Provider.of<LoadingChat>(context, listen: false)
                            .hidePartnerDisconnectedDialog();
                      },
                    ),
                    FlatButton(
                      child: Text("Close"),
                      onPressed: () {
                        socket.disconnect();
                        socket.clearListeners();
                        Provider.of<LoadingChat>(context, listen: false)
                            .startLoadingChat();
                        Provider.of<ChatListProvider>(context, listen: false)
                            .eraseChatMessages();
                        Provider.of<LoadingChat>(context, listen: false)
                            .hidePartnerDisconnectedDialog();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              : null,
        ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Type your message here...',
                    filled: true,
                    fillColor: Color.fromARGB(255, 238, 238, 238),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  ),
                  textInputAction: TextInputAction.send,
                  onEditingComplete: () {
                    messageTextController.clear();
                    //Implement send functionality.
                    var messageBubbleToSend = {
                      'sender':
                          Provider.of<DocumentSnapshot>(context, listen: false)
                              .data['username'],
                      'text': messageText,
                      'isMe': true,
                    };
                    socket.emit(
                        'sentAMessage', jsonEncode(messageBubbleToSend));
                    Provider.of<ChatListProvider>(context, listen: false)
                        .addMessageToChat(MessageBubble(
                      sender:
                          Provider.of<DocumentSnapshot>(context, listen: false)
                              .data['username'],
                      text: messageText,
                      isMe: true,
                    ));
                  },
                  controller: messageTextController,
                  onChanged: (value) {
                    //Do something with the user input.
                    socket.emit('userIsTyping');
                    messageText = value;
                  },
                ),
              ),
              RawMaterialButton(
                fillColor: Color.fromARGB(255, 238, 238, 238),
                onPressed: () {
                  messageTextController.clear();
                  //Implement send functionality.
                  var messageBubbleToSend = {
                    'sender':
                        Provider.of<DocumentSnapshot>(context, listen: false)
                            .data['username'],
                    'text': messageText,
                    'isMe': true,
                  };
                  socket.emit('sentAMessage', jsonEncode(messageBubbleToSend));
                  Provider.of<ChatListProvider>(context, listen: false)
                      .addMessageToChat(MessageBubble(
                    sender:
                        Provider.of<DocumentSnapshot>(context, listen: false)
                            .data['username'],
                    text: messageText,
                    isMe: true,
                  ));
                },
                child: Icon(
                  Icons.send,
                  size: 35.0,
                ),
                padding: EdgeInsets.all(4.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
