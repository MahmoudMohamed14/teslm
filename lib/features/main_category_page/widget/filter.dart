import 'package:delivery/common/colors/theme_model.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../common/translate/strings.dart';
import '../controller/category_cubit.dart';

Widget changeItems(index,context)=>BlocBuilder<DeliveryCubit, DeliveryState>(
  builder: (context, state) {
    List filterData=[Strings.highReview.tr(context),Strings.mostReviewers.tr(context)];
    List filterIcons= [Icon(Icons.star,color: ThemeModel.of(context).greenAppBar,),Icon(Icons.person_search,color: ThemeModel.of(context).greenAppBar,)];
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: (){
          if(index==0)
          {CategoryCubit.get(context).filterProvider('DESC','reviewCount' );}
          else
          {CategoryCubit.get(context).filterProvider('DESC','totalReviews' );}
        },
        child: Container(
          padding:const EdgeInsets.all(8),
          height: 39,decoration:const BoxDecoration(
          color: ThemeModel.filterColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 3,), filterIcons[index],
              const SizedBox(width: 3,), Text(filterData[index],style:const TextStyle(fontWeight: FontWeight.w600,color: Colors.black),),
              const SizedBox(width: 3,), const Icon(Icons.keyboard_arrow_down,color: Colors.black,)
            ],
          ),),
      ),
    );
  },
);