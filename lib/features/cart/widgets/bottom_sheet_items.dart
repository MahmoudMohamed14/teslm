import 'dart:async';
import 'package:delivery/common/translate/app_local.dart';
import 'package:flutter/material.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../common/colors/colors.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/constant/constant values.dart';
import '../../../common/translate/strings.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>  with SingleTickerProviderStateMixin {
  bool containerPadding=true;
  @override
  void initState() {
    super.initState();
  }
  void startAnimation() {
    setState(() {
      containerPadding =false;
    });
  }
  @override
  Widget build(BuildContext context) {
    List<String> listUnavailableItems =[ Strings.removeItemOrder.tr(context),Strings.cancelOrder.tr(context)];
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          const SizedBox(height: 10,),
          Text(Strings.itemUnavailable.tr(context),style: const TextStyle(fontFamily: 'fontTop',fontWeight: FontWeight.w500,fontSize: 18),),
          const SizedBox(height: 10,),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context,index)=> ListTile(
                leading: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: !containerPadding&&_isCheckedList[index]==true?ThemeModel.mainColor:null,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1.2,color: isDark??false ?_isCheckedList[index]==true? ThemeModel.mainColor:floatActionColor:_isCheckedList[index]==true?ThemeModel.mainColor:borderColor)),
                    child: CircleAvatar(
                      radius:5,
                      backgroundColor: _isCheckedList[index]==true? ThemeModel.mainColor: isDark??false ?Colors.black12:floatActionColor,
                    ),
                  ),
                ),
                title: Text(listUnavailableItems[index],style:const TextStyle(fontSize: 17),),
                onTap: (){
                  setState((){
                    if(index==1){_isCheckedList=[false,true];choose=true;}
                    else{_isCheckedList=[true,false];choose=false;}
                    DeliveryCubit.get(context).increment();
                  });
                  setState(() {
                    containerPadding =false;
                  });

                  Timer(const Duration(milliseconds: 350), () {
                    setState(() {
                      containerPadding = true;
                    });
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
bool choose=false;
List<bool> _isCheckedList =[ true,false];