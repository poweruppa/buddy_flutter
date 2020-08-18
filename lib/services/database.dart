import 'package:buddy_flutter/models/userData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

//  Future<String> getUserName() async {
//    String username;
//    await userDataCollection.document(uid).get().then((value) {
//      String username = value.data['username'];
//    });
//    print(username);
//    return username;
//    //    DatabaseService()
////        .userDataCollection
////        .document(Provider.of<User>(context, listen: false).uid)
////        .get()
////        .then((value) {
////      username = value.data['username'];
////    });
//  }

  //get userDataCollection stream and create a UserData object from it
  Stream<UserData> userDataStream() {
//    if (uid == null) {
//      return;
//    }
    var snapshots = userDataCollection.document(uid).snapshots();
    return snapshots.map((snapshots) => UserData.fromMap(snapshots.data));
  }
}
