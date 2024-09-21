import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/constant%20values.dart';
import 'package:delivery/common/translate/applocal.dart';
import 'package:delivery/features/profile/navigator/chat/controller/chat_controller_cubit.dart';
import 'package:delivery/features/profile/navigator/setting.dart';
import 'package:delivery/shared%20prefernace/shared%20preferance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/images/images.dart';
import '../../../common/translate/strings.dart';
import '../../home/screens/home.dart';
import '../navigator/chat/chat.dart';
import '../navigator/edit data.dart';
import '../navigator/support.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {
    if(token==''){
      Save.savedata(key: 'token', value: '').then((value){
        });}
  },
  builder: (context, state) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(98.0),
        child: appBarWithIcons(Strings.more.tr(context),ImagesApp.moreSettingImage),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15,top: 20),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: isDark??false ?ColorsApp.cardsDarkColor:floatActionColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: <Widget>[
                  if(token!=''&&token!=null)
                  ProfileListItem(
                    icon: Icons.person_outline,
                    text: Strings.editInformation.tr(context),
                    hasNavigation: true,
                    onTap: (){
                      ChatControllerCubit.get(context).getChat();
                      if(DeliveryCubit.get(context).getUserData==null)
                      DeliveryCubit.get(context).getNewCustomer();
                      navigate(context, EditInformation());},
                  ),
                  if(token!=''&&token!=null)
                  ProfileListItem(
                    icon: Icons.add_card_outlined,
                    text: Strings.addPayment.tr(context),
                    hasNavigation: false,
                  ),
                  ProfileListItem(
                    icon: Icons.help_outline,
                    text: Strings.helpSupport.tr(context),
                    hasNavigation: true,
                    onTap: (){navigate(context, Support());},
                  ),
                  ProfileListItem(
                    icon: Icons.headset_mic_outlined,
                    text: Strings.callCenter.tr(context),
                    hasNavigation: true,
                    onTap: (){
                      ChatControllerCubit.get(context).getChat();
                      navigate(context, Chat());},
                  ),
                  ProfileListItem(
                    icon: Icons.settings_outlined,
                    text: Strings.settings.tr(context),
                    hasNavigation: true,
                      onTap: (){navigate(context, Setting());}
                  ),
                  if(token!=''&&token!=null)
                  ProfileListItem(
                    icon: Icons.person_add_alt,
                    text: Strings.inviteFriend.tr(context),
                    hasNavigation: false,
                  ),
                  if(token!=''&&token!=null)
                  ProfileListItem(
                    icon: Icons.login,
                    text: Strings.logout.tr(context),
                    hasNavigation: false,
                    onTap: ()async{
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      token=null;
                      balances=null;
                      customerId=null;
                      Save.remove(key: 'token');
                      Save.remove(key: 'balance');
                      Save.remove(key: 'customerId');
                      await auth.signOut();
                      DeliveryCubit.get(context).current=3;
                      navigateAndFinish(context,const Home());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  },
);
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  var onTap;

   ProfileListItem({super.key,
    required this.icon,
    required this.text,
    required this.hasNavigation,
     this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ).copyWith(
        ),
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        decoration: BoxDecoration(

        ),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Icon(
                  this.icon,
                  size: 20,
                ),
                SizedBox(width: 15),
                Text(
                  this.text,
                  style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15),
                ),
                Spacer(),
                if (this.hasNavigation)
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 20,
                    color: ColorsApp.iconsMainColor,
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20,top: 10),
              child: Container(decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDark??false ? floatActionColor:Colors.grey,
                    width: 0.8,
                  ),
                ),
                color: Colors.orangeAccent,
              )),
            )
          ],
        ),
      ),
    );
  }
}