import 'dart:convert';

import 'package:delivery/Utilities/shared_preferences.dart';
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
    DioHelper.getData(url: 'chats/me', token: SharedPref.getToken())
        .then((value) {
      chatsCallCenter = ChatModel.fromJson(value.data);
      debugPrint("Chat Data >>>>>>>>.  ${value.data.toString()}");
      chatsCallCenter?.messages?.forEach(
          (message) => debugPrint("Chat Data >>>>>>>>.  ${message.toJson()}"));
      emit(GetChatCallCenterSuccess());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetChatCallCenterError());
    });
  }

  Future sendImages(BuildContext context) async {
    await BlocProvider.of<DragFilesCubit>(context).uploadSelectedImages();
    debugPrint(
        "Images Urls 11111111>>>>>>>>>> ${BlocProvider.of<DragFilesCubit>(context).imageUrls.length}");
  }

  Future<void> onNewMessage(dynamic message) async {
    if (chatsCallCenter != null && chatsCallCenter!.messages != null) {
      chatsCallCenter!.messages!.add(MessagesModel.fromJson(message));
      emit(ReloadChat());
      debugPrint(
          "Message >>>>>>>  ${MessagesModel.fromJson(message).toString()}");
    }
  }

  IO.Socket socket = IO.io(
    'http://147.79.114.89:5051',
    <String, dynamic>{
      'transports': ['websocket', 'polling'],
      'autoConnect': false,
    },
  );

  // ChatModel? chat;

  void connectSocket() {
    socket.connect();

    socket.onConnect((_) {
      debugPrint('Connection established');
      socket.emit("joinChat", json.encode({"customerId": customerId}));
    });

    socket.on("joinedChat", (data) {
      emit(GetChatCallCenterLoading());
      debugPrint("Joined chat: $data");
      chatsCallCenter =
          ChatModel.fromJson(data); // Assuming you have a Chat model
      emit(GetChatCallCenterSuccess());
      // emit(ReloadChat());
    });

    socket.on('newMessage', (data) {
      print("New Message:>>>>>>>> $data");
      onNewMessage(data);
    });

    socket.onConnectError((data) => debugPrint('Connect Error: $data'));
    socket.onDisconnect((_) => debugPrint('Socket.IO server disconnected'));
  }

  void postMessage(
      {String? message,
      required String chatId,
      required BuildContext context,
      String? audioUrl}) async {
    debugPrint("SEND MESSAGE>>>>>. $chatId");
    if (audioUrl != null) {
      String messageBody = json.encode({
        'chatId': chatId,
        'from': '$customerId',
        'content': message,
        'audioUrl': audioUrl
      });
      socket.emit("sendMessage", messageBody);
      return;
    }
    if (imagesProvider(context).isNotEmpty) {
      await sendImages(context).then((e) {
        String messageBody = json.encode({
          'chatId': chatId,
          'from': '$customerId',
          'content': message,
          'audioUrl': '',
          'imageUrls': BlocProvider.of<DragFilesCubit>(context)
              .imageUrls
              .map((e) => e.toString())
              .toList()
        });
        debugPrint(
            ">>>>>>>>>>>>>>>>>>>>>>>> ${BlocProvider.of<DragFilesCubit>(context).imageUrls}");
        socket.emit("sendMessage", messageBody);
        BlocProvider.of<DragFilesCubit>(context).clearUrls();
        return;
      });
    } else {
      String messageBody = json.encode({
        'chatId': chatId,
        'from': '$customerId',
        'content': message,
      });
      if (message == null) return;
      socket.emit("sendMessage", messageBody);
    }
    debugPrint("SEND MESSAGE Done");
  }
}
