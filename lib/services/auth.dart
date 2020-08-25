import 'package:buddy_flutter/models/user.dart';
import 'package:buddy_flutter/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on FirebaseUser

  User _fromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_fromFirebaseUser);
  }

  //sign in anonymously
  Future signInAnonymously() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _fromFirebaseUser(user);
    } catch (error) {
      print(error);
      return null;
    }
  }

  //sign in with email and pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _fromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //register with email and pass
  Future registerWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      //create a new document in database using user id
      await DatabaseService(uid: user.uid).updateUserData(
          username: username, coins: 0, listOfFriends: [], popularity: 0);
      return _fromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error);
      return null;
    }
  }
}
