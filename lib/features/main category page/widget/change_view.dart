import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../Cubite/delivery_cubit.dart';

Widget viewNew(icon,view,context)=>InkWell(
  onTap:(){DeliveryCubit.get(context).changeView();},
  child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),),
      padding: const EdgeInsets.all(4),
      child: SvgPicture.asset(
        '$icon',
        width: 25, // You can set width and height as needed
        height: 25,
        color: view,
      ),),
);