import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../common/colors/colors.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';

Widget getOrderLoading()=>Card(
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Shimmer.fromColors(
                      baseColor: borderColor[isDark??false? 800:300]!,
                      highlightColor: borderColor[isDark??false? 800:100]!,
                      child: const Padding(
                        padding: EdgeInsets.all(5),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                        ),
                      )) ,const SizedBox(width: 10,),
                  Skeleton(width: 80.0,height: 15.0),
                ],
              ),
            ),
            Skeleton(width: 70.0,height: 15.0),
          ],),
        const SizedBox(height: 5,),
        Row(
          children: [
            Skeleton(width: 150.0,height: 15.0),
          ],
        )
      ],
    ),
  ),
);