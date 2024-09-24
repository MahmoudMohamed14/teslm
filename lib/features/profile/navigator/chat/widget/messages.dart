import 'package:delivery/common/extensions.dart';
import 'package:delivery/features/profile/navigator/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../common/colors/theme_model.dart';
import '../../../../../common/constant/constant values.dart';

Widget messages(message)=>ListView.builder(
  shrinkWrap: true,
  reverse: true,
  physics: const BouncingScrollPhysics(),
  itemCount: message.messages!.length,
  // reverse: true,
  padding:const EdgeInsets.only(top: 10, bottom: 10),
  itemBuilder: (context, index) {
    var messageEnd=message.messages!.length-1-index;
    // Get the current message's date
    DateTime currentMessageDate = DateTime.parse(
        '${message.messages![messageEnd].createdAt}');
    bool showDate = false;
    if (index == 0) {
      showDate = true; // Show date for the first message
    } else {
      DateTime previousMessageDate = DateTime.parse(
          '${message.messages![messageEnd + 1].createdAt}');
      showDate = currentMessageDate.day != previousMessageDate.day ||
          currentMessageDate.month != previousMessageDate.month ||
          currentMessageDate.year != previousMessageDate.year;
    }
    return Column(
      children: [
    if (showDate)
          Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
          DateFormat('MMM dd, yyyy').format(currentMessageDate),
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          ),
        Container(
          padding:const EdgeInsets.only(
              left: 7, right: 7, top: 7, bottom: 7),
          child: Align(
              alignment: ((message.messages![messageEnd].from==null)
                  ? Alignment.topLeft:Alignment.topRight
              ),
              child: Column(
                crossAxisAlignment:message.messages![messageEnd].from==null? CrossAxisAlignment.start :CrossAxisAlignment.end,
                children: [
                  Text(formatTime('${message.messages![messageEnd].createdAt}'),style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400),),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ((message.messages![messageEnd].from==null)
                            ? ThemeModel.of(context).cardsColor
                            : ThemeModel.mainColor),
                      ),
                      padding:const EdgeInsets.all(10),
                      child: Text(
                        '${message.messages?[messageEnd].content}',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: isDark ?? false
                                ? Colors.white
                                : message.messages![messageEnd].from==null? Colors.black:Colors.white),
                      )),
                ],
              )),
        ),
      ],
    );
  },
).expand;