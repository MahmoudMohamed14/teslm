import 'dart:io';

import 'package:delivery/common/colors/theme_model.dart';
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

import '../../../../Utilities/FilesHandler/files_cubit.dart';
import '../../../../Utilities/FilesHandler/images_in_board.dart';
import '../../../../common/constant/constant values.dart';
import 'controller/chat_controller_cubit.dart';

class Chat extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Chat({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatControllerCubit, ChatControllerState>(
        listener: (context, state) {
      if (state is ReloadChat) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        });
      }
    }, builder: (context, state) {
      TextEditingController messageController = TextEditingController();
      bool langEn = true;
      final RegExp english = RegExp(r'^[a-zA-Z]+');
      var icon = Icons.camera_alt_rounded;
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ///    ---------------   Images in board  ---------------
                        const ImagesInBoardWidget(),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ThemeModel.of(context).chatTextField),
                          padding: const EdgeInsets.only(
                              left: 10, bottom: 3, top: 3),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (language == 'en')
                                const SizedBox(
                                  width: 15,
                                ),
                              Expanded(
                                child: StatefulBuilder(
                                  builder: (context, setState) => TextField(
                                    onChanged: (val) {
                                      setState(() {
                                        if (english.hasMatch(val)) {
                                          langEn = true;
                                        } else {
                                          langEn = false;
                                        }
                                        if (messageController.text == '' &&
                                            BlocProvider.of<DragFilesCubit>(
                                                    context)
                                                .images
                                                .isEmpty) {
                                          icon = Icons.camera_alt_rounded;
                                        } else {
                                          icon = Icons.send;
                                        }
                                      });
                                    },
                                    minLines: 1,
                                    maxLines: 3,
                                    textDirection: langEn
                                        ? TextDirection.ltr
                                        : TextDirection.rtl,
                                    controller: messageController,
                                    decoration: InputDecoration(
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              if (icon ==
                                                  Icons.camera_alt_rounded) {
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder:
                                                        (context) => SizedBox(
                                                              height: 100,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        20.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        pickFileProvider(
                                                                          context,
                                                                          multiImages:
                                                                              true,
                                                                        );
                                                                        // pickImageFromGallery(
                                                                        //     context);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            90,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          color:
                                                                              ThemeModel.mainColor,
                                                                        ),
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            const Icon(
                                                                              Icons.file_copy_outlined,
                                                                              color: Colors.white,
                                                                            ),
                                                                            Text(
                                                                              Strings.file.tr(context),
                                                                              style: const TextStyle(color: Colors.white),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        pickFileProvider(
                                                                            context,
                                                                            multiImages:
                                                                                false,
                                                                            openCamera:
                                                                                true);
                                                                        // pickImageFromCamera(
                                                                        //     context);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            90,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          color:
                                                                              ThemeModel.mainColor,
                                                                        ),
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            const Icon(Icons.camera_alt_rounded,
                                                                                color: Colors.white),
                                                                            Text(
                                                                              Strings.camera.tr(context),
                                                                              style: const TextStyle(color: Colors.white),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ));
                                              } else if (icon == Icons.send) {
                                                ChatControllerCubit.get(context)
                                                    .postMessage(
                                                  context: context,
                                                  message: messageController
                                                      .text
                                                      .trim(),
                                                  chatId: '${message.id}',
                                                );
                                                messageController.clear();
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 500), () {
                                                  _scrollController.animateTo(
                                                    _scrollController.position
                                                        .maxScrollExtent,
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.easeOut,
                                                  );
                                                });
                                              }
                                            },
                                            child: CircleAvatar(
                                              radius: 14,
                                              backgroundColor:
                                                  ThemeModel.mainColor,
                                              child: Icon(icon,
                                                  color: Colors.white,
                                                  size: 22),
                                            ),
                                          ),
                                        ),
                                        hintText:
                                            Strings.writeMessage.tr(context),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              if (language != 'en')
                                const SizedBox(
                                  width: 10,
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
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
