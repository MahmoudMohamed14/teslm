import 'dart:io';

import 'package:delivery/common/components.dart';
import 'package:delivery/common/extensions.dart';
import 'package:delivery/common/images/images.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:delivery/features/profile/navigator/chat/widget/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'controller/chat_controller_cubit.dart';
import 'widget/send_message_part.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatControllerCubit, ChatControllerState>(
        listener: (context, state) {
      // if (state is ReloadChat) {
      //   Future.delayed(const Duration(milliseconds: 500), () {
      //     _scrollController.animateTo(
      //       _scrollController.position.maxScrollExtent,
      //       duration: const Duration(milliseconds: 500),
      //       curve: Curves.easeOut,
      //     );
      //   });
      // }
    }, builder: (context, state) {
      // var icon = Icons.camera_alt_rounded;
      var message = ChatControllerCubit.get(context).chatsCallCenter;
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: appBarWithIcons(Strings.callCenter.tr(context),
                ImagesApp.callCenterImage, true, context)),
        body: state is! GetChatCallCenterLoading && message != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  messages(message),
                  20.h.heightBox,
                  SendMessagePart(
                    chatId: message.id.toString(),
                  )
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      );
    });
  }

  late final File selectedImages;

  Future pickImageFromGallery(context) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    selectedImages = File(returnedImage.path);
    ChatControllerCubit.get(context).increment();
  }

  Future pickImageFromCamera(context) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    selectedImages = File(returnedImage.path);
    ChatControllerCubit.get(context).increment();
  }
}

String formatTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  int hour = dateTime.hour;
  int minute = dateTime.minute;

  String period = hour >= 12 ? 'PM' : 'AM';
  hour = hour % 12; // Convert to 12-hour format
  hour = hour == 0 ? 12 : hour; // Adjust hour for 12 AM

  return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
}
