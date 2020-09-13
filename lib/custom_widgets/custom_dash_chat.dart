import 'package:buddy_flutter/custom_widgets/customChatView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:buddy_flutter/size_helpers.dart';
import 'package:provider/provider.dart';

class CustomDashChat extends StatefulWidget {
  final bool loading;
  final String uid;
  CustomDashChat({this.uid, this.loading});

  @override
  _CustomDashChatState createState() => _CustomDashChatState();
}

class _CustomDashChatState extends State<CustomDashChat> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.loading || Provider.of<DocumentSnapshot>(context) == null
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
        : CustomChatView();
  }
}
