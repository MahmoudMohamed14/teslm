import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket? socket;

  void initializeSocket() {
    // Connect to the WebSocket server
    socket = IO.io('ws://147.79.114.89:5053', <String, dynamic>{
      'transports': ['websocket', 'polling'],
      'autoConnect': false,
    });

    // Connect the socket
    socket?.connect();

    // Listen for the 'connect' event
    socket?.on('connect', (_) {
      print('Connected to WebSocket server');
    });

    // Listen for the 'disconnect' event
    socket?.on('disconnect', (_) {
      print('Disconnected from WebSocket server');
    });

    // Listen for 'notification' event
    socket?.on('notification', (data) {
      print('Notification received: $data');
      handleNotification(data);
    });

    // Listen for 'notificationSubscribed' event
    socket?.on('notificationSubscribed', (data) {
      print('Notification Subscribed: $data');
      // Handle this event
    });

    // Listen for 'subscribeToNotifications' event
    socket?.on('subscribeToNotifications', (data) {
      print('Subscribed to notifications: $data');
      // Handle this event
    });

    // Emit subscription request if needed
    socket?.emit('subscribeToNotifications', {
      'userId': '3bafe951-d971-4728-93cf-1bc0314c7627',
      'userType': 'CUSTOMER'
    });
  }

  // Handle the notification
  void handleNotification(dynamic data) {
    try {
      final Map<String, dynamic> notification = jsonDecode(data);

      String id = notification['id'];
      String type = notification['type'];
      Map<String, dynamic> title = notification['title'];
      String titleEn = title['en'];
      String titleAr = title['ar'];

      print('ID: $id');
      print('Type: $type');
      print('Title (EN): $titleEn');
      print('Title (AR): $titleAr');

      // Handle the notification (e.g., show a dialog or update UI)
    } catch (e) {
      print('Error parsing notification: $e');
    }
  }

  void dispose() {
    socket?.dispose();
  }
}
