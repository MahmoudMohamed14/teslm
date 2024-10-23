import 'dart:convert';

import 'package:delivery/Utilities/shared_preferences.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'notification_display_handler.dart';

class SocketService {
  late IO.Socket _socket;

  // Connect and listen to notifications
  void connectAndSubscribe(String userId, String userType) {
    _socket = IO.io(
      'http://147.79.114.89:5053',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    // Connect to the server
    _socket.connect();

    // On connection success
    _socket.onConnect((_) {
      print('Connected to the server');

      String message = json.encode({
        'userId': userId,
        'userType': userType,
        "location": {"type": "Point", "coordinates": SharedPref.getLatLng()}
      });
      debugPrint(">>>>>>>>>>>>${message}");
      // Emit subscription event
      _socket.emit('subscribeToNotifications', message);
    });

    // Listen for subscription confirmation
    _socket.on('notificationSubscribed', (data) {
      if (data['success'] == true) {
        print('Subscription successful!');
      } else {
        print('Subscription failed!');
      }
    });

    // Listen for notifications
    _socket.on('notification', (data) {
      print('Notification received: $data');
      handleIncomingNotification(data);
    });

    // Handle disconnection
    _socket.onDisconnect((_) {
      print('Disconnected from the server');
    });
  }

  void handleIncomingNotification(Map<String, dynamic> data) {
    try {
      print("Language::::: $language");
      String title = data['title']?[language] ?? 'Notification';
      String body = data['body']?[language] ?? 'You have a new message';

      NotificationService.showNotification(1, title, body);
    } catch (e) {
      print("Error When show notification: $e");
    }
  }

  // Disconnect the socket
  void disconnect() {
    _socket.disconnect();
  }
}
