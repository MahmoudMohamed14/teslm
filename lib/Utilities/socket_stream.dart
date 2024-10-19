import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

// STEP1:  Stream setup
class StreamSocket {
  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

StreamSocket streamSocket = StreamSocket();

//STEP2: Add this function in main function in main.dart file and add incoming data to the stream
void connectAndListen() {
  IO.Socket socket = IO.io('http://237.84.2.178:5053',
      OptionBuilder().setTransports(['websocket']).build());

  socket.onConnect((_) {
    print('connect');
    socket.emit('subscribeToNotifications', {
      'userId': '3bafe951-d971-4728-93cf-1bc0314c7627',
      'userType': 'CUSTOMER'
    });
  });

  //When an event received from server, data is added to the stream
  socket.on('notification', (data) {
    print('notification:....... $data');
    return streamSocket.addResponse;
  });
  socket.onDisconnect((_) => print('disconnect'));
}

//Step3: Build widgets with StreamBuilder

class BuildWithSocketStream extends StatelessWidget {
  const BuildWithSocketStream({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: streamSocket.getResponse,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return Container(
            child: Text("${snapshot.data}"),
          );
        },
      ),
    );
  }
}
