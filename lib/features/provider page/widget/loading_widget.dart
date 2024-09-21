import 'package:flutter/material.dart';
import '../../../common/components.dart';

Widget providerLoading()=>SliverList(
  delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index){
      return ListTile(
        subtitle: Column(
          children: [
            SizedBox(height:700,child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context,indexNew) =>Container(
                height: 135,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Skeleton(width: 120.0,height: 20.0),
                        Skeleton(width: 150.0,height: 10.0),
                        Skeleton(width: 190.0,height: 10.0),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Skeleton(width: 50.0,height: 10.0),const SizedBox(width: 5,),
                            Padding(
                              padding: const EdgeInsets.only(left:8.0,right: 8),
                              child: Skeleton(width: 50.0,height: 10.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Skeleton(width: 100.0,height: 110.0),
                  ],),
              ),itemCount: 3, separatorBuilder: (BuildContext context, int index) =>seperate(),)),
            seperate()
          ],
        ) ,
      );
    }, childCount: 1,
  ), );