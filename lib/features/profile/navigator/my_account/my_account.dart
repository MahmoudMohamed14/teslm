import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/images/images.dart';
import '../../../../common/translate/strings.dart';

class EditInformation extends StatelessWidget {
  const EditInformation({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime ?birthDate;
    bool dateSelected=false;
    return BlocConsumer<DeliveryCubit, DeliveryState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var user=DeliveryCubit.get(context).getUserData;
        TextEditingController nameController=TextEditingController(text: '${DeliveryCubit.get(context).getUserData?.name}');
        TextEditingController gmailController=TextEditingController(text:'${DeliveryCubit.get(context).getUserData?.email}');
        return Scaffold(
          appBar:  PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: appBarWithIcons(Strings.editInformation.tr(context),ImagesApp.myAccountImage,true,context)),
          body:DeliveryCubit.get(context).getUserData!=null?Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is UpdateUserLoading)
                  const LinearProgressIndicator(),
                const SizedBox(height: 15,),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: isDark??false ?ColorsApp.myAccountBackgroundDarkColor:floatActionColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      profile(Strings.myPhoneNumber.tr(context),true,TextEditingController(text: '${DeliveryCubit.get(context).getUserData?.phoneNumber}',),Icons.phone),
                      profile(Strings.myName.tr(context),false,nameController,Icons.person),
                      profile(Strings.myGmail.tr(context),false,gmailController,Icons.email,
                          validate: (value){
                            if(emailRegex.hasMatch(value)){ return null;}

                          }),
                      Text(Strings.myBirthDate.tr(context),style: const TextStyle(fontWeight: FontWeight.w400),),
                      StatefulBuilder(
                        builder:(context,setState)=> GestureDetector(
                            child: dateSelected?
                            date("${birthDate!.day}-${birthDate!.month}-${birthDate!.year}",true):date(user!.birthdate!=''? '${user.birthdate}':'mm/dd/yy',true),
                            onTap: () async{
                              final datePick= await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now(),
                              );
                              if(datePick!=null && datePick!=birthDate){
                                setState(() {
                                  dateSelected=true;
                                  birthDate=datePick;
                                });
                              }
                            }
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
          bottom(
            Strings.updateMyData.tr(context),
            radius: 30,
            color: ColorsApp.orangeColor,
                () {
                if (gmailController.text.isNotEmpty) {
                if(emailRegex.hasMatch(gmailController.text)) {
                  DeliveryCubit.get(context).userUpdate(email: gmailController.text);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red.shade400,
                    content: Text(Strings.enterValidEmail.tr(context),style: const TextStyle(color: Colors.white),),
                  ));
                }
                }
                if (nameController.text.isNotEmpty) {
                  DeliveryCubit.get(context).userUpdate(username: nameController.text);
                }
                if (birthDate != null) {
                  DeliveryCubit.get(context).userUpdate(
                    birthdate: '${birthDate!.year}-${birthDate!.month}-${birthDate!.day}',
                  );
                }
            },
          ),
                const SizedBox(height: 10,)
              ],
            ),
          ):const Center(child: LinearProgressIndicator()),
        );
      },
    );
  }
}
Widget profile(text,readOnly,controller,icon,{validate})=>Padding(
  padding: const EdgeInsets.only(bottom: 10.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("$text",style:const TextStyle(fontWeight: FontWeight.w400),),
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
            fillColor:isDark??false? ColorsApp.cardsDarkColor:ColorsApp.myAccountTextFieldLightColor,
            filled: true,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: textFieldColor,width: 0),
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
            ),
            hintText: '$text',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: readOnly? textFieldColor:mainColor.shade400),
              borderRadius: const BorderRadius.all(Radius.circular(35.0)),
            ),
            labelStyle: TextStyle(fontSize: readOnly? 22:14,color:isDark??false? Colors.white:Colors.black),
            contentPadding: const EdgeInsets.all(5),
          ),
        ),
      ),
    ],
  ),
);
