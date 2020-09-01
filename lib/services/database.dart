import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference userDataCollection =
      Firestore.instance.collection('userDataCollection');

  Future updateUserData(
      {String username,
      int coins,
      List<String> listOfFriends,
      int popularity}) async {
    return await userDataCollection.document(uid).setData({
      'username': username,
      'coins': coins,
      'listOfFriends': listOfFriends,
      'popularity': popularity
    });
  }

  //get userDataCollection stream and create a UserData object from it
//  Stream<UserData> get userDataStream {
////    if (uid == null) {
////      return;
////    }
//    print(uid);
//    var snapshots = userDataCollection.document(uid).snapshots();
//    return snapshots.map((snapshots) => UserData.fromJson(snapshots.data));
//  }
  Stream<DocumentSnapshot> get userDataStream {
    print(uid);
    return userDataCollection.document(uid).snapshots();
    //return snapshots.map((snapshots) => UserData.fromJson(snapshots.data));
  }
}
