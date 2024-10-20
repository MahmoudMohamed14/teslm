import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/colors/theme_model.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/features/profile/navigator/my_account/controller/account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/images/images.dart';
import '../../../../common/translate/strings.dart';
class EditInformation extends StatefulWidget {
  const EditInformation({super.key});

  @override
  State<EditInformation> createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  void selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });

  }
  String? selectedGender;
  Widget genderOption(String gender, String icon,checkCondition) {
    return GestureDetector(
      onTap: () =>AccountCubit.get(context).getUserData?.gender != null ? null :   selectGender(gender),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: checkCondition ? ThemeModel.mainColor.withOpacity(0.2) : ThemeModel.of(context).cardsColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: checkCondition ? ThemeModel.mainColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              icon,
              height: 70,
              width: 70,
            ),
            SizedBox(height: 10),
            Text(
              gender,
              style: TextStyle(
                fontSize: 18,
                color: checkCondition ? ThemeModel.of(context).alwaysWhitColor : ThemeModel.of(context).blackWhiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    DateTime? birthDate;
    bool dateSelected = false;
    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) {},
      builder: (context, state) {
        var user = AccountCubit.get(context).getUserData;
        TextEditingController nameController = TextEditingController(
            text: '${AccountCubit.get(context).getUserData?.name}');
        TextEditingController gmailController = TextEditingController(
            text: '${AccountCubit.get(context).getUserData?.email}');
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: appBarWithIcons(Strings.editInformation.tr(context),
                  ImagesApp.myAccountImage, true, context)),
          body: AccountCubit.get(context).getUserData != null
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (state is UpdateUserLoading)
                          const LinearProgressIndicator(),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: ThemeModel.of(context)
                                  .myAccountBackgroundDarkColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              profile(
                                  Strings.myPhoneNumber.tr(context),
                                  true,
                                  TextEditingController(
                                    text:
                                        '${AccountCubit.get(context).getUserData?.phoneNumber}',
                                  ),
                                  Icons.phone,
                                  context),
                              profile(Strings.myName.tr(context),user?.name == null ? false : true,
                                  nameController, Icons.person, context),
                              profile(
                                  Strings.myGmail.tr(context),
                                  false,
                                  gmailController,
                                  Icons.email,
                                  context, validate: (value) {
                                if (emailRegex.hasMatch(value)) {
                                  return null;
                                }
                              }),
                              Text(
                                Strings.myBirthDate.tr(context),
                                style:
                                    const TextStyle(fontWeight: FontWeight.w400),
                              ),
                              StatefulBuilder(
                                builder: (context, setState) => GestureDetector(
                                    child: dateSelected
                                        ? date(
                                            "${birthDate!.year}-${birthDate!.month}-${birthDate!.day}",
                                            true,
                                            context)
                                        : date(
                                            user!.birthdate != null
                                                ? '${user.birthdate}'
                                                : 'YY/MM/DD',
                                            true,
                                            context),
                                    onTap:user!.birthdate != null? () async {
                                      final datePick = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime.now(),
                                      );
                                      if (datePick != null &&
                                          datePick != birthDate) {
                                        setState(() {
                                          dateSelected = true;
                                          birthDate = datePick;
                                        });
                                      }
                                    }:null),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                Strings.myGender.tr(context),
                                style:
                                const TextStyle(fontWeight: FontWeight.w400),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  genderOption('Male', ImagesApp.manImage,selectedGender == "Male"||user?.gender=='MALE'),
                                  genderOption('Female', ImagesApp.womanImage,selectedGender == "Female"||user?.gender=='Female'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      //  const Spacer(),
//G9tZXIiLCJpZCI6IjU1NWQ1OTZkLTFhZWEtNDUwOS05YmVkLWEwM2MxY2VlOGM2YSIsImlhdCI6MTcyODQyMTAzNywiZXhwIjoxNzMxMDEzMDM3fQ.d-DKvc0CnFDEHy1Y4x-PMXxTmDWUUNOi5g84SOYw6ZY
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                )
              : const Center(child: LinearProgressIndicator()),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton:   Padding(
            padding: const EdgeInsets.all(20),
            child: BottomWidget(
              Strings.updateMyData.tr(context),
              radius: 30,
              color: ThemeModel.mainColor,
                  () {
                if (gmailController.text.isNotEmpty) {
                  if ((emailRegex.hasMatch(gmailController.text) &&
                      gmailController.text != user?.email) ||
                      nameController.text.isNotEmpty) {
                    AccountCubit.get(context).userUpdate(
                        email: gmailController.text,
                        username: nameController.text,
                        context: context);
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(
                      backgroundColor: Colors.red.shade400,
                      content: Text(
                        Strings.enterValidEmail.tr(context),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ));
                  }
                }
                // if (nameController.text.isNotEmpty) {
                //   print("HHERE 11");
                //   AccountCubit.get(context).userUpdate(
                //       username: nameController.text,
                //       context: context);
                // }
                if (birthDate != null) {
                  AccountCubit.get(context).userUpdate(
                      birthdate:
                      '${birthDate!.year}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}',
                      context: context);
                }
                if(selectedGender != null){
                  AccountCubit.get(context).userUpdate(
                      gender:selectedGender?.toUpperCase(),
                      context: context);
                }
              },
            ),
          ),
        );
      },
    );
  }
}

Widget profile(text, readOnly, controller, icon, context, {validate}) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$text",
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 40,
            child: TextFormField(
              validator: validate,
              controller: controller,
              readOnly: readOnly,
              decoration: InputDecoration(

                prefixIcon: Icon(
                  icon,
                ),
                fillColor: ThemeModel.of(context).myAccountTextFieldLightColor,
                filled: true,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: textFieldColor, width: 0),
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                ),
                hintText: '$text',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: readOnly ? textFieldColor : ThemeModel.mainColor),
                  borderRadius: const BorderRadius.all(Radius.circular(35.0)),
                ),
                labelStyle: TextStyle(
                    fontSize: readOnly ? 22 : 14,
                    color: isDark ?? false ? Colors.white : Colors.black),
                contentPadding: const EdgeInsets.all(5),
              ),
            ),
          ),
        ],
      ),
    );
