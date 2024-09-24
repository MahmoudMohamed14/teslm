import 'package:flutter/material.dart';
import '../../../common/colors/colors.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../shared_preference/shared preference.dart';
import '../../home/screens/home.dart';
import 'onboarding_data.dart';

Widget onBoardingBody(context,currentPage,onTap) {
  final controller=PageController();
  void submit(){
    Save.savedata(key: 'save', value: true).then((value) {
      Save.savedata(key: 'lang', value:'اللغه العربيه' ).then((value){
        if(value){
          navigateAndFinish(context ,const Home());
        }});
    });
  }
  return SafeArea(child: Padding(
  padding: const EdgeInsets.all(14.0),
  child: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: (){submit();}, child:const Text('تخطى',style: TextStyle(fontFamily: 'fontTop',color: ThemeModel.mainColor,fontWeight: FontWeight.w500,fontSize: 18),)),
        ],
      ),
      const SizedBox(height: 25,),
      Expanded(
        child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: onBoardingItems.length,
            controller: controller,
            onPageChanged: onTap,
            itemBuilder: (context,index){
              final items=onBoardingItems[index];
              return Column(
                children: [
                  Image(image: AssetImage(items.image)),
                  Text(items.headText,style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: brownColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'fontTop',
                      fontSize: 25
                  ),),
                  Text(items.mainText,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontFamily: 'fontTop',
                        color: Colors.black,
                        fontSize: 18
                    ),),
                ],);
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0,bottom: 10),
            child: AnimatedContainer(
              duration: const Duration(microseconds: 100),
              height: 10,
              width: currentPage==index ?30:10,
              decoration: BoxDecoration(
                  color: currentPage==index? ThemeModel.mainColor:Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(5)
              ),),
          );
        }),),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: bottom(currentPage==2?'جرب التطبيق':'متابعه', (){
          if(currentPage==2){submit();}
          else{ controller.nextPage(duration: const Duration(microseconds: 300), curve: Curves.easeIn);}
        },),
      ),
      const SizedBox(height: 20,)
    ],),
));
}
