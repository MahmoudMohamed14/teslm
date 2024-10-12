import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/common/extensions.dart';
import 'package:delivery/common/images/images.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/colors/colors.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../provider page/controller/provider_cubit.dart';
import '../../provider page/controller/provider_state.dart';
import '../../provider page/screen/Provider page.dart';

class SearchPage extends StatelessWidget {
  final textController=TextEditingController();
  final formKey=GlobalKey<FormState>();
  SearchPage({super.key,  this.isSmall=false, this.providerId});
  final bool isSmall;
 final String? providerId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderCubit, ProviderState>(
    listener: (context, state) {},
    builder: (context, state) {
      return  Scaffold(
      appBar: AppBar(
        leading:IconButton(onPressed: (){
          textController.clear();
          ProviderCubit.get(context).searchedItems=[];
          Navigator.pop(context);

        }, icon: Icon(Icons.arrow_back)) ,
      backgroundColor: isDark??false ? Colors.black12:floatActionColor,
    toolbarHeight: 60,
    /*   title: Form(
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
        )*/
    title: CustomTextFormField(
      controller: textController,
      prefixIcon: const Icon(CupertinoIcons.search),
      suffixIcon: textController.text.isNotEmpty? const Icon(CupertinoIcons.xmark):const SizedBox.shrink(),
      onSuffixTap: (){
        textController.clear();
        ProviderCubit.get(context).searchedItems=[];
        ProviderCubit.get(context).increment();
      },
      onchange: (value){
        ProviderCubit.get(context).searchProvider(value);
      },
    ),
    ),
    body:textController.text.isNotEmpty ? ProviderCubit.get(context).searchedItems.isNotEmpty? SafeArea(
    child: isSmall?Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 10.w,
        runSpacing: 10.w,
        children: List.generate(ProviderCubit.get(context).searchedItems.length ??0, (index)=>OtherWidgetSmall(item: ProviderCubit.get(context).searchedItems[index],provederId:providerId,controller: ProviderCubit.get(context).controller,),),
      ),
    )

        : Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
          itemBuilder: (context, index) =>OtherWidget(item: ProviderCubit.get(context).searchedItems[index],controller: ProviderCubit.get(context).controller,provederId: providerId,),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => 10.h.heightBox,
          itemCount: ProviderCubit.get(context).searchedItems.length ),
        ),
    ):const Center(child: Image(image: AssetImage(ImagesApp.searchImage),height:200,width: 200 ,),):const Center(child: Image(image: AssetImage(ImagesApp.emptySearch),height:200,width: 200 ,),),
    );
    }

    );
  }
}
