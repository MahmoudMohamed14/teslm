import 'package:delivery/common/colors/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget pointsAndWalletCard(context,textData,quantity,image)=>SizedBox(
  width: 171,
  height: 71,
  child: Card(
    color: ThemeModel.of(context).cardsColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            backgroundColor: const Color(0x6BD9D9D9),
            radius: 20,
            child: SvgPicture.asset(
              '$image',
              height: 20.0,  // Adjust the size as needed
              width: 20.0,
            ),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text('$textData',style: TextStyle(color: ThemeModel.of(context).font1),),
          Text('$quantity',style: TextStyle(fontWeight: FontWeight.bold,color:  ThemeModel.of(context).font1),)
        ],),
      ],),
  ),
);