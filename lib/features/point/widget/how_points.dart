import 'package:delivery/common/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../common/constant/constant values.dart';

Widget howPoints(text,icon,description)=>Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color:isDark??false? ColorsApp.cardsDarkColor:ColorsApp.greyColor,
        borderRadius: BorderRadius.circular(10.0)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
            backgroundColor: ColorsApp.whiteColor,
            radius: 22,
            child: SvgPicture.asset(
              icon,
            )),
        const SizedBox(width: 10,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              Text(description,style: const TextStyle(fontWeight: FontWeight.w300,fontSize: 12),maxLines: 5,overflow: TextOverflow.ellipsis,)
            ],),
        )],),
  ),
);