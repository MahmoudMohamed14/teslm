import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Cubite/delivery_cubit.dart';
import '../../../../common/colors/colors.dart';
import '../../../../common/colors/theme_model.dart';
import '../../../../common/components.dart';
import '../../../../common/constant/constant values.dart';
import '../../../../common/images/images.dart';
import '../../../../shared_preference/shared preference.dart';
import '../../../home/controller/home_cubit.dart';
import '../../../home/screens/home.dart';

Future<void> logoutAccount(context,) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
            backgroundColor: ThemeModel.of(context).cardsColor,
            content: SizedBox(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(image: AssetImage(ImagesApp.logoutIcon),height: 80,),
                    Text(Strings.sureLogout.tr(context),style:const TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                    Expanded(child: Text(Strings.logoutMissCustomerMessage.tr(context),style:const TextStyle(fontWeight: FontWeight.w400,fontSize: 14),maxLines: 2,textAlign: TextAlign.center,),),
                  Row(children: [
                    Expanded(
                      child: bottom(
                        radius: 15,
                        color: ThemeModel.dark().myAccountBackgroundDarkColor,
                        Strings.cancel.tr(context),
                            () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: bottom(
                        radius: 15,
                        color: ThemeModel.mainColor,
                        Strings.logout.tr(context),
                            () async{
                          token=null;
                          balances=null;
                          customerId=null;
                          Save.remove(key: 'token');
                          Save.remove(key: 'balance');
                          Save.remove(key: 'customerId');
                          HomeCubit.get(context).current=3;
                          navigateAndFinish(context,const Home());
                        },
                      ),
                    ),
                  ],)
                  ],
                ),
              ),
            ),
          );
        },
      );
}