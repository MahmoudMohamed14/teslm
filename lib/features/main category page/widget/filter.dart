import 'package:delivery/common/translate/applocal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Cubite/delivery_cubit.dart';
import '../../../common/colors/colors.dart';
import '../../../common/translate/strings.dart';

Widget changeItems(index,context)=>BlocBuilder<DeliveryCubit, DeliveryState>(
  builder: (context, state) {
    List filterData=[Strings.highReview.tr(context),Strings.mostReviewers.tr(context)];
    List filterIcons=[Icon(Icons.star,color: ColorsApp.secondColorGreen,),Icon(Icons.person_search,color: ColorsApp.secondColorGreen,)];
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: (){
          if(index==0)
          {DeliveryCubit.get(context).filterProvider(sortField: 'DESC',sortBy:'reviewCount' );}
          else
          {DeliveryCubit.get(context).filterProvider(sortField: 'DESC',sortBy:'totalReviews' );}
        },
        child: Container(
          padding: EdgeInsets.all(8),
          height: 39,decoration: BoxDecoration(
          color: ColorsApp.filterColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 3,), filterIcons[index],
              const SizedBox(width: 3,), Text(filterData[index],style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black),),
              const SizedBox(width: 3,), Icon(Icons.keyboard_arrow_down,color: Colors.black,)
            ],
          ),),
      ),
    );
  },
);