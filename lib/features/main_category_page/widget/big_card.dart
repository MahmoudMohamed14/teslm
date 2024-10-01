import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';

Widget bigCardCategory(providerData,onTap,context)=>InkWell(
  onTap: onTap,
  child: SizedBox(
    width: MediaQuery.sizeOf(context).width/1.3,
    child: Card(
      color:ThemeModel.of(context).cardsColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
                height: 160,
                child:  Stack(
                  children: [
                    image(providerData.providerCover, 180.0, MediaQuery.sizeOf(context).width/1.20,15.0,BoxFit.fill),
                    Positioned(
                      top: 10, right: 10, height:50, width: 50,
                      child:image(providerData.providerImage, 50.0, 50.0,15.0,BoxFit.fill),),
                    Positioned(
                        top: 10, left: 10, height:25,
                        child:Container(
                          decoration: BoxDecoration(color:Colors.blueGrey.shade900,borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding:const EdgeInsets.only(left: 8.0,right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.star,color: Colors.amber,),
                                Text(providerData.reviewCount??0 == 0
                                    ? "0 (${providerData.reviewCount??0})"
                                    : "${(providerData.totalReviews??0 / providerData.reviewCount??1).isNaN??true ? 0 : (providerData.totalReviews??0 / providerData.reviewCount).toInt()??1} (${providerData.reviewCount??0})",
                                  style:const TextStyle(color: Colors.white),),
                              ],
                            ),
                          ),
                        )),
                    Positioned(
                        bottom: 0, left: 0, height:25,
                        child:Container(
                          width: MediaQuery.sizeOf(context).width/1.2,
                          height: 24,
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: const BoxDecoration(
                              color:ThemeModel.mainColor,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(7),bottomRight: Radius.circular(7))
                          ),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add,color: Colors.white,size: 25,),
                              const SizedBox(width: 5,),
                              Flexible(

                                child: Text(
                                  Strings.freeDelivery.tr(context),
                                  style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),),
                  ],
                )
            ),
            const SizedBox(height: 10,),
            Container(
              width: MediaQuery.sizeOf(context).width/1.20,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                  color: ThemeModel.of(context).bigCardBottomColor),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(language=='en'?'${providerData.providerName?.en}':'${providerData.providerName?.ar}',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,
                          style:const TextStyle(fontSize: 16.22,fontWeight: FontWeight.bold,),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.more_time_rounded,),const SizedBox(width: 5,),
                              Text(Strings.timeMinutes.tr(context),style:const TextStyle(fontSize: 13,fontWeight: FontWeight.w400),),
                            ],
                          )
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
  ),
);