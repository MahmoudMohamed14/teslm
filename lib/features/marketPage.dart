import 'package:carousel_slider/carousel_controller.dart';
import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/colors/theme_model.dart';
import 'home/controller/home_cubit.dart';
import 'home/widget/slider_offers.dart';

class Market extends StatelessWidget {
  const Market({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(listener:  (context, state) {},
        builder: (context, state) {
          CarouselController controller = CarouselController();
          return Scaffold(
            appBar: AppBar(  toolbarHeight: 100,backgroundColor:ThemeModel.mainColor,title: search(MediaQuery.sizeOf(context).width/1.4,language=='English Language'?'Search for a restaurant or stores':'ابحث عن المطاعم او المتاجر',(){},context),),
            body: HomeCubit.get(context).offersData != null?ListView(children: [
              Row(
                children: [
                image('https://images.deliveryhero.io/image/hungerstation/restaurant/android_cover_photo/99995897a8808d19a4cafb0be3677cec.jpg',75.0, 75.0,15.0,BoxFit.fill),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('تسلم ماركت',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(children: [Text('20 - 30 دقيقة',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:isDark??false? floatActionColor:brownColor),),
                          Text("مدة التوصيل",style: TextStyle(color:isDark??false? floatActionColor:brownColor,fontWeight: FontWeight.bold,),),
                        ],),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:8.0),
                        child: Column(
                          children: [Text('0 - 15 SAR',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:isDark??false? floatActionColor:brownColor),),
                          Text("رسوم التوصيل",style: TextStyle(color:isDark??false? floatActionColor:brownColor,fontWeight: FontWeight.bold,),),
                        ],),
                      ),Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [Text('20 SAR',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:isDark??false? floatActionColor:brownColor),),
                          Text("الحد الادنى للطلب",style: TextStyle(color:isDark??false? floatActionColor:brownColor,fontWeight: FontWeight.bold,),),
                        ],),
                      ),
                    ],
                  ),
                ],)
              ],),Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 15),
                child: Container(
                  width:double.infinity,
                  height: 1.5,color: borderColor,),
              ),
              slider(true,controller,context),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true, childAspectRatio: 1/0.5, crossAxisSpacing: 0, mainAxisSpacing: 0.0,
                crossAxisCount: 2,children: List.generate(2,
                    (index)=> Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                      Expanded(child: Text(' شيكولاته العيد',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                      image('https://images.deliveryhero.io/image/hungerstation/restaurant/android_cover_photo/99995897a8808d19a4cafb0be3677cec.jpg',85.0, 85.0,15.0,BoxFit.fill),
                        ],),
                    ),), ),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true, childAspectRatio:MediaQuery.of(context).size.width>=410? 0.7/1:0.9/1, crossAxisSpacing: 0, mainAxisSpacing: 0.0,
                crossAxisCount:MediaQuery.of(context).size.width>=410? 4 : 3,children: List.generate(8,
                    (index)=> Card(
                  child: Column(
                    children: [
                      image('https://images.deliveryhero.io/image/hungerstation/restaurant/android_cover_photo/99995897a8808d19a4cafb0be3677cec.jpg',85.0, 100.0,15.0,BoxFit.fill),
                      Expanded(child: Text(' شيكولاته العيد',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                    ],),
                ),), ),
            ],):Center(child: CircularProgressIndicator()),
          );
        });
  }
}
