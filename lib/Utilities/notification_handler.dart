// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
//
// void startBackgroundService() {
//   FlutterBackgroundService().startService();
// }
//
// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//
//   service.onDataReceived.listen((event) {
//     if (event!["action"] == "stopService") {
//       service.stopBackgroundService();
//     }
//   });
//
//   service.onStart.listen((_) {
//     WebSocketChannel channel =
//         WebSocketChannel.connect(Uri.parse('wss://your-server-address'));
//
//     channel.stream.listen((message) {
//       // Handle your WebSocket messages here.
//       print("Received: $message");
//     });
//   });
//
//   service.startService();
// }
