import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/features/profile/navigator/chat/controller/chat_controller_cubit.dart';
import 'package:delivery/features/profile/navigator/my_account/controller/account_cubit.dart';
import 'package:delivery/features/profile/navigator/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/colors/theme_model.dart';
import '../../../common/images/images.dart';
import '../../../common/translate/strings.dart';
import '../../../shared_preference/shared preference.dart';
import '../navigator/chat/chat.dart';
import '../navigator/logout/logout_dialog.dart';
import '../navigator/my_account/my_account.dart';
import '../navigator/my_coupons/my_coupons.dart';
import '../navigator/support/support.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(
      listener: (context, state) {
        if (token == '') {
          Save.savedata(key: 'token', value: '').then((value) {});
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(98.0),
            child: appBarWithIcons(Strings.more.tr(context),
                ImagesApp.moreSettingImage, false, context),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 20),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      color: ThemeModel.of(context).cardsColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: <Widget>[
                      if (token != '' && token != null)
                        ProfileListItem(
                          icon: Icons.person_outline,
                          text: Strings.editInformation.tr(context),
                          hasNavigation: true,
                          onTap: () {
                            ChatControllerCubit.get(context).getChat();
                            if (AccountCubit.get(context).getUserData == null) {
                              AccountCubit.get(context).getNewCustomer(context);
                            }
                            navigate(context, const EditInformation());
                          },
                        ),
                      if (token != '' && token != null)
                        ProfileListItem(
                          icon: Icons.add_card_outlined,
                          text: Strings.addPayment.tr(context),
                          hasNavigation: true,
                        ),
                      if (token != '' && token != null)
                        ProfileListItem(
                          icon: Icons.discount,
                          text: Strings.myCoupons.tr(context),
                          hasNavigation: true,
                          onTap: () {
                            navigate(context, const MyCoupons());
                          },
                        ),
                      ProfileListItem(
                        icon: Icons.help_outline,
                        text: Strings.helpSupport.tr(context),
                        hasNavigation: true,
                        onTap: () {
                          navigate(context, const Support());
                        },
                      ),
                      if (token != '' && token != null)
                        ProfileListItem(
                          icon: Icons.headset_mic_outlined,
                          text: Strings.callCenter.tr(context),
                          hasNavigation: true,
                          onTap: () {
                            ChatControllerCubit.get(context).getChat();
                            navigate(context, Chat());
                          },
                        ),
                      ProfileListItem(
                          icon: Icons.settings_outlined,
                          text: Strings.settings.tr(context),
                          hasNavigation: true,
                          onTap: () {
                            navigate(context, const Setting());
                          }),
                      if (token != '' && token != null)
                        ProfileListItem(
                          icon: Icons.person_add_alt,
                          text: Strings.inviteFriend.tr(context),
                          hasNavigation: false,
                        ),
                      if (token != '' && token != null)
                        ProfileListItem(
                          icon: Icons.login,
                          text: Strings.logout.tr(context),
                          hasNavigation: false,
                          onTap: () async {
                            logoutAccount(
                              context,
                            );
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
  final VoidCallback? onTap;
  const ProfileListItem({
    super.key,
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
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ).copyWith(),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Icon(
                  icon,
                  size: 20,
                ),
                const SizedBox(width: 15),
                Text(
                  text,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 15),
                ),
                const Spacer(),
                if (hasNavigation)
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 20,
                    color: ThemeModel.of(context).iconMainColor,
                  ),
              ],
            ),
            if (text != Strings.logout.tr(context))
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
                child: Container(
                    decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isDark ?? false ? floatActionColor : Colors.grey,
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
