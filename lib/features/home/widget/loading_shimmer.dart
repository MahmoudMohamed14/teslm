import 'package:delivery/common/colors/theme_model.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../common/components.dart';
import '../../../common/images/images.dart';

Widget loadingMainPage(scrollController,context)=>Padding(
  padding: const EdgeInsets.all(8.0),
  child: ListView(
    controller: scrollController,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Skeleton(height: 100.0,width: 100.0,),
          Skeleton(height: 130.0,width: 100.0,),
          Skeleton(height: 100.0,width: 100.0,),
        ],
      ),
      const SizedBox(height: 15,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        SizedBox(
          width: 171,
          height: 71,
          child: Card(
            color: ThemeModel.of(context).cardsColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundColor: ThemeModel.of(context).pointIconBackgroundColor,
                  radius: 20,
                  child: SvgPicture.asset(
                    ImagesApp.walletHomeImage,
                    height: 20.0,  // Adjust the size as needed
                    width: 20.0,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Strings.wallet.tr(context),),
                    Skeleton(height: 15.0,width: 20.0,),
                  ],),
              ],),
          ),
        ),
        SizedBox(
          width: 171,
          height: 71,
          child: Card(
            color:ThemeModel.of(context).cardsColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundColor: ThemeModel.of(context).pointIconBackgroundColor,
                  radius: 20,
                  child: SvgPicture.asset(
                    ImagesApp.pointsHomeImage,
                    height: 20.0,  // Adjust the size as needed
                    width: 20.0,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Strings.points.tr(context),),
                    Skeleton(height: 15.0,width: 20.0,),
                  ],),
              ],),
          ),
        ),
      ],),
      const SizedBox(height: 15,),
      SizedBox(
        height: 150,
        child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items per column
              childAspectRatio: 1 / 1.5, // Aspect ratio of each item
              crossAxisSpacing: 0.2,
              mainAxisSpacing: 0.2,
            ),
            itemCount: 6,
            itemBuilder: (context,index)=> Column(
              children: [
                Skeleton(height: 40.0,width: 40.0,radius: 40.0),
                Skeleton(height: 10.0,width: 50.0),
              ],
            )),
      ),
      Padding(
        padding:  const EdgeInsets.only(left: 10.0,right: 10),
        child: Text(Strings.selections.tr(context),style:  const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,
        ),),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(2, (index) => Card(

            child: SizedBox(
              width: MediaQuery.sizeOf(context).width/2.7, height: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(width: MediaQuery.sizeOf(context).width/2.7,height: 100.0),
                  Card(
                    child: Container(
                       width: MediaQuery.sizeOf(context).width/2.7,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                          color: ThemeModel.of(context).bigCardBottomColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Skeleton(width: 80.0,height: 12.0),
                          Skeleton(width: 120.0,height: 12.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),),
      ),
    ],
  ),
);