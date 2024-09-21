import 'dart:io';
import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../common/constant values.dart';
import 'controller/chat_controller_cubit.dart';

class Chat extends StatelessWidget {
  Chat({super.key});

  TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void sendMessage() {
    var message = messageController.text.trim();
    if (message.isNotEmpty) {
      ChatControllerCubit().postMessage(
          message: message, chatId: 'ab0d6bc4-9066-49bc-bfbc-ae3d5bacad13');
      messageController.clear();
      print(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatControllerCubit, ChatControllerState>(
        listener: (context, state) {
          if (state is ReloadChat){
            Future.delayed(
                Duration(milliseconds: 500),
                    () {
                  _scrollController.animateTo(
                    _scrollController.position
                        .maxScrollExtent,
                    duration: Duration(
                        milliseconds: 500),
                    curve: Curves.easeOut,
                  );
                });

          }
        },
        builder: (context, state) {
          TextEditingController messageController = TextEditingController();
          var chatData = ChatControllerCubit.get(context).chat;
          bool langEn = true;
          final RegExp english = RegExp(r'^[a-zA-Z]+');
          List<Map<String, dynamic>> dataList = [];
          var icon = Icons.camera_alt_rounded;
          var message = ChatControllerCubit.get(context).chatsCallCenter;
          print('ssssssssssssssssssssssss');
          print(message?.messages?.length ?? 0);
          print('zzzzzzzzzzzzzzzzzzzzzzzzzzzz');
          int messageCount = message?.messages?.length ?? 0;
          return Scaffold(
            appBar: AppBar(
              title: Center(
                  child: Text(
                language == 'English Language' ? 'Call Center' : 'خدمة العملاء',
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
              elevation: 0,
              leading: BackButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: state is! GetChatCallCenterLoading && message != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        physics: BouncingScrollPhysics(),
                        itemCount: message.messages!.length,
                       // reverse: true,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(
                                left: 7, right: 7, top: 7, bottom: 7),
                            child: Align(
                                alignment: ((true)
                                    ? Alignment.topLeft
                                    : Alignment.topRight),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ((true)
                                          ? isDark ?? false
                                              ? Colors.grey.shade900
                                              : Colors.grey.shade400
                                          : mainColor),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      '${message.messages?[index].content}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: isDark ?? false
                                              ? Colors.white
                                              : Colors.black87),
                                    ))),
                          );
                        },
                      ).expand,
                      /*Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                       // Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: message.messages!.length,
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.only(left: 7, right: 7, top: 7, bottom: 7),
                                child: Align(
                                    alignment: ((true) ? Alignment.topLeft : Alignment.topRight),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: ((true) ?isDark??false? Colors.grey.shade900:Colors.grey.shade400 : mainColor),
                                        ),
                                        padding: EdgeInsets.all(10),
                                        child: Text('${message.messages?[index].content}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:isDark??false? Colors.white:Colors.black87),)
                                    )
                                ),
                              );
                            },
                          ),
                        ),
                        */ /*Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color:isDark??false? Colors.grey.shade900:Colors.black12),
                            padding: EdgeInsets.only(left: 10, bottom: 3, top: 3),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if(language=='English Language')
                                  SizedBox(width: 15,),
                                Expanded(
                                  child: StatefulBuilder(
                                    builder:(context,setState)=> TextField(
                                      onChanged: (val){
                                        setState(() {
                                          if (english.hasMatch(val)) {
                                            langEn = true;
                                          } else {
                                            langEn = false;
                                          }
                                          if(messageController.text==''){
                                            icon =Icons.camera_alt_rounded;
                                          }else{
                                            icon= Icons.send;
                                          }
                                          print(messageController.text);
                                        });
                                      },
                                      minLines: 1,
                                      maxLines: 3,

                                      textDirection: langEn ? TextDirection.ltr : TextDirection.rtl ,
                                      controller: messageController,
                                      decoration: InputDecoration(
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: (){
                                                if(icon==Icons.camera_alt_rounded){
                                                  showModalBottomSheet(context: context, builder:(context)=> Container(height: 100,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(20.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          InkWell(
                                                            onTap:(){pickImageFromGallery(context);},
                                                            child: Container(
                                                              width:90,
                                                              decoration:BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10),
                                                                color: mainColor,),
                                                              padding: EdgeInsets.all(8),
                                                              child: Column(children: [
                                                                Icon(Icons.file_copy_outlined,color: Colors.white,),
                                                                Text(language=='English Language'?'File':'ملف',style: TextStyle(color: Colors.white),)
                                                              ],),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: (){pickImageFromCamera(context);},
                                                            child: Container(
                                                              width: 90,
                                                              decoration:BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10),
                                                                color: mainColor,),
                                                              padding: EdgeInsets.all(8),
                                                              child: Column(children: [
                                                                Icon(Icons.camera_alt_rounded,color: Colors.white),
                                                                Text(language=='English Language'?'Camera':'الكاميرا',style: TextStyle(color: Colors.white),)
                                                              ],),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),));
                                                }else if(icon==Icons.send){
                                                  ChatControllerCubit.get(context).postMessage(
                                                    message: messageController.text.trim(),
                                                    chatId :'${message.id}',
                                                  );
                                                  messageController.clear();
                                                }
                                              },
                                              child: CircleAvatar(
                                                radius: 14,
                                                child: Icon(icon, color: Colors.white, size: 22),
                                                backgroundColor: mainColor,
                                              ),
                                            ),
                                          ),
                                          hintText: language=='English Language'?"Write message...":"اكتب رساله...",
                                          border: InputBorder.none
                                      ),
                                    ),
                                  ),
                                ),
                                if(language!='English Language')
                                  SizedBox(width: 10,)
                              ],
                            ),
                          ),
                        ),*/ /*
                      ],
                    ),
                  ),
                ),*/
                      20.h.heightBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: isDark ?? false
                                  ? Colors.grey.shade900
                                  : Colors.black12),
                          padding: EdgeInsets.only(left: 10, bottom: 3, top: 3),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (language == 'English Language')
                                SizedBox(
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
                                        if (messageController.text == '') {
                                          icon = Icons.camera_alt_rounded;
                                        } else {
                                          icon = Icons.send;
                                        }
                                        print(messageController.text);
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
                                                        (context) => Container(
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
                                                                        pickImageFromGallery(
                                                                            context);
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
                                                                              mainColor,
                                                                        ),
                                                                        padding:
                                                                            EdgeInsets.all(8),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Icon(
                                                                              Icons.file_copy_outlined,
                                                                              color: Colors.white,
                                                                            ),
                                                                            Text(
                                                                              language == 'English Language' ? 'File' : 'ملف',
                                                                              style: TextStyle(color: Colors.white),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        pickImageFromCamera(
                                                                            context);
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
                                                                              mainColor,
                                                                        ),
                                                                        padding:
                                                                            EdgeInsets.all(8),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Icon(Icons.camera_alt_rounded,
                                                                                color: Colors.white),
                                                                            Text(
                                                                              language == 'English Language' ? 'Camera' : 'الكاميرا',
                                                                              style: TextStyle(color: Colors.white),
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
                                                  message: messageController
                                                      .text
                                                      .trim(),
                                                  chatId: '${message?.id}',
                                                );
                                                messageController.clear();
                                                Future.delayed(
                                                    Duration(milliseconds: 500),
                                                    () {
                                                  _scrollController.animateTo(
                                                    _scrollController.position
                                                        .maxScrollExtent,
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.easeOut,
                                                  );
                                                });
                                              }
                                            },
                                            child: CircleAvatar(
                                              radius: 14,
                                              child: Icon(icon,
                                                  color: Colors.white,
                                                  size: 22),
                                              backgroundColor: mainColor,
                                            ),
                                          ),
                                        ),
                                        hintText: language == 'English Language'
                                            ? "Write message..."
                                            : "اكتب رساله...",
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              if (language != 'English Language')
                                SizedBox(
                                  width: 10,
                                )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            /* floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color:isDark??false? Colors.grey.shade900:Colors.black12),
                padding: EdgeInsets.only(left: 10, bottom: 3, top: 3),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if(language=='English Language')
                      SizedBox(width: 15,),
                    Expanded(
                      child: StatefulBuilder(
                        builder:(context,setState)=> TextField(
                          onChanged: (val){
                            setState(() {
                              if (english.hasMatch(val)) {
                                langEn = true;
                              } else {
                                langEn = false;
                              }
                              if(messageController.text==''){
                                icon =Icons.camera_alt_rounded;
                              }else{
                                icon= Icons.send;
                              }
                              print(messageController.text);
                            });
                          },
                          minLines: 1,
                          maxLines: 3,

                          textDirection: langEn ? TextDirection.ltr : TextDirection.rtl ,
                          controller: messageController,
                          decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: (){
                                    if(icon==Icons.camera_alt_rounded){
                                      showModalBottomSheet(context: context, builder:(context)=> Container(height: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap:(){pickImageFromGallery(context);},
                                                child: Container(
                                                  width:90,
                                                  decoration:BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: mainColor,),
                                                  padding: EdgeInsets.all(8),
                                                  child: Column(children: [
                                                    Icon(Icons.file_copy_outlined,color: Colors.white,),
                                                    Text(language=='English Language'?'File':'ملف',style: TextStyle(color: Colors.white),)
                                                  ],),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){pickImageFromCamera(context);},
                                                child: Container(
                                                  width: 90,
                                                  decoration:BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: mainColor,),
                                                  padding: EdgeInsets.all(8),
                                                  child: Column(children: [
                                                    Icon(Icons.camera_alt_rounded,color: Colors.white),
                                                    Text(language=='English Language'?'Camera':'الكاميرا',style: TextStyle(color: Colors.white),)
                                                  ],),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),));
                                    }else if(icon==Icons.send){
                                      ChatControllerCubit.get(context).postMessage(
                                        message: messageController.text.trim(),
                                        chatId :'${message?.id}',
                                      );
                                      messageController.clear();
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 14,
                                    child: Icon(icon, color: Colors.white, size: 22),
                                    backgroundColor: mainColor,
                                  ),
                                ),
                              ),
                              hintText: language=='English Language'?"Write message...":"اكتب رساله...",
                              border: InputBorder.none
                          ),
                        ),
                      ),
                    ),
                    if(language!='English Language')
                      SizedBox(width: 10,)
                  ],
                ),
              ),
            ),*/
          );
        });
  }

  var selectedImages;

  Future pickImageFromGallery(context) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    selectedImages = File(returnedImage.path);
    DeliveryCubit.get(context).increment();
  }

  Future pickImageFromCamera(context) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    selectedImages = File(returnedImage.path);
    DeliveryCubit.get(context).increment();
  }
}
