import 'package:buddy_flutter/models/user.dart';
import 'package:buddy_flutter/screens/AuthenticatedUserScreen.dart';
import 'package:buddy_flutter/screens/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userFromMaterialApp = Provider.of<User>(context);
    //String userUid;
    print(userFromMaterialApp);
    //return home or Authenticate Widget
    if (userFromMaterialApp == null) {
      return WelcomeScreen();
    } else {
      return AuthenticatedUserScreen(
        userUID: Provider.of<User>(context).uid,
      );
    }
  }
}
