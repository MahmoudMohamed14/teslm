import 'package:delivery/features/provider%20page/controller/provider_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../provider page/controller/provider_state.dart';
import 'add_or_remove.dart';

Widget itemsCart(index,context)=>Dismissible(
  key: ValueKey(values[index]),
  onDismissed: (DismissDirection direction) {
    ProviderCubit.get(context).RemoveValue(index);
    if(values.isEmpty){Navigator.pop(context);}
  },
  child: Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
    height: 120,
    child: Card(
      color: ThemeModel.of(context).cardsColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image('${values[index]['image']}', 120.0, 119.0, 10.0,BoxFit.fill),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('${values[index]['name']}',maxLines: 1, overflow: TextOverflow.ellipsis,style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),),
                Text('${values[index]['description']}',maxLines: 2, overflow: TextOverflow.ellipsis,style:const TextStyle(fontSize: 13,fontWeight: FontWeight.w400,),),
                Spacer(),
                BlocConsumer<ProviderCubit,ProviderState>(
                    listener:(context, state) {} ,
                    builder:   (context, state) {
                      return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      addOrRemoveOne(
                          values[index]['quantity'],
                          context,
                              (){ ProviderCubit.get(context).addValue(values[index]['name'],1,values[index]['image'],values[index]['price'],values[index]['id'],values[index]['description'],values[index]['extraId'],values[index]['ProviderId']);},
                              (){ ProviderCubit.get(context).minusValue(values[index]['name'],1,values[index]['image'],values[index]['price'],values[index]['id']);
                          if(values.isEmpty){Navigator.pop(context);}
                          },
                          false
                      ),
                      Text('${values[index]['price']} SR',maxLines: 1, overflow: TextOverflow.ellipsis,style:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                    ],
                  );}
                ),
              ],
            ),
          )),
        ],),
    ),
  ),
);