import 'package:delivery/common/constant%20values.dart';
import 'package:flutter/material.dart';
import '../../common/colors/colors.dart';

class SearchPage extends StatelessWidget {
  var textcontroller=TextEditingController();
  var formkey=GlobalKey<FormState>();
  SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark??false ? Colors.black12:floatActionColor,
        toolbarHeight: 60,
        title: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    autofocus: true,
                    validator: (value){
                      if(value!.isEmpty){return 'Enter text to search';}
                      return null;
                    },
                    onChanged: (String text){},
                    controller: textcontroller,
                    decoration: InputDecoration(label: Text(
                        language=='English Language'?'Search restaurants or stores':'ابحث عن المطاعم او المتاجر'),
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
