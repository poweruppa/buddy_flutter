import 'package:flutter/material.dart';

class LoadingChat extends ChangeNotifier {
  bool loadingChat = true;
  String otherUserUsername;

  void changeOtherUserUsername(String username) {
    otherUserUsername = username;
    notifyListeners();
  }

  void startLoadingChat() {
    loadingChat = true;
    notifyListeners();
  }

  void stopLoadingChat() {
    loadingChat = false;
    notifyListeners();
  }

  void unsubscribeFromLoadingChat() {}
}
