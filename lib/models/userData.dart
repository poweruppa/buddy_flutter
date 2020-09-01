class UserData {
  final String username;
  final int coins;
  final List<String> listOfFriends;
  final int popularity;
  UserData({this.username, this.coins, this.popularity, this.listOfFriends});

//  factory UserData.fromMap(Map data) {
//    data = data ?? {};
//    return UserData(
//      username: data['username'] ?? '',
//      coins: data['coins'] ?? 0,
//      listOfFriends: data['listOfFriends'] ?? [],
//      popularity: data['popularity'],
//    );
//  }
  UserData.fromJson(Map<String, dynamic> parsedJSON)
      : username = parsedJSON['username'],
        coins = parsedJSON['coins'],
        listOfFriends = parsedJSON['listOfFriends'],
        popularity = parsedJSON['popularity'];
}
