import 'package:flutter/cupertino.dart';

import '../../../common/constant values.dart';
import 'order loading card.dart';

Widget ordersLoading()=>SafeArea(
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Align(
          alignment: language == 'English Language' ? Alignment.bottomLeft : Alignment.bottomRight,
          child: Text(language == 'English Language'
              ? 'My order'
              : 'طلباتى', style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.w700),),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context,index)=>getOrderLoading(),itemCount: 3,),
      ],
    ),
  ),
);