import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:flutter/material.dart';
import '../../../common/colors/colors.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';

Widget checkList(isChecked,onChange,addNewName,price,extraImage,context)=> InkWell(
  onTap: onChange,
  child: Card(
    child: Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(border: isChecked?Border.all(color: mainColor.shade400,width:1.5):null,borderRadius: BorderRadius.circular(7)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                Strings.sar.tr(context), maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: isDark??false? floatActionColor:brownColor),
              ),
              const SizedBox(width: 5,),
              Text(
                '$price+', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: isDark??false? floatActionColor:brownColor),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                addNewName, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: isDark??false? floatActionColor:brownColor),
              ),
              const SizedBox(width: 7,),
              image('$extraImage', 30.0, 30.0, 30.0,BoxFit.fill),
            ],
          ),
        ],
      ),
    ),
  ),
);