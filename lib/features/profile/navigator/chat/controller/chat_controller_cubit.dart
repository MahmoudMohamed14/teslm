import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Dio/Dio.dart';
import '../../../../../common/constant/constant values.dart';
import '../../../../../models/chat model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
part 'chat_controller_state.dart';

class ChatControllerCubit extends Cubit<ChatControllerState> {
  ChatControllerCubit() : super(ChatControllerInitial()){
    connectSocket();
  }
  static ChatControllerCubit get(context) => BlocProvider.of(context);

  Chat? chatsCallCenter;
  void getChat() {
    emit(GetChatCallCenterLoading());
    DioHelper.getData(url: 'chats/me', myapp: true,token: token)
        .then((value) {
      chatsCallCenter=Chat.fromJson(value.data);
      print(value.data);
      emit(GetChatCallCenterSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetChatCallCenterError());
    });
  }
  Future<void> onNewMessage(dynamic message) async {
    if (chatsCallCenter != null && chatsCallCenter!.messages != null) {
        chatsCallCenter!.messages!.add(Messages.fromJson(message));
        emit(ReloadChat());
        print(Messages.fromJson(message));
    }
  }
  IO.Socket socket = IO.io(
    'http://147.79.114.89:5051',
    <String, dynamic>{
      'transports': ['websocket', 'polling'],
      'autoConnect': false,
    },
  );

  Chat? chat;

  void connectSocket() {
    socket.connect();

    socket.onConnect((_) {
      print('Connection established');
      socket.emit("joinChat", {"customerId": customerId});
    });

    socket.on("joinedChat", (data) {
      print("Joined chat: $data");
      chat = Chat.fromJson(data); // Assuming you have a Chat model
    });

    socket.on('newMessage', (data) {
      onNewMessage(data);
    });

    socket.onConnectError((data) => print('Connect Error: $data'));
    socket.onDisconnect((_) => print('Socket.IO server disconnected'));
  }
  void postMessage({
    required String message ,
    required String chatId ,
  }){
    socket.emit("sendMessage", {
      'chatId': '$chatId',
      'from':'$customerId',
      'content': '$message',
    });
  }
}
