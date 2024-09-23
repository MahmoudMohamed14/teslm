import 'package:flutter/material.dart';
import '../../../common/colors/colors.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';

Widget filterSmallViewLoading()=>ListView.builder(
    shrinkWrap: true,
    physics:const NeverScrollableScrollPhysics(),itemCount:3,itemBuilder:(context,index)=> Card(
  color:isDark??false? ColorsApp.cardsDarkColor:Colors.white,
  child: Padding(
    padding: const EdgeInsets.only(left: 8.0,right: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Skeleton(height: 102.0,width:102.0,radius: 40.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(width: 80.0,height: 12.0),
                Skeleton(width: 130.0,height: 12.0),
                Skeleton(width: 200.0,height: 12.0),
                Row(children: [
                  Skeleton(width: 50.0,height: 12.0),Skeleton(width: 50.0,height: 12.0),
                ],)
              ],)
          ],
        ),
        Center(child: Skeleton(width: 270.0,height: 25.0,radius: 10.0)),
      ],
    ),
  ),
));
Widget filterBigViewLoading()=>ListView.builder(
    shrinkWrap: true,
    physics:const NeverScrollableScrollPhysics(),itemCount:3,itemBuilder:(context,index)=> Card(
  color:isDark??false? ColorsApp.cardsDarkColor:Colors.white,
  child: Padding(
    padding: const EdgeInsets.only(left: 8.0,right: 8),
    child: Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeleton(width: MediaQuery.sizeOf(context).width/1.20,height: 150.0),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                color: isDark??false? ColorsApp.cardBottomColor:Colors.grey.shade200),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Skeleton(width: 100.0,height: 12.0),
                    Skeleton(width: 100.0,height: 12.0),
                  ],
                ),
                Center(child: Skeleton(width: 270.0,height: 17.0,radius: 10.0)),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
));