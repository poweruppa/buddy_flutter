import 'package:buddy_flutter/custom_widgets/ImageBubble.dart';
import 'package:flutter/material.dart';
import 'package:buddy_flutter/custom_widgets/MessageBubble.dart';

class ChatListProvider extends ChangeNotifier {
  List<MessageBubble> messages = [
    MessageBubble(
      sender: 'Server',
      text: "You're connected",
      isMe: false,
    )
  ];

  void addMessageToChat(MessageBubble message) {
    messages.insert(0, message);
    notifyListeners();
  }

//  void addImageToChat(ImageBubble message){
//    messages.insert(0, message);
//    notifyListeners();
//  }

  void eraseChatMessages() {
    messages = [
      MessageBubble(
        sender: 'Server',
        text: "You're connected",
        isMe: false,
      )
    ];
    notifyListeners();
  }
}
