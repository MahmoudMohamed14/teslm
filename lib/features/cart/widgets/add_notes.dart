import 'package:delivery/common/colors/theme_model.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:flutter/material.dart';

final RegExp english = RegExp(r'^[a-zA-Z]+');
bool langEn=true;
Widget addNotes(noteTextController)=>StatefulBuilder(
  builder:(context,setState)=> TextFormField(
    textDirection:langEn ? TextDirection.ltr :TextDirection.rtl ,
    maxLines: 4,
    minLines: 4,
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none),
      labelText:Strings.addNotes.tr(context),
      alignLabelWithHint: true,
      filled: true, // Fills the background color for better visibility
      fillColor: ThemeModel.of(context).cardsColor,
    ),
    controller: noteTextController,
    onChanged: (text) {
      setState(() {
        if (english.hasMatch(text)) {
          langEn = true;
        } else {
          langEn = false;
        }
      });
    },
  ),
);