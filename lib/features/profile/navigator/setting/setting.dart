import 'package:delivery/Cubite/them/app_dark_light_cubit.dart';
import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/colors/theme_model.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/components.dart';
import '../../../../common/images/images.dart';
import '../../../../common/translate/app_local.dart';
import '../../../../common/translate/strings.dart';
import '../../../../shared_preference/shared preference.dart';
import '../chat/controller/chat_controller_cubit.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppDarkLightCubit, AppDarkLightState>(
  listener: (context, state) {},
  builder: (context, state) {
    isDark ??= false;
    return Scaffold(
      appBar:  PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: appBarWithIcons(Strings.settings.tr(context),ImagesApp.settingImage,true,context)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Text(Strings.chooseLanguage.tr(context),
              style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                languageAndThem(false,'عربى',ImagesApp.arabicLanguage,language!='en'?Icons.check:null,language!='en'?ThemeModel.mainColor: Colors.transparent, 'ar',language!='en'?ThemeModel.mainColor:isDark??false?floatActionColor:borderColor,context),
                languageAndThem(false,'English',ImagesApp.englishLanguage,language=='en'?Icons.check:null,language=='en'?ThemeModel.mainColor: Colors.transparent,'en',language=='en'?ThemeModel.mainColor:isDark??false?floatActionColor:borderColor,context),
              ],
            ),


            const SizedBox(height: 20,),
                  Text(Strings.them.tr(context),
                    style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                languageAndThem(true,Strings.darkNode.tr(context),Icons.dark_mode,isDark??false?Icons.check:null,isDark??false?ThemeModel.mainColor: Colors.transparent,language=='English Language'?'Dark mode':'العرض المظلم',isDark??false?ThemeModel.mainColor:isDark??false?floatActionColor:borderColor,context),
                languageAndThem(true,Strings.lightMode.tr(context),Icons.light_mode,!isDark!?Icons.check:null,!isDark!?ThemeModel.mainColor: Colors.transparent,'English Language',!isDark!?ThemeModel.mainColor:isDark??false?floatActionColor:borderColor,context),
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
  onTap: them?(){AppDarkLightCubit.get(context).changeAppMode();
  isDark=!isDark!;
  Save.putdata(key: 'isDark', value: isDark??false);
  ChatControllerCubit.get(context).increment();}
      :(){AppDarkLightCubit.get(context).changeLang(lange: onTapLang);},
  child: SizedBox(
    height: 150,
    width: 150,
    child: Card(
      color: ThemeModel.of(context).cardsColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0,top: 10,left: 10),
            child: Align( alignment: AlignmentDirectional.topStart,child: CircleAvatar(backgroundColor:color,radius:10,child: Icon(icon,size: 18,color: Colors.white,))),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: 60,
            height: 50,
            decoration:  BoxDecoration(
              border: Border.all(color: textBorderColor,width: 1),
            ),
            child: them?Icon(flag,color: textBorderColor,):Image.asset(flag),
          ),
          const Spacer(),
          Text(text,style: TextStyle(color: textBorderColor,fontWeight: FontWeight.w600),),
          const SizedBox(height: 15,)
        ],
      ),
    ),
  ),
);