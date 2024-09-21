import 'package:delivery/common/translate/applocal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/colors/colors.dart';
import '../../../common/components.dart';
import '../../../common/constant values.dart';
import '../../../common/translate/strings.dart';

Widget bigCardHome(providerData,onTap,context)=>InkWell(
  onTap: onTap,
  child: Card(
    color:isDark??false? ColorsApp.cardsDarkColor:Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment:language=='English Language'? MainAxisAlignment.end:MainAxisAlignment.start,
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          SizedBox(
              height:150.0,
              child:  Stack(
                children: [
                  image(providerData.providerCover, 180.0, MediaQuery.sizeOf(context).width/1.2,15.0,BoxFit.fill),
                  Positioned(
                    top: 10, right: 10, height:50, width: 50,
                    child:image(providerData.providerImage, 50.0, 50.0,15.0,BoxFit.fill),),
                  Positioned(
                    top: 10, left: 10, height:25,
                    child:Container(
                      decoration: BoxDecoration(color:Colors.blueGrey.shade900,borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0,right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star,color: Colors.amber,),
                            Text(
                        "${(providerData.reviewCount != null && providerData.reviewCount != 0 ? (providerData.totalReviews / providerData.reviewCount) : 0).toInt()} (${providerData.reviewCount ?? 0})",
                        style: TextStyle(color: Colors.white),
                      ),
                          ],
                        ),
                      ),
                    )),
                  Positioned(
                      bottom: 0, left: 0, height:25,
                      child:Container(
                        width: MediaQuery.sizeOf(context).width/1.2,
                        decoration: BoxDecoration(color:Colors.black26,borderRadius:BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.stars_rounded,color: Colors.white,),Text(language=='English Language'?'Best in 2023':"الافضل فى 2023",style: TextStyle(color: Colors.white),),
                              ],
                            ),
                            Text(language=='English Language'?'Advertisement':"اعلان",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
                          ],
                        )
                      )),
                ],
              )
          ),
          const SizedBox(height: 10,),
          Container(
            width: MediaQuery.sizeOf(context).width/1.2,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: isDark??false? ColorsApp.cardBottomColor:Colors.grey.shade200),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(language=='en'?'${providerData.providerName.en??""}':'${providerData.providerName!.ar??''}',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                    ],
                  ),
                    Row(
                      children: [
                        const Icon(Icons.more_time_rounded,),SizedBox(width: 5,),Text(Strings.timeMinutes.tr(context),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),),
                      ],
                    ),
                  Container(
                    height: 20,

                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                        color:ColorsApp.greenColor,
                        borderRadius: BorderRadius.circular(7)
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add,color: Colors.white,size: 25,),
                        const SizedBox(width: 5,),
                        Flexible(

                          child: Text(
                            Strings.freeDelivery.tr(context),
                            style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
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