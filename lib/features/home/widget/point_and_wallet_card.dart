import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget pointsAndWalletCard(textData,quantity,image)=>SizedBox(
  width: 171,
  height: 71,
  child: Card(
    color: Colors.white,
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
          Text('$textData',style: TextStyle(color: Colors.black),),
          Text('$quantity',style:const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)
        ],),
      ],),
  ),
);