import 'package:flutter/material.dart';

class ImageBubble extends StatelessWidget {
  ImageBubble({this.sender, this.text, this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  ImageBubble.fromJson(Map<String, dynamic> json)
      : sender = json['sender'],
        text = json['text'],
        isMe = json['isMe'];

  Map<String, dynamic> toJson() =>
      {'sender': sender, 'text': text, 'isMe': isMe};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0)),
            elevation: 5.0,
            color: isMe ? Color.fromARGB(255, 178, 223, 219) : Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$text ',
                style: TextStyle(
                    fontSize: 15.0, color: isMe ? Colors.black : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
