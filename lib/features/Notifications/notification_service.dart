import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebSocketService {
  late IO.Socket socket;

  void connect() {
    try {
      // Connect to the WebSocket server
      socket = IO.io('http://147.79.114.89:5053', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      // Listen to connection events
      socket.onConnect((_) {
        print('Connected to WebSocket server');
        // Subscribe to notifications
        subscribeToNotifications();
      });

      socket.onConnectError((data) {
        print('Connection Error: $data');
      });

      socket.onError((data) {
        print('Socket Error: $data');
      });

      socket.onDisconnect((_) {
        print('Disconnected from WebSocket server');
      });

      // Listen to custom events from the server
      socket.on('notification', (data) {
        print('Notification received: $data');
        _handleNotification(data);
      });

      socket.on('notificationSubscribed', (data) {
        print('Subscription status: $data');
      });

      // Listen for the response of the subscribeToNotifications event
      socket.on('subscribeToNotifications', (data) {
        print('Response for subscribeToNotifications: $data');
      });

      // Manually connect the socket
      socket.connect();
    } catch (e) {
      print('Error while connecting to WebSocket: $e');
    }
  }

  void subscribeToNotifications() {
    try {
      final Map<String, dynamic> subscriptionData = {
        'userId': '57d33393-582b-4772-86c4-0aa05b9969d8',
        'userType': 'CUSTOMER',
      };

      socket.emit('subscribeToNotifications', subscriptionData);
      print('Subscription request sent to WebSocket server');
    } catch (e) {
      print('Error while sending subscription request: $e');
    }
  }

  void _handleNotification(dynamic data) {
    try {
      // Parse the incoming notification data
      final notificationData = data as Map<String, dynamic>;
      final notificationId = notificationData['id'];
      final notificationType = notificationData['type'];
      final notificationTitle = notificationData['title'];
      final notificationBody = notificationData['body'];

      print('Notification ID: $notificationId');
      print('Notification Type: $notificationType');
      print('Notification Title: $notificationTitle');
      print('Notification Body: $notificationBody');
    } catch (e) {
      print('Error while handling notification data: $e');
    }
  }

  void disconnect() {
    try {
      socket.disconnect();
      print('WebSocket connection closed.');
    } catch (e) {
      print('Error closing WebSocket connection: $e');
    }
  }
}
