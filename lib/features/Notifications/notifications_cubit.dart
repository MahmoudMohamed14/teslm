import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class NotificationCubit extends Cubit<String> {
  static NotificationCubit get(context) => BlocProvider.of(context);
  NotificationCubit() : super('') {
    _initializeSocket();
  }

  final String serverUrl = 'http://147.79.114.89:5053';
  late IO.Socket socket;

  // Initialize and configure the socket connection
  void _initializeSocket() {
    socket = IO.io(
      serverUrl,
      <String, dynamic>{
        'transports': ['websocket', 'polling'],
        'autoConnect': false,
      },
    );
  }

  // Method to connect to the server and subscribe to notifications
  void subscribeToNotifications(
      {required String userId, required String userType}) {
    socket.connect();

    // Event handler for successful connection
    socket.onConnect((_) {
      debugPrint('Connection established to notification server');
      // Emit the subscribeToNotifications event with the required data
      socket.emit('subscribeToNotifications', {
        'userId': userId,
        'userType': userType,
      });
    });

    // Listen for notifications on a specific event based on userType and userId
    const notificationEvent = 'notification';
    socket.on(notificationEvent, (data) {
      debugPrint('Received notification: $data');
      // Emit the incoming notification data to the Cubit state
      emit(data.toString());
    });
    print("notification event .......>>> $notificationEvent");
    // Listen for notifications on a specific event based on userType and userId
    listenToNotifications(userId: userId, userType: userType);
    // Handle connection errors
    socket.onConnectError((data) {
      debugPrint('Connect Error: $data');
      emit('Connect Error: $data');
    });

    // Handle disconnection
    socket.onDisconnect((_) {
      debugPrint('Notification server disconnected');
      emit('Notification server disconnected');
    });
  }

  // Method to listen to incoming notifications from the server
  void listenToNotifications(
      {required String userId, required String userType}) {
    print("listenToNotifications ..................<<>>");
    // Listen to the 'notification' event
    socket.emit('notification', {
      'userId': userId,
      'userType': userType,
    });
    print("listen To Notifications <<<<<<<<<..................<<>>");
    // socket.on("notification", (data) {
    //   debugPrint("Received notification: $data");
    //
    //   // Process the notification data
    //   // For example, emit a new state in your Cubit or update your UI
    //   // emit(NotificationReceivedState(notification: NotificationModel.fromJson(data)));
    // });
  }

  // Method to disconnect the socket
  void disconnectSocket() {
    socket.disconnect();
    debugPrint('Socket disconnected from notification server');
    emit('Socket disconnected from notification server');
  }

  // Close the socket connection when the Cubit is closed
  @override
  Future<void> close() {
    disconnectSocket();
    return super.close();
  }
}
