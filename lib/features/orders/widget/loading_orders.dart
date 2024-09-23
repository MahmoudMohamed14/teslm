import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:flutter/cupertino.dart';
import '../../../common/constant/constant values.dart';
import 'order_loading_card.dart';

Widget ordersLoading(context)=>SafeArea(
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Align(
          alignment: language == 'English Language' ? Alignment.bottomLeft : Alignment.bottomRight,
          child: Text(Strings.myOrders.tr(context), style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.w700),),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context,index)=>getOrderLoading(),itemCount: 3,),
      ],
    ),
  ),
);