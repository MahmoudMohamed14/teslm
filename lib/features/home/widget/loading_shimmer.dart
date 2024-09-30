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
          Skeleton(height: 90.0,width: 100.0,),
          Skeleton(height: 120.0,width: 100.0,),
          Skeleton(height: 90.0,width: 100.0,),
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
      GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true, childAspectRatio: 1/1.3, crossAxisSpacing: 0, mainAxisSpacing: 0.2,
        crossAxisCount: 4,children: List.generate(3,
            (index)=> Column(
          children: [
            Skeleton(height: 60.0,width: 60.0,radius: 60.0),
            Skeleton(height: 15.0,),
          ],
        ),), ),
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
              width: MediaQuery.sizeOf(context).width/1.3, height: 230,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(width: MediaQuery.sizeOf(context).width/1.20,height: 150.0),
                  Card(
                    child: Container(
                       width: MediaQuery.sizeOf(context).width/1.20,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                          color: ThemeModel.of(context).bigCardBottomColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Skeleton(width: 100.0,height: 12.0),
                          Skeleton(width: 170.0,height: 12.0),
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