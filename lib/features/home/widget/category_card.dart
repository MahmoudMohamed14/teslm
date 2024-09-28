import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/features/provider%20page/controller/provider_cubit.dart';
import 'package:flutter/material.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';
import '../../main_category_page/controller/category_cubit.dart';
import '../../main_category_page/screen/main_categories.dart';

Widget category(model,index,context){return InkWell(
  onTap: (){
    CategoryCubit.get(context).categoryProvider(id:model.id);
    navigate(context, MainCategories(categoryName:language=='en'? '${model.name.en}':'${model.name.ar}'));
    print(" name???${model.name.en} ");
    ProviderCubit.get(context).categoryId=model.id;
    if(model.name?.en?.toLowerCase()=='restaurants'){
      values=[];
      ProviderCubit.get(context).isRestaurant=true;
    }else{
      ProviderCubit.get(context).isRestaurant=false;
      ProviderCubit.get(context).cardList.forEach((action){
        if(ProviderCubit.get(context).categoryId==action['categoryId']){
          values.add(action);

        }
      });

    }
  },
  child: Column(
    children: [ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: CachedNetworkImage(
        height: 60,fit: BoxFit.cover,
        width: 60,
        imageUrl:'${model.image}',
        errorWidget: (context, url, error) => const Icon(Icons.error),
        placeholder: (context,url) => const Center(child: CircularProgressIndicator()),),
    ),
      Flexible(
        child: Text(language=='en'? '${model.name.en}':'${model.name.ar}',maxLines: 1,textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15),),
      )
    ],),
);}