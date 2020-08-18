import 'package:socket_io_client/socket_io_client.dart' as IO;

final IO.Socket socket = IO.io('http://192.168.88.250:4000', <String, dynamic>{
  'transports': ['websocket'],
  'autoConnect': false,
});

//http://10.0.2.2:4000
