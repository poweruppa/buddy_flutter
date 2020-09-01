import 'package:buddy_flutter/models/user.dart';
import 'package:buddy_flutter/screens/AuthenticatedUserScreen.dart';
import 'package:buddy_flutter/screens/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buddy_flutter/services/database.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userFromMaterialApp = Provider.of<User>(context);
    print(userFromMaterialApp);
    //return home or Authenticate Widget
    if (userFromMaterialApp == null) {
      return WelcomeScreen();
    } else {
      return StreamProvider(
        create: (_) =>
            DatabaseService(uid: Provider.of<User>(context).uid).userDataStream,
        catchError: (_, error) {
          return;
        },
        child: AuthenticatedUserScreen(
          userUID: Provider.of<User>(context).uid,
        ),
      );
    }
  }
}
