class UserData {
  final String username;
  final int coins;

  UserData({this.username, this.coins});

  factory UserData.fromMap(Map data) {
    data = data ?? {};
    return UserData(
      username: data['username'] ?? '',
      coins: data['coins'] ?? 0,
    );
  }

//  UserData.fromJson(Map<String, dynamic> parsedJSON)
//      : username = parsedJSON['name'],
//        coins = parsedJSON['age'];
}
