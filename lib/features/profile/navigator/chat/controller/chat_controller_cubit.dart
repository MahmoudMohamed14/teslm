import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../../Dio/Dio.dart';
import '../../../../../Utilities/FilesHandler/files_cubit.dart';
import '../../../../../common/constant/constant values.dart';
import '../../../../../models/chat_model.dart';

part 'chat_controller_state.dart';

class ChatControllerCubit extends Cubit<ChatControllerState> {
  ChatControllerCubit() : super(ChatControllerInitial()) {
    connectSocket();
  }
  static ChatControllerCubit get(context) => BlocProvider.of(context);
  void increment() {
    emit(Reload());
  }

  ChatModel? chatsCallCenter;

  void getChat() {
    emit(GetChatCallCenterLoading());
    DioHelper.getData(url: 'chats/me', token: token).then((value) {
      chatsCallCenter = ChatModel.fromJson(value.data);
      emit(GetChatCallCenterSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetChatCallCenterError());
    });
  }

  List<String> imagesUrls = [];
  Future sendImages(BuildContext context) async {
    imagesUrls =
        await BlocProvider.of<DragFilesCubit>(context).uploadSelectedImages();
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

  void postMessage(
      {required String message,
      required String chatId,
      required BuildContext context}) {
    print("SEND MESSAGE");
    // if (imagesProvider(context).isNotEmpty) {
    //   sendImages(context);
    // }
    // print(">>>>>>>>>>>>>>>>>>>>>>>> ${imagesUrls}");
    socket.emit("sendMessage", {
      'chatId': chatId,
      'from': '$customerId',
      'content': message,
    });
    print("SEND MESSAGE Done");
  }
}
