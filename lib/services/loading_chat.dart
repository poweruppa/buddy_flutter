import 'package:flutter/material.dart';

class LoadingChat extends ChangeNotifier {
  bool loadingChat = true;
  bool otherUserIsTyping = false;
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

  void otherUserStartsTyping() {
    otherUserIsTyping = true;
    notifyListeners();
  }

  void otherUserStopsTyping() {
    otherUserIsTyping = false;
    notifyListeners();
  }

  void unsubscribeFromLoadingChat() {}
}
