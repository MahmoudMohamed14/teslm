import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../controller/category_cubit.dart';

Widget viewNew(icon,view,context)=>InkWell(
  onTap:(){CategoryCubit.get(context).changeView();},
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