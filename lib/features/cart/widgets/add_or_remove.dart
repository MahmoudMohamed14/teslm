import 'package:delivery/features/provider%20page/controller/provider_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/colors/theme_model.dart';
import '../../provider page/controller/provider_state.dart';

Widget addOrRemoveOne(itemsNumber,context,add,remove,mainPage)=>Container(
  margin: mainPage?const EdgeInsets.only(left: 20,bottom: 10):EdgeInsets.zero,
  padding: EdgeInsets.all(mainPage?10:5),
  width: mainPage? MediaQuery.sizeOf(context).width/3:100,
  child: BlocConsumer<ProviderCubit,ProviderState>(
    listener:(context, state) {} ,
    builder:   (context, state) {
   return Row(
     mainAxisAlignment: MainAxisAlignment.spaceAround,
     children: [
       InkWell(onTap: remove, child:Container(
         decoration: BoxDecoration(
           shape: BoxShape.circle,
           border: Border.all(
             color: ThemeModel.of(context).red, // Set your desired border color here
             width: 2.0,        // Set the thickness of the border
           ),
         ),
         child: CircleAvatar(
             backgroundColor: Colors.transparent,
             radius: 10,
             child: itemsNumber==1&&mainPage==false? Icon(Icons.restore_from_trash_outlined,size: 15,color: ThemeModel.of(context).red,)
                 :Icon(Icons.remove,size: 15,color: ThemeModel.of(context).red,)),
       )),
       Text(
         '$itemsNumber', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
         style:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
       ),
       InkWell(onTap: add, child:Container(
         decoration: BoxDecoration(
           shape: BoxShape.circle,
           border: Border.all(
             color: ThemeModel.mainColor, // Set your desired border color here
             width: 2.0,        // Set the thickness of the border
           ),
         ),
         child: CircleAvatar(
             backgroundColor: Colors.transparent,
             radius: 10,
             child: const Icon(Icons.add,size: 15,color: ThemeModel.mainColor,)),
       )),
     ],
   );
    }

  ),
);