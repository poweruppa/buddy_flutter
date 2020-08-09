import 'package:flutter/material.dart';
import 'package:buddy_flutter/custom_widgets/MessageBubble.dart';

class MessageList extends StatelessWidget {
  List<MessageBubble> messages = [
    MessageBubble(
      sender: 'juan',
      text: 'prueba',
      isMe: false,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(builder: null);
  }
}
