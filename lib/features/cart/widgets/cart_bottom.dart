import 'package:flutter/material.dart';

Widget cartBottom(context,onTap,color,text)=>InkWell(
  onTap: onTap,
  child: Container(
    decoration: BoxDecoration(color: color ,borderRadius: BorderRadius.circular(10)),
    height: 50,
    alignment: Alignment.center,
    width: MediaQuery.sizeOf(context).width/2.3,
    child: Text(text,maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:const TextStyle(fontFamily: 'fontTop',fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
  ),
);