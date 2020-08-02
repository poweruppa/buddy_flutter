import 'package:buddy_flutter/models/user.dart';
import 'package:buddy_flutter/screens/LogInScreen.dart';
import 'package:buddy_flutter/screens/SignUpScreen.dart';
import 'package:buddy_flutter/screens/chat_room_screen.dart';
import 'package:buddy_flutter/services/auth.dart';
import 'package:buddy_flutter/services/socketIOClient.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/Wrapper.dart';
import 'screens/AuthenticatedUserScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          value: AuthService().user,
        ),
        ChangeNotifierProvider(
          create: (context) => LoadingChat(),
        )
      ],
      child: MaterialApp(
        title: 'Buddy',
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          '/loginScreen': (context) => LogInScreen(),
          '/authenticatedScreen': (context) => AuthenticatedUserScreen(),
          '/signUpScreen': (context) => SignUpScreen(),
          '/chatRoomScreen': (context) => ChatRoomScreen(),
        },
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: WelcomeScreen(),
      ),
    );
  }
}
