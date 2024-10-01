import 'package:delivery/common/colors/theme_model.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';
import '../../../common/translate/strings.dart';

Widget bigCardHome(providerData,onTap,context)=>InkWell(
  onTap: onTap,
  child: Card(
    color:ThemeModel.of(context).cardsColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Container(
      padding:const EdgeInsets.all(7),
      child: Column(
        mainAxisAlignment:language=='English Language'? MainAxisAlignment.end:MainAxisAlignment.start,
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          SizedBox(
              child:  Stack(
                children: [
                  image(providerData.providerCover, 100.0, MediaQuery.sizeOf(context).width/2.7,15.0,BoxFit.fill),
                  Positioned(
                    top: 10, right: 10, height:30, width: 30,
                    child:image(providerData.providerImage, 10.0, 20.0,10.0,BoxFit.fill),),
                  Positioned(
                    top: 10, left: 10, height:25,
                    child:Container(
                      decoration: BoxDecoration(color:Colors.blueGrey.shade900,borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 6.0),
                              child: Icon(Icons.star,color: Colors.amber,size: 15),
                            ),
                            Text(
                        "${(providerData.reviewCount != null && providerData.reviewCount != 0 ? (providerData.totalReviews / providerData.reviewCount) : 0).toInt()} (${providerData.reviewCount ?? 0})",
                        style:const TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w400),
                      ),
                          ],
                        ),
                      ),
                    )),
                  Positioned(
                      bottom: 0, height:25,
                      child:Container(
                        width: MediaQuery.sizeOf(context).width/2.7,
                        height: 16,
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        decoration: const BoxDecoration(
                            color:ThemeModel.mainColor,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(7),bottomRight: Radius.circular(7))
                        ),
                        child:  Center(
                          child: Text(
                            Strings.deliveryFree.tr(context),
                            style:const TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),),
                ],
              )
          ),
          const SizedBox(height: 10,),
          Container(
            width: MediaQuery.sizeOf(context).width/2.7,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: ThemeModel.of(context).bigCardBottomColor),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(language=='en'?'${providerData.providerName.en??""}':'${providerData.providerName.ar??''}',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,
                        style:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    ],
                  ),
                    Row(
                      children: [
                        const Icon(Icons.more_time_rounded,),const SizedBox(width: 5,),Text(Strings.timeMinutes.tr(context),
                          style:const TextStyle(fontSize: 13,fontWeight: FontWeight.w400),),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);