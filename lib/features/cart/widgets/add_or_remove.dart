import 'package:flutter/material.dart';
import '../../../common/colors/colors.dart';
import '../../../common/colors/theme_model.dart';

Widget addOrRemoveOne(itemsNumber,context,add,remove,mainPage)=>Container(
  margin: mainPage?const EdgeInsets.only(left: 20,bottom: 10):EdgeInsets.zero,
  padding: EdgeInsets.all(mainPage?10:5),
  width: mainPage? MediaQuery.sizeOf(context).width/3:100,
  height:mainPage? 50:30,
  decoration: BoxDecoration(
      color: ThemeModel.mainColor,
      borderRadius:const BorderRadius.all(Radius.circular(20))
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      InkWell(onTap: add, child:const Icon(Icons.add,color: Colors.white,)),
      Text(
        '$itemsNumber', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
        style:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),
      ),
      InkWell(onTap: remove,child:itemsNumber==1&&mainPage==false? const Icon(Icons.restore_from_trash_outlined,color: Colors.white,)
          :const Icon(Icons.remove,color: Colors.white,),),
    ],
  ),
);