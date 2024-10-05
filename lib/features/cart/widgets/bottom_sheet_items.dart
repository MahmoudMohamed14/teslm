import 'dart:async';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/features/payment%20page/controller/order_cubit.dart';
import 'package:flutter/material.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../common/colors/colors.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/constant/constant values.dart';
import '../../../common/translate/strings.dart';
import '../../profile/navigator/chat/controller/chat_controller_cubit.dart';

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
          Text(Strings.itemUnavailable.tr(context),style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
          const SizedBox(height: 10,),
          SizedBox(
            height: 100,
            child: ListView.builder(
              physics:const NeverScrollableScrollPhysics(),
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
                title: Text(listUnavailableItems[index],style:const TextStyle(fontSize: 16,fontWeight:
                FontWeight.w500),),
                onTap: (){
                  setState((){
                    if(index==1){_isCheckedList=[false,true];choose=true;}
                    else{_isCheckedList=[true,false];choose=false;}
                    ChatControllerCubit.get(context).increment();
                  });
                  setState(() {
                    containerPadding =false;
                  });
                  Timer(const Duration(milliseconds: 350), () {
                  setState(() {
                  containerPadding = true;
                  });});
                },
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 15.0,right: 15),
            child: BottomWidget(Strings.save.tr(context), (){Navigator.pop(context);}),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
bool choose=false;
List<bool> _isCheckedList =[ true,false];