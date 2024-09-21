import 'package:delivery/Cubite/them/app_dark_light_cubit.dart';
import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/constant%20values.dart';
import 'package:delivery/shared%20prefernace/shared%20preferance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/images/images.dart';
import '../../../common/translate/applocal.dart';
import '../../../common/translate/strings.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppDarkLightCubit, AppDarkLightState>(
  listener: (context, state) {},
  builder: (context, state) {
    isDark ??= false;
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.settings.tr(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Text(Strings.chooseLanguage.tr(context),
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                languageAndThem(false,'عربى',ImagesApp.arabicLanguage,language!='en'?Icons.check:null,language!='en'?mainColor.shade400: Colors.transparent, 'ar',language!='en'?mainColor.shade400:isDark??false?floatActionColor:borderColor,context),
                languageAndThem(false,'English',ImagesApp.englishLanguage,language=='en'?Icons.check:null,language=='en'?mainColor.shade400: Colors.transparent,'en',language=='en'?mainColor.shade400:isDark??false?floatActionColor:borderColor,context),
              ],
            ),


            SizedBox(height: 20,),
                  Text(Strings.them.tr(context),
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                languageAndThem(true,Strings.darkNode.tr(context),Icons.dark_mode,isDark??false?Icons.check:null,isDark??false?mainColor.shade400: Colors.transparent,language=='English Language'?'Dark mode':'العرض المظلم',isDark??false?mainColor.shade400:isDark??false?floatActionColor:borderColor,context),
                languageAndThem(true,Strings.lightMode.tr(context),Icons.light_mode,!isDark!?Icons.check:null,!isDark!?mainColor.shade400: Colors.transparent,'English Language',!isDark!?mainColor.shade400:isDark??false?floatActionColor:borderColor,context),
              ],
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
Widget languageAndThem(them,text,flag,icon,color,onTapLang,textBorderColor,context,)=>InkWell(
  onTap: them?(){AppDarkLightCubit.get(context).changeapppmode();
  isDark=!isDark!;
  Save.putdata(key: 'isDark', value: isDark??false);
  DeliveryCubit.get(context).increment();}
      :(){AppDarkLightCubit.get(context).changeLang(lange: onTapLang);},
  child: SizedBox(
    height: 150,
    width: 150,
    child: Card(
      color: isDark??false ?ColorsApp.cardsDarkColor:floatActionColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0,top: 10,left: 10),
            child: Align( alignment: AlignmentDirectional.topStart,child: CircleAvatar(backgroundColor:color,radius:10,child: Icon(icon,size: 18,color: Colors.white,))),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: 60,
            height: 50,
            decoration:  BoxDecoration(
              border: Border.all(color: textBorderColor,width: 1),
            ),
            child: them?Icon(flag,color: textBorderColor,):Image.asset(flag),
          ),
          Spacer(),
          Text(text,style: TextStyle(color: textBorderColor,fontWeight: FontWeight.w600),),
          SizedBox(height: 15,)
        ],
      ),
    ),
  ),
);