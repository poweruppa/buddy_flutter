import 'package:buddy_flutter/custom_widgets/custom_dash_chat.dart';
import 'package:buddy_flutter/models/user.dart';
import 'package:buddy_flutter/screens/Wrapper.dart';
import 'package:buddy_flutter/services/socketIOClient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:buddy_flutter/size_helpers.dart';
import 'package:provider/provider.dart';
import 'package:buddy_flutter/services/database.dart';
import 'package:buddy_flutter/models/userData.dart';

class ChatRoomScreen extends StatelessWidget {
  final bool loading;
  ChatRoomScreen({this.loading});

  @override
  Widget build(BuildContext context) {
    socket.on('disconnect', (_) {
      Provider.of<LoadingChat>(context, listen: false).startLoadingChat();
    });
    return MultiProvider(
      providers: [
        StreamProvider<UserData>.value(
          value: DatabaseService(uid: Provider.of<User>(context).uid)
              .userDataStream(),
          initialData: UserData(username: 'loading', coins: 0),
        ),
      ],
      child: SafeArea(
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
                        builder: (context) => AlertDialog(
                          title: Text("Close"),
                          content:
                              Text("Are you sure you want exit this chat?"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                socket.disconnect();
                                socket.on('disconnect', (_) {
                                  Provider.of<LoadingChat>(context,
                                          listen: false)
                                      .startLoadingChat();
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Wrapper(),
                                  ),
                                );
                              },
                              child: Text('Yes'),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
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
                      child: Container(
                        child: CustomDashChat(
                          loading:
                              Provider.of<LoadingChat>(context).loadingChat,
                          uid: Provider.of<User>(context).uid,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
