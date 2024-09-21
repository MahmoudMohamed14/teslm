import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/colors/colors.dart';

Widget addOrRemoveOne(itemsNumber,context,add,remove,mainPage)=>Container(
  margin: mainPage?EdgeInsets.only(left: 20,bottom: 10):EdgeInsets.zero,
  padding: EdgeInsets.all(mainPage?10:5),
  width: mainPage? MediaQuery.sizeOf(context).width/3:100,
  height:mainPage? 50:30,
  decoration: BoxDecoration(
      color: mainColor.shade400,
      borderRadius: BorderRadius.all(Radius.circular(20))
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      InkWell(child: Icon(Icons.add,color: Colors.white,),onTap: add),
      Text(
        '$itemsNumber', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
        style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),
      ),
      InkWell(child:itemsNumber==1&&mainPage==false? Icon(Icons.restore_from_trash_outlined,color: Colors.white,):Icon(Icons.remove,color: Colors.white,),onTap: remove,),
    ],
  ),
);