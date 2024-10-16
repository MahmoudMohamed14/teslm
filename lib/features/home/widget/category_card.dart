import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Cubite/delivery_cubit.dart';
import '../../../common/components.dart';
import '../../../common/constant values.dart';
import '../../main category page/screen/main_Categories.dart';

Widget category(modul,index,context){return InkWell(
  onTap: (){
    DeliveryCubit.get(context).categoryProvider(id:modul.id);
    navigate(context, MainCategories(categoryName:language=='en'? '${modul.name.en}':'${modul.name.ar}'));
  },
  child: Column(
    children: [ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: CachedNetworkImage(
        height: 60,fit: BoxFit.cover,
        width: 60,
        imageUrl:'${modul.image}',
        errorWidget: (context, url, error) => const Icon(Icons.error),
        placeholder: (context,url) => const Center(child: CircularProgressIndicator()),),
    ),
      Flexible(
        child: Text(language=='en'? '${modul.name.en}':'${modul.name.ar}',maxLines: 1,textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15),),
      )
    ],),
);}