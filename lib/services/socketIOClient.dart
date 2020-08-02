import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final IO.Socket socket = IO.io('http://10.0.2.2:4000', <String, dynamic>{
  'transports': ['websocket'],
  'autoConnect': false,
});

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
