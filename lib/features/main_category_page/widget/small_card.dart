import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:flutter/material.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';

Widget smallCard(providerData,onTap,context)=>InkWell(
  onTap: onTap,
  child: Card(
    color:ThemeModel.of(context).cardsColor,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  image(providerData.providerCover, 120.0, 110.0,8.0,BoxFit.fill),
                  PositionedDirectional(
                    top: 5,
                    start:5,
                      child: image(providerData.providerImage, 35.0, 35.0,10.0,BoxFit.fill)),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        width: 110,
                        decoration: BoxDecoration(color: ThemeModel.mainColor,borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            Strings.deliveryFree.tr(context),
                            style:const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700),
                          ),
                        ),
                      ))
                ],
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const Icon(Icons.star,color: Colors.amber,),
                      Text(
                        providerData.reviewCount == 0
                            ? "0 (${providerData.reviewCount})"
                            : "${(providerData.totalReviews / providerData.reviewCount).isNaN ? 0 : (providerData.totalReviews / providerData.reviewCount).toInt()} (${providerData.reviewCount})",
                        style:const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0,right: 8),
                      child: Text(
                        language=='en'?'${providerData.providerName!.en}':'${providerData.providerName!.ar}', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                        style:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0,right: 8),
                      child: Text(
                        language=='en'?'${providerData.description!.en}':'${providerData.description!.ar}',
                        style:const TextStyle(fontSize: 13,fontWeight: FontWeight.w400), maxLines: 2, overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.location_on_outlined,color:ThemeModel.of(context).smallCardIconsColor,),
                          const SizedBox(width: 5,),
                          Text(language=='en'?'0.5 KM':"0.5 كم",style: TextStyle(color:ThemeModel.of(context).smallCardIconsColor),),
                          const SizedBox(width: 10,),
                          Icon(Icons.more_time_rounded,color:ThemeModel.of(context).smallCardIconsColor),
                          const SizedBox(width: 5,),
                          Text(Strings.timeMinutes.tr(context),style: TextStyle(color:ThemeModel.of(context).smallCardIconsColor),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
    ),),
);