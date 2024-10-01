import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Dio/Dio.dart';
import '../../../../../common/constant/constant values.dart';
import '../../../../../models/chat_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
part 'chat_controller_state.dart';

class ChatControllerCubit extends Cubit<ChatControllerState> {
  ChatControllerCubit() : super(ChatControllerInitial()){
    connectSocket();
  }
  static ChatControllerCubit get(context) => BlocProvider.of(context);

  ChatModel? chatsCallCenter;
  void getChat() {
    emit(GetChatCallCenterLoading());
    DioHelper.getData(url: 'chats/me',token: token)
        .then((value) {
      chatsCallCenter=ChatModel.fromJson(value.data);
      emit(GetChatCallCenterSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetChatCallCenterError());
    });
  }
  Future<void> onNewMessage(dynamic message) async {
    if (chatsCallCenter != null && chatsCallCenter!.messages != null) {
        chatsCallCenter!.messages!.add(MessagesModel.fromJson(message));
        emit(ReloadChat());
        print(MessagesModel.fromJson(message));
    }
  }
  IO.Socket socket = IO.io(
    'http://147.79.114.89:5051',
    <String, dynamic>{
      'transports': ['websocket', 'polling'],
      'autoConnect': false,
    },
  );

  ChatModel? chat;

  void connectSocket() {
    socket.connect();

    socket.onConnect((_) {
      print('Connection established');
      socket.emit("joinChat", {"customerId": customerId});
    });

    socket.on("joinedChat", (data) {
      print("Joined chat: $data");
      chat = ChatModel.fromJson(data); // Assuming you have a Chat model
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
