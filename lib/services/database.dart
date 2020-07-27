import 'package:buddy_flutter/models/user.dart';
import 'package:buddy_flutter/models/userData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference userDataCollection =
      Firestore.instance.collection('userDataCollection');

  Future updateUserData(String username, int coins) async {
    return await userDataCollection
        .document(uid)
        .setData({'username': username, 'coins': coins});
  }

  //get userDataCollection stream and create a UserData object from it
  Stream<UserData> userDataStream() {
    print(userDataCollection.document(uid).snapshots());
    var snapshots = userDataCollection.document(uid).snapshots();
    return snapshots.map((snapshots) => UserData.fromMap(snapshots.data));
  }
}
