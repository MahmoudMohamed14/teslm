import 'package:delivery/common/components.dart';
import 'package:delivery/common/extensions.dart';
import 'package:delivery/common/images/images.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/features/profile/navigator/my_account/controller/account_cubit.dart';
import 'package:delivery/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/colors/theme_model.dart';
import '../../../common/text_style_helper.dart';
import '../../../common/translate/strings.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../profile/navigator/my_account/my_account.dart';
import 'invite_new_friend.dart';

class InviteFriend extends StatelessWidget {
  const InviteFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(98.0),
        child: appBarWithIcons(Strings.inviteFriends.tr(context),

            ImagesApp.inviteFriendsIcon, true, context),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          
            children: [
              50.h.heightBox,
              Center(child: Image.asset(ImagesApp.inviteFriendImage, height:220.h,width: 270.w,)),
              10.h.heightBox,
              Center(
                child: SizedBox(
                  width: 250.w,
                    child: AppTextWidget(Strings.inviteFriendsEarn100.tr(context), style: TextStyleHelper.of(context).bold20.copyWith(color: ThemeModel.of(context).font1,height: 1.3),textAlign: TextAlign.center,)),
              ),
              10.h.heightBox,
              AppTextWidget(Strings.earn100WithEveryInvitation.tr(context), style: TextStyleHelper.of(context).regular14.copyWith(color: ThemeModel.of(context).font1,fontWeight: FontWeight.w300,height: 1.2),textAlign: TextAlign.center,),

             50.h.heightBox,
              profile(
                  Strings.inviteFriendWithPhoneNumber.tr(context),
                  true,
                  TextEditingController(
                    text:
                    '${AccountCubit.get(context).getUserData?.referCode}',
                  ),
                  Icons.phone,
                  context),

            ],
          ),
        ),
      ),
    );
  }
}
