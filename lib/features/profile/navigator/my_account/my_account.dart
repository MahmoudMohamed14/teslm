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

class EditInformation extends StatelessWidget {
  const EditInformation({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime? birthDate;
    bool dateSelected = false;
    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) {},
      builder: (context, state) {
        print("data of user>>>>>>>  ${AccountCubit.get(context).getUserData}");
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
                            profile(Strings.myName.tr(context), false,
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
                                          "${birthDate!.day}-${birthDate!.month}-${birthDate!.year}",
                                          true,
                                          context)
                                      : date(
                                          user!.birthdate != ''
                                              ? '${user.birthdate}'
                                              : 'mm/dd/yy',
                                          true,
                                          context),
                                  onTap: () async {
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
                                  }),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      bottom(
                        Strings.updateMyData.tr(context),
                        radius: 30,
                        color: ThemeModel.mainColor,
                        () {
                          if (gmailController.text.isNotEmpty) {
                            if (emailRegex.hasMatch(gmailController.text)) {
                              AccountCubit.get(context).userUpdate(
                                  email: gmailController.text,
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
                          if (nameController.text.isNotEmpty) {
                            AccountCubit.get(context).userUpdate(
                                username: nameController.text,
                                context: context);
                          }
                          if (birthDate != null) {
                            AccountCubit.get(context).userUpdate(
                                birthdate:
                                    '${birthDate!.year}-${birthDate!.month}-${birthDate!.day}',
                                context: context);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                )
              : const Center(child: LinearProgressIndicator()),
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
