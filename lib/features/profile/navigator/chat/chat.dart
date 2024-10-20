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
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import '../../../../Utilities/FilesHandler/files_cubit.dart';
import '../../../../Utilities/FilesHandler/files_states.dart';
import '../../../../Utilities/FilesHandler/images_in_board.dart';
import '../../../../common/constant/constant values.dart';
import 'controller/chat_controller_cubit.dart';

Future<void> _requestPermissions() async {
  // Request microphone permission for recording audio
  PermissionStatus microphoneStatus = await Permission.microphone.request();

  // Request storage permission (for Android 11+, MANAGE_EXTERNAL_STORAGE permission is needed)
  PermissionStatus storageStatus = await Permission.storage.request();

  if (microphoneStatus.isGranted && storageStatus.isGranted) {
    print('Permissions granted');
  } else {
    print('Permissions denied');
    // Handle permission denied case
  }
}

class Chat extends StatefulWidget {
  Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  void initState() {
    _requestPermissions();
    super.initState();
  }

  final TextEditingController messageController = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;

  Future<void> _startRecording() async {
    await Permission.storage.request().then((value) async {
      // var status = await Permission.storage.status;
      if (value.isDenied) {
        print('Permission Handler denied');
        // We haven't asked for permission yet or the permission has been denied before, but not permanently.
      } else {
        final Directory? downloadsDir = await getTemporaryDirectory();
        if (downloadsDir == null) {
          return;
        }
        print('Permission granted>>>>>>>>>>>  ${downloadsDir.path}');
        if (await _audioRecorder.hasPermission()) {
          await _audioRecorder.start(
            const RecordConfig(),
            path:
                "${downloadsDir.path}/recorded_audio${DateTime.now().millisecondsSinceEpoch}.mp3",
          );
          setState(() {
            _isRecording = true;
          });
        } else {
          // Handle permission denied
          print('Permission denied');
        }
      }
    });
  }

  Future<void> _stopRecording() async {
    final path = await _audioRecorder.stop();
    if (path == null) return;
    BlocProvider.of<DragFilesCubit>(context).uploadRecord(path);
    setState(() {
      _isRecording = false;
    });

    // Do something with the audio file, for example, upload or play
    print('Recording saved at: $path');
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    super.dispose();
  }

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
                                                if (messageController.text ==
                                                        '' &&
                                                    BlocProvider.of<
                                                                DragFilesCubit>(
                                                            context)
                                                        .images
                                                        .isEmpty) {
                                                  icon =
                                                      Icons.camera_alt_rounded;
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
                                              prefixIcon: _isRecording
                                                  ? null
                                                  : InkWell(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    SizedBox(
                                                                      height:
                                                                          100,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            20.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children: [
                                                                            InkWell(
                                                                              onTap: () {
                                                                                Navigator.of(context).pop();
                                                                                pickFileProvider(
                                                                                  context,
                                                                                  multiImages: true,
                                                                                );
                                                                                // pickImageFromGallery(
                                                                                //     context);
                                                                              },
                                                                              child: Container(
                                                                                width: 90,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  color: ThemeModel.mainColor,
                                                                                ),
                                                                                padding: const EdgeInsets.all(8),
                                                                                child: Column(
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
                                                                              onTap: () {
                                                                                Navigator.of(context).pop();
                                                                                pickFileProvider(context, multiImages: false, openCamera: true);
                                                                                // pickImageFromCamera(
                                                                                //     context);
                                                                              },
                                                                              child: Container(
                                                                                width: 90,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  color: ThemeModel.mainColor,
                                                                                ),
                                                                                padding: const EdgeInsets.all(8),
                                                                                child: Column(
                                                                                  children: [
                                                                                    const Icon(Icons.camera_alt_rounded, color: Colors.white),
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
                                                      },
                                                      child: const CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor:
                                                            ThemeModel
                                                                .mainColor,
                                                        child: Icon(
                                                            Icons
                                                                .camera_alt_rounded,
                                                            color: Colors.white,
                                                            size: 26),
                                                      ),
                                                    ),
                                              suffixIcon:
                                                  BlocConsumer<DragFilesCubit,
                                                          FilesStates>(
                                                      listener:
                                                          (context, state) {},
                                                      builder:
                                                          (context, state) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              messageController
                                                                      .text
                                                                      .isEmpty
                                                                  ? InkWell(
                                                                      overlayColor:
                                                                          WidgetStateProperty.all(
                                                                              Colors.transparent),
                                                                      onTap: _isRecording
                                                                          ? _stopRecording
                                                                          : _startRecording,
                                                                      child:
                                                                          CircleAvatar(
                                                                        backgroundColor: _isRecording
                                                                            ? Colors.white
                                                                            : ThemeModel.mainColor,
                                                                        radius:
                                                                            20,
                                                                        child: BlocProvider.of<DragFilesCubit>(context).startUploadRecord
                                                                            ? const Padding(
                                                                                padding: EdgeInsets.all(8.0),
                                                                                child: Center(
                                                                                    child: CircularProgressIndicator(
                                                                                  color: Colors.white,
                                                                                )),
                                                                              )
                                                                            : _isRecording
                                                                                ? Image.asset(
                                                                                    "assets/images/recorder.gif",
                                                                                    color: Colors.red,
                                                                                    width: 26,
                                                                                    height: 26,
                                                                                  )
                                                                                : const Center(
                                                                                    child: Icon(Icons.mic, color: Colors.white, size: 26),
                                                                                  ),
                                                                      ),
                                                                    )
                                                                  : InkWell(
                                                                      onTap:
                                                                          () {
                                                                        ChatControllerCubit.get(context)
                                                                            .postMessage(
                                                                          context:
                                                                              context,
                                                                          message: messageController
                                                                              .text
                                                                              .trim(),
                                                                          chatId:
                                                                              '${message.id}',
                                                                        );
                                                                        messageController
                                                                            .clear();
                                                                        Future.delayed(
                                                                            const Duration(milliseconds: 500),
                                                                            () {
                                                                          _scrollController
                                                                              .animateTo(
                                                                            _scrollController.position.maxScrollExtent,
                                                                            duration:
                                                                                const Duration(milliseconds: 500),
                                                                            curve:
                                                                                Curves.easeOut,
                                                                          );
                                                                        });
                                                                      },
                                                                      child:
                                                                          const CircleAvatar(
                                                                        radius:
                                                                            20,
                                                                        backgroundColor:
                                                                            ThemeModel.mainColor,
                                                                        child: Icon(
                                                                            Icons
                                                                                .send,
                                                                            color:
                                                                                Colors.white,
                                                                            size: 26),
                                                                      ),
                                                                    ),
                                                        );
                                                      }),
                                            ),
                                          ))),
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
