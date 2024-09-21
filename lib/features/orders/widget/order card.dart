import 'package:delivery/common/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../common/components.dart';
import '../../../common/constant values.dart';

Widget orderCard(order){
  DateTime createdAt = DateTime.parse(order.createdAt);
  return Card(
    color: isDark??false ? ColorsApp.cardsDarkColor:ColorsApp.whiteColor,
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 15,bottom: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    image('${order.providerOrders.providerImage}', 60.0, 60.0, 40.0,BoxFit.cover),
                    const SizedBox(width: 10,),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(language == 'en'? '${order.providerOrders.providerName.en}':'${order.providerOrders.providerName.ar}',
                          style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700),maxLines: 1,overflow: TextOverflow.ellipsis,),
                        Text(
                            DateFormat('MMMM d, yyyy HH:mm').format(createdAt),
                          style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),
                        )
                      ],
                    )),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(color:order.status=='pending'? isDark??false?ColorsApp.pendingDarkColor:ColorsApp.pendingLightColor: Colors.green.shade400,
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.only(left: 15,right: 15),child: Text('${order.status}',),)
            ],),
        ],
      ),
    ),
  );}