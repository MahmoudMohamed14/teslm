import 'package:flutter/material.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../common/images/images.dart';
import 'change_view.dart';
import 'filter_loading.dart';

Widget categoryLoading(categoryName,view,context)=>ListView(children: [
  SizedBox(
    height: 155,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context,index)=>Container(
      padding:const EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Skeleton(height: 200.0,width: 100.0 ),
          Skeleton(height: 200.0,width: 100.0 ),
          Skeleton(height: 150.0,width: 100.0 ),
        ],
      ),
    ),),
  ),
  const SizedBox(height: 5,),
  Padding(
    padding: const EdgeInsets.only(left: 10.0,right: 10),
    child: Row(
      children: [
        Text('$categoryName',style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
        const Spacer(),
        Row(
          children: [
            viewNew(ImagesApp.categoryBigViewImage, view ? ThemeModel.of(context).greenAppBar :  ThemeModel.of(context).greenAppBar.withOpacity(0.4), context),
            viewNew(ImagesApp.categorySmallViewImage, view ?  ThemeModel.of(context).greenAppBar.withOpacity(0.4) : ThemeModel.of(context).greenAppBar, context),
          ],
        ),
      ],
    ),
  ),
  Padding(
    padding: const EdgeInsets.only(left: 20.0,right: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Skeleton(height: 30.0,width:70.0,radius: 15.0 ),
        Skeleton(height: 30.0,width:70.0,radius: 15.0 ),
        Skeleton(height: 30.0,width:70.0 ,radius: 15.0),
      ],
    ),
  ),
view ?filterBigViewLoading():filterSmallViewLoading()
],);