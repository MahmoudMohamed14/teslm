import 'package:delivery/Utilities/helper_functions.dart';
import 'package:delivery/common/extensions.dart';
import 'package:delivery/features/profile/navigator/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../Utilities/FilesHandler/audio_player_widget.dart';
import '../../../../../common/colors/theme_model.dart';
import '../../../../../common/constant/constant values.dart';
import '../../../../../models/chat_model.dart';

Widget messages(ChatModel message) => ListView.builder(
      shrinkWrap: true,
      reverse: true,
      physics: const BouncingScrollPhysics(),
      itemCount: message.messages!.length,
      // reverse: true,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      itemBuilder: (context, index) {
        var messageEnd = message.messages!.length - 1 - index;
        // Get the current message's date
        DateTime currentMessageDate =
            DateTime.parse('${message.messages![messageEnd].createdAt}');
        bool showDate = false;
        if (index == message.messages!.length - 1) {
          showDate = true; // Show date for the first message
        } else {
          DateTime previousMessageDate = DateTime.parse(
              '${message.messages![messageEnd == 0 ? 0 : messageEnd - 1].createdAt}');
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
              padding:
                  const EdgeInsets.only(left: 7, right: 7, top: 7, bottom: 7),
              child: Align(
                  alignment: ((message.messages![messageEnd].from == null)
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Column(
                    crossAxisAlignment:
                        message.messages![messageEnd].from == null
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                    children: [
                      Text(
                        formatTime(
                            '${message.messages![messageEnd].createdAt}'),
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w400),
                      ),
                      message.messages![messageEnd].audioUrl != null
                          ? AudioPlayerWidget(
                              audioUrl:
                                  message.messages![messageEnd].audioUrl ?? "",
                            )
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ((message.messages![messageEnd].from ==
                                        null)
                                    ? ThemeModel.of(context).cardsColor
                                    : ThemeModel.mainColor),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (message.messages![messageEnd].imageUrls
                                      .isNotEmpty) ...[
                                    Wrap(
                                      spacing: 10.w,
                                      runSpacing: 10.h,
                                      children: message
                                          .messages![messageEnd].imageUrls
                                          .map((url) => InkWell(
                                                onTap: () {
                                                  HelperFunctions
                                                      .imagePreviewDialog(
                                                          context,
                                                          imagePath: url);
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                    url,
                                                    height: 120.r,
                                                    width: 120.r,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                    20.h.heightBox,
                                  ],
                                  Text(
                                    '${message.messages?[messageEnd].content}',
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: isDark ?? false
                                            ? Colors.white
                                            : message.messages![messageEnd]
                                                        .from ==
                                                    null
                                                ? Colors.black
                                                : Colors.white),
                                  ),
                                ],
                              )),
                    ],
                  )),
            ),
          ],
        );
      },
    ).expand;
