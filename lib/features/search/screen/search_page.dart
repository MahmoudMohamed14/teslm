import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:flutter/material.dart';
import '../../../common/colors/colors.dart';

class SearchPage extends StatelessWidget {
  final textController=TextEditingController();
  final formKey=GlobalKey<FormState>();
  SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark??false ? Colors.black12:floatActionColor,
        toolbarHeight: 60,
        title: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    autofocus: true,
                    validator: (value){
                      if(value!.isEmpty){return Strings.enterTextSearch.tr(context);}
                      return null;
                    },
                    onChanged: (String text){},
                    controller: textController,
                    decoration: InputDecoration(label: Text(Strings.searchRestaurantStores.tr(context)),
                      prefixIcon:const Icon(Icons.search),
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ]
          ),
        ),
      ),),
        body: SafeArea(
          child: Container(),
        )
    );
  }
}
