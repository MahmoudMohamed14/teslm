import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/colors/theme_model.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/constant%20values.dart';
import 'package:delivery/common/extensions.dart';
import 'package:delivery/common/translate/applocal.dart';
import 'package:delivery/features/provider%20page/widget/search_provider_page.dart';
import 'package:delivery/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../common/text_style_helper.dart';
import '../../../common/translate/strings.dart';
import '../../cart/screen/cart.dart';
import '../widget/add_or_remove_in_provider.dart';
import '../widget/loading_widget.dart';
import '../widget/menu_items.dart';
import '../widget/resturant_card.dart';
import 'extra_items_class.dart';
class ProviderPage extends StatefulWidget {
  String providerDescription;
  String providerName;
  String providerCover;
  String providerImage;

  ProviderPage({super.key,required this.providerDescription,required this.providerName,required this.providerCover,required this.providerImage});

  @override
  State<ProviderPage> createState() => _ProviderPage();
}

class _ProviderPage extends State<ProviderPage>with SingleTickerProviderStateMixin{
  late AnimationController controller;
  @override
  void initState(){
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 700);
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {},
  builder: (context, state) {
    var menu= DeliveryCubit.get(context).providerFoodData;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          OtherWidget()

        ],),
      )
     /* SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children:[ Expanded(
                child: Container(
                  color:isDark??false? Colors.grey:Colors.white,
                  child: CustomScrollView(
                    physics: state is !GetProviderFoodLoading?menu!.CategoriesItemsData!.length<1?NeverScrollableScrollPhysics():null:null,
                    controller: DeliveryCubit.get(context).scrollControllerColumn,
                    slivers: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500), // Set your desired duration
                      child: SliverAppBar(
                        leading: Container(),
                        expandedHeight: DeliveryCubit.get(context).expandedHeight,
                          bottom: PreferredSize(preferredSize: Size.fromHeight(240),child: Card(
                            child: Container(
                              width: double.infinity,
                              color: isDark??false? Colors.black87:floatActionColor,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                child:
                                menu!=null&&state is !GetProviderFoodLoading?Row(
                                  children: [
                                    IconButton(icon: Icon(Icons.search,size: 25,color: isDark??false ? floatActionColor:brownColor,),onPressed: (){setState(() {
                                      showSearchProvider=true;
                                    });},),
                                    Expanded(
                                      child: SizedBox(
                                        height: 50,
                                        child: ScrollablePositionedList.builder(
                                          physics: const AlwaysScrollableScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: menu.CategoriesItemsData!.length,
                                          itemBuilder: (context, index) => InkWell(
                                            onTap: (){DeliveryCubit.get(context).scrollToIndex(index);},
                                            child: topBar(menu.CategoriesItemsData![index].name,index == DeliveryCubit.get(context).currentIndex ? mainColor.shade400 : isDark??false? Colors.black87:floatActionColor,
                                                index == DeliveryCubit.get(context).currentIndex ? mainColor.shade300:isDark??false? floatActionColor:brownColor),
                                          ),
                                          itemScrollController: DeliveryCubit.get(context).itemScrollController,
                                        ),
                                      ),
                                    ),
                                  ],
                                ):Row(children: [Skeleton(width: 50.0,height: 15.0),Skeleton(width: 50.0,height: 15.0),Skeleton(width: 50.0,height: 15.0),Skeleton(width: 50.0,height: 15.0)],),
                              ),
                            ),
                          ),),
                          pinned: true,
                          floating: true, // Set to true
                          snap: true,
                        flexibleSpace: SafeArea(
                          child: Stack(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300), // Duration of the animation
                                  height: DeliveryCubit.get(context).imageHeight,
                                  child:image(widget.providerCover, DeliveryCubit.get(context).imageHeight, double.infinity,0.0,BoxFit.cover),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0,left: 20,right: 20),
                                  child: InkWell(
                                    onTap: (){Navigator.pop(context);},
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: borderColor.shade300,
                                      child: Icon(
                                        color: Colors.black,
                                        size: 22,
                                          Icons.close,
                                      ),
                                    ),
                                  ),
                                ),
                                AnimatedPadding(
                                    duration: Duration(milliseconds: 400), // Duration of the animation
                                    padding: EdgeInsets.only(top: DeliveryCubit.get(context).containerHeight==180? DeliveryCubit.get(context).containerPadding+100:DeliveryCubit.get(context).containerPadding+40),
                                    child: Container(width: double.infinity,color:isDark??false? Colors.black:floatActionColor,height:DeliveryCubit.get(context).containerHeight,)),
                                AnimatedPadding(
                                  duration: Duration(milliseconds: 200), // Duration of the animation
                                  padding: EdgeInsets.only(top: DeliveryCubit.get(context).containerPadding),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 200), // Duration of the animation
                                    padding: EdgeInsets.all(10),
                                    height:DeliveryCubit.get(context).containerHeight,
                                    width: MediaQuery.of(context).size.width-38,
                                    margin: EdgeInsets.only(left: 20,right: 20),
                                    decoration: BoxDecoration(
                                        color: isDark??false? Colors.blueGrey.shade500:Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(color: Colors.black87.withOpacity(0.3),
                                              blurRadius: 15, spreadRadius: 1),]),
                                    child: storeCard(context,widget.providerImage,widget.providerName,widget.providerDescription)
                                  ),
                                ),]),
                        ),
                      ),
                    ),
                      DecoratedSliver(
                        decoration: BoxDecoration(
                          color: isDark??false? Colors.black87:floatActionColor,
                        ),
                        sliver: menu!=null&&state is !GetProviderFoodLoading?menu.CategoriesItemsData!.isNotEmpty?SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return ListTile(  horizontalTitleGap: 0,
                                title:Text('${menu.CategoriesItemsData![index].name}',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: isDark??false ? Colors.white:brownColor),),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context,indexNew) =>Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: (){bottomSheet(context, ExtraItemsBottomSheet(extra:menu.CategoriesItemsData![index].items![indexNew].optionGroups,itemImage:'${menu.CategoriesItemsData![index].items![indexNew].image}', name:language=='en'? '${menu.CategoriesItemsData![index].items![indexNew].name!.en}':'${menu.CategoriesItemsData![index].items![indexNew].name!.ar}',description:language=='en'? '${menu.CategoriesItemsData![index].items![indexNew].description!.en}':'${menu.CategoriesItemsData![index].items![indexNew].description!.ar}',price: menu.CategoriesItemsData![index].items![indexNew].price,id: '${menu.CategoriesItemsData![index].items![indexNew].id}',),controller: controller);},
                                          child: menuItems(menu.CategoriesItemsData![index].items![indexNew].optionGroups!.isNotEmpty?(){
                                            bottomSheet(context, ExtraItemsBottomSheet(extra:menu.CategoriesItemsData![index].items![indexNew].optionGroups,itemImage:'${menu.CategoriesItemsData![index].items![indexNew].image}', name: language=='en'?'${menu.CategoriesItemsData![index].items![indexNew].name!.en}':'${menu.CategoriesItemsData![index].items![indexNew].name!.ar}',description: language=='en'? '${menu.CategoriesItemsData![index].items![indexNew].description!.en}':'${menu.CategoriesItemsData![index].items![indexNew].description!.ar}',price: menu.CategoriesItemsData![index].items![indexNew].price,id: '${menu.CategoriesItemsData![index].items![indexNew].id}'),controller: controller);}
                                              :(){DeliveryCubit.get(context).addValue(language=='en'?'${menu.CategoriesItemsData![index].items![indexNew].name!.en}':'${menu.CategoriesItemsData![index].items![indexNew].name!.ar}',1,menu.CategoriesItemsData![index].items![indexNew].image,menu.CategoriesItemsData![index].items![indexNew].price??0,menu.CategoriesItemsData![index].items![indexNew].id,null);},menu.CategoriesItemsData![index].items![indexNew].optionGroups!.length!=0?true : false,menu.CategoriesItemsData![index].items![indexNew],context,
                                              DeliveryCubit.get(context).getValueById('${menu.CategoriesItemsData![index].items![indexNew].id}')!=0? addOrRemoveOne(DeliveryCubit.get(context).getValueById('${menu.CategoriesItemsData![index].items![indexNew].id}'), context, menu.CategoriesItemsData![index].items![indexNew].optionGroups!.isNotEmpty?(){
                                              bottomSheet(context, ExtraItemsBottomSheet( extra:menu.CategoriesItemsData![index].items![indexNew].optionGroups,itemImage: '${menu.CategoriesItemsData![index].items![indexNew].image}', name:language=='en'?'${menu.CategoriesItemsData![index].items![indexNew].name!.en}':'${menu.CategoriesItemsData![index].items![indexNew].name!.ar}',description: language=='en'? '${menu.CategoriesItemsData![index].items![indexNew].description!.en}':'${menu.CategoriesItemsData![index].items![indexNew].description!.ar}',price: menu.CategoriesItemsData![index].items![indexNew].price,id: '${menu.CategoriesItemsData![index].items![indexNew].id}'),
                                                controller: controller,);}:(){DeliveryCubit.get(context).addValue(language=='en'?'${menu.CategoriesItemsData![index].items![indexNew].name!.en}':'${menu.CategoriesItemsData![index].items![indexNew].name!.ar}', 1,menu.CategoriesItemsData![index].items![indexNew].image,menu.CategoriesItemsData![index].items![indexNew].price??0,menu.CategoriesItemsData![index].items![indexNew].id,null);},
                                              (){DeliveryCubit.get(context).minusValue(language=='en'?'${menu.CategoriesItemsData![index].items![indexNew].name!.en}':'${menu.CategoriesItemsData![index].items![indexNew].name!.ar}', 1,menu.CategoriesItemsData![index].items![indexNew].image,menu.CategoriesItemsData![index].items![indexNew].price??0,menu.CategoriesItemsData![index].items![indexNew].id);},false):null)),
                                      ],
                                    )
                                    ,itemCount: menu.CategoriesItemsData![index].items!.length, separatorBuilder: (BuildContext context, int index) =>seperate(),),
                                  if(index!=menu.CategoriesItemsData!.length-1&&index!=0)
                                    seperate(),
                                ],
                              ),
                            );
                          }, childCount: menu.CategoriesItemsData!.length,
                        ), ):SliverList(delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {return Padding(
                            padding: const EdgeInsets.only(top: 150.0),
                            child: Center(child: Text(Strings.noUItemsFounded.tr(context))),
                          );},childCount: 1)):providerLoading(),
                    ),
                  ],
                  ),
                ),
              ),
                 if(values.isNotEmpty)
                   cartPaymentBottom(Strings.showCart.tr(context), (){navigate(context, Cart());}, true,context)
              ]
            ),
            if(showSearchProvider)
              searchProvider(context),
          ],
        ),
      )*/
    );
  },
);
  }

}

class OtherWidget extends StatelessWidget {
  const OtherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeModel.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextWidget('Cusomizable',style: TextStyleHelper.of(context).regular15.copyWith(color:ThemeModel.of(context).font2 ),),
                5.h.heightBox,
                AppTextWidget('El back mail 8 piece',style: TextStyleHelper.of(context).bold19,),
                10.h.heightBox,
                AppTextWidget('Crispy chicken pieces in   accordance with quality stand ',maxLines: 2
                  ,textAlign: TextAlign.start
                  ,style: TextStyleHelper.of(context).regular12.copyWith(color:ThemeModel.of(context).font2,overflow: TextOverflow.ellipsis ),),
              ],
            ),
          ),
          15.h.heightBox,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 13),
        decoration: BoxDecoration(
            color: ThemeModel.of(context).font2,
            borderRadius: const BorderRadius.only(topRight: Radius.circular(30),bottomRight:Radius.circular(30) ),


        ),
        child: Row(
          children: [
            AppTextWidget('sar 33',style: TextStyleHelper.of(context).regular15.copyWith(color:ThemeModel.of(context).font3 ),),
          ],
        ),
      ),

        ],)
      ],),
    );
  }
}
