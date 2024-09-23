import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/colors/colors.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';

Widget orderDetails(order,orderIndex)=>ListView.separated(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    separatorBuilder: (context,index)=>seperate(),
    itemCount: order.data![orderIndex].items!.length,
    itemBuilder: (context,itemIndex)=>Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: image('${order.data![orderIndex].items![itemIndex].image}', 70.0, 60.0, 40.0,BoxFit.fill),
        ),
        Expanded(child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(language=='English Language'?'${order.data![orderIndex].items![itemIndex].item!.name!.en}':'${order.data![orderIndex].items![itemIndex].item!.name!.ar}',maxLines: 2,
                overflow: TextOverflow.ellipsis,style:const TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),),
              const SizedBox(height: 5,),
              Text('${order.data![orderIndex].items![itemIndex].price} SR',maxLines: 1, overflow: TextOverflow.ellipsis,style:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
            ],
          ),
        )),
        Padding(
          padding: const EdgeInsets.only(right:10,left:10.0),
          child: CircleAvatar(radius: 14,backgroundColor: mainColor.shade400,
            child: Text('${order.data![orderIndex].items![itemIndex].quantity}',style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 17,color: Colors.white),),),
        ),
      ],));