import 'package:flutter/material.dart';

class LoadingChat extends ChangeNotifier {
  bool loadingChat = true;

  void startLoadingChat() {
    loadingChat = true;
    notifyListeners();
  }

  void stopLoadingChat() {
    loadingChat = false;
    notifyListeners();
  }
}
