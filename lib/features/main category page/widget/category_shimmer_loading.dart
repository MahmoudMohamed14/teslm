import 'package:delivery/features/main%20category%20page/widget/filter_loading.dart';
import 'package:flutter/material.dart';
import '../../../common/colors/colors.dart';
import '../../../common/components.dart';
import 'change_view.dart';

Widget categoryLoading(categoryName,view,context)=>ListView(children: [
  SizedBox(
    height: 110,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context,index)=>Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Skeleton(height: 100.0,width:MediaQuery.sizeOf(context).width / 2 ),
    ),),
  ),

  SizedBox(height: 5,),
  Padding(
    padding: const EdgeInsets.only(right:15.0,left: 15),
    child: Row(
      children: [
        Text('${categoryName}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
        Spacer(),
        Row(
          children: [
            viewNew(Icons.laptop_mac_rounded,view?mainColor:Colors.blue, context),
            viewNew(Icons.dehaze_rounded,view?mainColor:Colors.blue,context,),
          ],
        )
      ],
    ),
  ),
  Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Skeleton(height: 30.0,width:70.0,radius: 15.0 ),
      Skeleton(height: 30.0,width:70.0,radius: 15.0 ),
      Skeleton(height: 30.0,width:70.0 ,radius: 15.0),
    ],
  ),
view ?filterBigViewLoading():filterSmallViewLoading()
],);