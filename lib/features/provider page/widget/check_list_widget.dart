import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:delivery/features/provider%20page/controller/provider_cubit.dart';
import 'package:delivery/features/provider%20page/controller/provider_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/colors/colors.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';

Widget checkList(isChecked,onChange,addNewName,price,extraImage,context)=> BlocConsumer<ProviderCubit, ProviderState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return InkWell(
  onTap: onChange,
  child: Card(
    color: ThemeModel.of(context).cardsColor,
    child: Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(border: isChecked?Border.all(color: ThemeModel.mainColor,width:1.5):null,borderRadius: BorderRadius.circular(7)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                Strings.sar.tr(context), maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),
              ),
              const SizedBox(width: 5,),
              Text(
                '$price+', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                addNewName, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),
              ),
              const SizedBox(width: 7,),
              image('$extraImage', 30.0, 30.0, 30.0,BoxFit.fill),
            ],
          ),
        ],
      ),
    ),
  ),
);
  },
);