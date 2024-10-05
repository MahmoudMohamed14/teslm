import 'package:delivery/common/components.dart';
import 'package:delivery/common/extensions.dart';
import 'package:delivery/common/images/images.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/colors/theme_model.dart';
import '../../../common/text_style_helper.dart';
import '../../../common/translate/strings.dart';
import '../../../widgets/custom_text_form_field.dart';
import 'invitaion_history.dart';

class InviteNewFriend extends StatelessWidget {
  const InviteNewFriend({super.key});

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
              Center(child: SizedBox(
                      width: 250.w,
                      child: AppTextWidget("${Strings.inviteFriendWithPhoneNumber.tr(context)}12323456789", style: TextStyleHelper.of(context).regular14.copyWith(color: ThemeModel.of(context).font1,fontWeight: FontWeight.w300,height: 1.2),textAlign: TextAlign.center,))),
             12.h.heightBox,
              Center(child: SizedBox(
                  width: 250.w,
                  child: AppTextWidget("${Strings.youReceivedCode.tr(context)} \n 12323456789 \n ${Strings.andEarned100Points.tr(context)} ", style: TextStyleHelper.of(context).bold12.copyWith(color: ThemeModel.of(context).font1,fontSize: 14,height: 1.2),textAlign: TextAlign.center,))),
              120.h.heightBox,
              Center(
                child: SizedBox(
                    width: 250.w,
                    child: AppTextWidget(Strings.earnMoreWithEveryInvitation.tr(context), style: TextStyleHelper.of(context).bold20.copyWith(color: ThemeModel.of(context).font1,height: 1.3),textAlign: TextAlign.center,)),
              ),
              10.h.heightBox,
              AppTextWidget(Strings.earn100WithEveryInvitation.tr(context), style: TextStyleHelper.of(context).regular14.copyWith(color: ThemeModel.of(context).font1,fontWeight: FontWeight.w300,height: 1.2),textAlign: TextAlign.center,),

              50.h.heightBox,
              AppTextWidget(Strings.inviteFriendWithPhoneNumber.tr(context), style: TextStyleHelper.of(context).regular14.copyWith(color: ThemeModel.of(context).font1,fontWeight: FontWeight.w300,height: 1.2),textAlign: TextAlign.start,),
              4.h.heightBox,
              CustomTextFormField(enable: true,borderRadiusValue: 20.r,prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(ImagesApp.phoneIcon),

              ),
                textInputType: TextInputType.phone,
                backGroundColor: ThemeModel.of(context).myAccountTextFieldLightColor,

              ),
              100.h.heightBox,

              BottomWidget(Strings.inviteNewFriend.tr(context), (){
                navigate(context, const InvitationHistory());
              },radius: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
