import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:flutter/material.dart';
import '../../../common/colors/colors.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';

Widget menuItems(onTap,canAdd,provider,context,onTheImage)
{
  return SizedBox(
    height: 135,
    child: Row(children: [
      Expanded(
        child: Column(
          crossAxisAlignment:  CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8),
              child: Text(
                language=='en'?'${provider.name.en}':'${provider.name.ar}', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: isDark??false? floatActionColor:brownColor.shade400),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:8.0,right: 8),
              child: Text(
                textDirection: language=='en'? TextDirection.ltr:TextDirection.rtl, // Set the text direction to right-to-left
                language=='en'? '${provider.description.en}':'${provider.description.ar}',
                style: TextStyle(color: isDark??false? floatActionColor:borderColor), maxLines: 2, overflow: TextOverflow.ellipsis,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  Strings.calories.tr(context), maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                  style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: isDark??false? floatActionColor:brownColor.shade300),
                ),SizedBox(width: 5,),
                Text(
                  '${provider.calories}', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                  style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: isDark??false? floatActionColor:brownColor.shade300),
                ), Icon(Icons.local_fire_department_rounded,color: isDark??false? floatActionColor:brownColor,),
                Padding(
                  padding: const EdgeInsets.only(left:5.0,right: 5),
                  child: Text(
                    '${provider.price} ${Strings.sar.tr(context)}', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                    style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: isDark??false? floatActionColor:brownColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(canAdd)  Text(
            Strings.customizable.tr(context),
            style: TextStyle(color: isDark??false? floatActionColor:borderColor,fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis,
          ),
          Stack(
            children: [
              image('${provider.image??''}', 110.0, 100.0,15.0,BoxFit.fill),
              Positioned(
                  bottom: 0,
                  child: onTheImage ?? InkWell(
                      onTap:onTap,child: CircleAvatar(radius: 15,backgroundColor: mainColor.shade400,child: Icon(Icons.add,color: Colors.white,),)))
            ],
          ),
        ],
      ),
    ],),
  );}