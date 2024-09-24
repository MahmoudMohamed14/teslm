import 'package:delivery/Cubite/delivery_cubit.dart';

import 'package:delivery/common/colors/theme_model.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/extensions.dart';
import 'package:delivery/common/images/images.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/widgets/app_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../common/colors/colors.dart';
import '../../../common/constant/constant values.dart';
import '../../../common/text_style_helper.dart';
import '../../../common/translate/strings.dart';
import '../../../models/provider items model.dart';
import '../../cart/screen/cart.dart';
import '../../cart/widgets/add_or_remove.dart';
import '../widget/loading_widget.dart';
import '../widget/menu_items.dart';
import '../widget/resturant_card.dart';
import '../widget/search_provider_page.dart';
import 'extra_items_class.dart';


class ProviderPage extends StatefulWidget {
  String providerDescription;
  String providerName;
  String providerCover;
  String providerImage;

  ProviderPage(
      {super.key,
      required this.providerDescription,
      required this.providerName,
      required this.providerCover,
      required this.providerImage});

  @override
  State<ProviderPage> createState() => _ProviderPage();
}

class _ProviderPage extends State<ProviderPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 700);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(
      listener: (context, state) {},
      builder: (context, state) {
        var menu = DeliveryCubit.get(context).providerFoodData;
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: ThemeModel.of(context).backgroundColor,
                surfaceTintColor: ThemeModel.of(context).backgroundColor,
                toolbarHeight: 100.h,
                pinned: true,
                // floating: true, // Set to true
                // snap: true,
                leading: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: ThemeModel.of(context).backgroundColor,
                      radius: 10,
                      child: Icon(
                        CupertinoIcons.xmark,
                        color: ThemeModel.of(context).font1,
                        size: 22,
                      ),
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(80.h),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 60,
                          //color: Colors.red,
                          width: double.maxFinite,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            image: const DecorationImage(image: AssetImage(ImagesApp.panner),fit: BoxFit.fill),
                          ),
                        ),
                        Positioned(
                          left: 25.w,
                           // bottom: 8,
                            child: image(widget.providerImage, 52.0, 52.0, 200.0, BoxFit.fill)),
                         Positioned(
                          left: 150.w,
                            //end: 20,
                          // right: 20,
                            // bottom: 8,
                            child: AppTextWidget(widget.providerName,style: TextStyleHelper.of(context).medium14.copyWith(color: ThemeModel.of(context).backgroundColor,fontSize: 20),)),
                      ],
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  title: AppTextWidget(
                    Strings.other.tr(context),
                    style: TextStyleHelper.of(context)
                        .bold20
                        .copyWith(color: ThemeModel.of(context).font2),
                  ),
                  background: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                        ),

                    ),
                    child: image(widget.providerCover, 120.h, double.maxFinite, 0.0, BoxFit.cover
                        ,borderRadius:const BorderRadius.only(
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                        )
                    ),
                    /*// child: Image.network("https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
                width: double.maxFinite,fit: BoxFit.cover,),*/
                  ),
                ),
                //expandedHeight: 200.h,
              ),
              SliverAppBar(
                expandedHeight: 60,
                // pinned: true,
                leading: const SizedBox.shrink(),
                flexibleSpace: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PriceWidget(
                        title: Strings.duration.tr(context),
                        value: '55-21',
                      ),
                      PriceWidget(
                          title: Strings.deliveryPrice.tr(context),
                          value: '55-21'),
                      PriceWidget(
                          title: Strings.minimumCharge.tr(context),
                          value: '55-21'),
                    ],
                  ),
                ),
                backgroundColor: ThemeModel.of(context).backgroundColor,
                surfaceTintColor: ThemeModel.of(context).backgroundColor,
              ),
              SliverAppBar(
                expandedHeight: 0.h,
                toolbarHeight: 30,
                pinned: true,
                leading: const SizedBox.shrink(),
                flexibleSpace: PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15,vertical: 10.h),
                    child: Container(
                     padding:  EdgeInsets.symmetric(vertical: 10.h),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: ThemeModel.of(context).font3,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 15),
                            child: Icon(
                              CupertinoIcons.search,
                              color: ThemeModel.of(context).font1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                backgroundColor: ThemeModel.of(context).backgroundColor,
                surfaceTintColor: ThemeModel.of(context).backgroundColor,
              ),
              SliverToBoxAdapter(
                child:menu!=null&&state is !GetProviderFoodLoading?menu.CategoriesItemsData!.isNotEmpty? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                      itemBuilder: (context, index1) {
                        return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        AppTextWidget(
                          menu?.CategoriesItemsData?[index1].name ?? '',
                        style: TextStyleHelper.of(context)
                            .bold20
                            .copyWith(color: ThemeModel.of(context).font2),
                        ),
                        8.0.heightBox,
                        ListView.separated(
                        itemBuilder: (context, index) =>OtherWidget(item: menu?.CategoriesItemsData?.firstOrNull?.items?[index],controller: controller,),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => 10.h.heightBox,
                    itemCount: menu?.CategoriesItemsData?[index1].items?.length ??0)
                  ],
                  );
                      } ,//OtherWidget(item: menu?.CategoriesItemsData?.firstOrNull?.items?[index],),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => 10.h.heightBox,
                      itemCount:menu?.CategoriesItemsData?.length ??0),
                ):
                Padding(
        padding: const EdgeInsets.only(top: 150.0),
        child: Center(child: Text(Strings.noUItemsFounded.tr(context))),
        ):Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
          itemBuilder: (context, index) =>const CategoryShimmer(),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => 10.h.heightBox,
          itemCount: 4),
        ),
              ),
             /* DecoratedSliver(
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
                              itemBuilder: (context,indexNew) {
                                print("new Index $indexNew" "index $index");
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          bottomSheet(context,
                                              ExtraItemsBottomSheet(
                                                extra: menu
                                                    .CategoriesItemsData![index]
                                                    .items![indexNew]
                                                    .optionGroups,
                                                itemImage: '${menu
                                                    .CategoriesItemsData![index]
                                                    .items![indexNew]
                                                    .image}',
                                                name: language == 'en'
                                                    ? '${menu
                                                    .CategoriesItemsData![index]
                                                    .items![indexNew].name!
                                                    .en}'
                                                    : '${menu
                                                    .CategoriesItemsData![index]
                                                    .items![indexNew].name!
                                                    .ar}',
                                                description: language ==
                                                    'en'
                                                    ? '${menu
                                                    .CategoriesItemsData![index]
                                                    .items![indexNew]
                                                    .description!.en}'
                                                    : '${menu
                                                    .CategoriesItemsData![index]
                                                    .items![indexNew]
                                                    .description!.ar}',
                                                price: menu
                                                    .CategoriesItemsData![index]
                                                    .items![indexNew].price,
                                                id: '${menu
                                                    .CategoriesItemsData![index]
                                                    .items![indexNew]
                                                    .id}',),
                                              controller: controller);
                                        },
                                        child: menuItems(
                                            menu.CategoriesItemsData?[index]
                                                .items?[indexNew]
                                                .optionGroups?.isNotEmpty??false
                                                ? () {
                                              bottomSheet(context,
                                                  ExtraItemsBottomSheet(
                                                      extra: menu
                                                          .CategoriesItemsData![index]
                                                          .items![indexNew]
                                                          .optionGroups
                                                      ,
                                                      itemImage: '${menu
                                                          .CategoriesItemsData![index]
                                                          .items![indexNew]
                                                          .image}',
                                                      name: language == 'en'
                                                          ? '${menu
                                                          .CategoriesItemsData![index]
                                                          .items![indexNew]
                                                          .name!.en}'
                                                          : '${menu
                                                          .CategoriesItemsData![index]
                                                          .items![indexNew]
                                                          .name!.ar}',
                                                      description: language ==
                                                          'en' ?
                                                      '${menu
                                                          .CategoriesItemsData![index]
                                                          .items![indexNew]
                                                          .description!.en}'
                                                          : '${menu
                                                          .CategoriesItemsData![index]
                                                          .items![indexNew]
                                                          .description!
                                                          .ar}',
                                                      price:
                                                      menu
                                                          .CategoriesItemsData![index]
                                                          .items![indexNew]
                                                          .price,
                                                      id:
                                                      '${menu
                                                          .CategoriesItemsData![index]
                                                          .items![indexNew]
                                                          .id}'),
                                                  controller: controller);
                                            }
                                                : () {
                                              DeliveryCubit.get(context)
                                                  .addValue(
                                                  language == 'en' ? '${menu
                                                      .CategoriesItemsData![index]
                                                      .items![indexNew]
                                                      .name!.en}' : '${menu
                                                      .CategoriesItemsData![index]
                                                      .items![indexNew]
                                                      .name!.ar}', 1, menu
                                                  .CategoriesItemsData![index]
                                                  .items![indexNew].image,
                                                  menu
                                                      .CategoriesItemsData![index]
                                                      .items![indexNew]
                                                      .price ?? 0, menu
                                                  .CategoriesItemsData![index]
                                                  .items![indexNew].id,
                                                  null);
                                            }

                                            ,
                                            menu.CategoriesItemsData?[index]
                                                .items?[indexNew]
                                                .optionGroups?.isNotEmpty??false
                                                ? true
                                                : false,
                                            menu.CategoriesItemsData![index]
                                                .items![indexNew], context,
                                            DeliveryCubit.get(context)
                                                .getValueById('${menu
                                                .CategoriesItemsData![index]
                                                .items![indexNew].id}') != 0
                                                ?
                                            addOrRemoveOne(
                                                DeliveryCubit.get(context)
                                                    .getValueById('${menu
                                                    .CategoriesItemsData![index]
                                                    .items![indexNew].id}'),
                                                context, menu
                                                .CategoriesItemsData![index]
                                                .items![indexNew]
                                                .optionGroups!.isNotEmpty
                                                ?
                                                () {
                                              bottomSheet(context,
                                                ExtraItemsBottomSheet(
                                                    extra: menu
                                                        .CategoriesItemsData![index]
                                                        .items![indexNew]
                                                        .optionGroups,
                                                    itemImage: '${menu
                                                        .CategoriesItemsData![index]
                                                        .items![indexNew]
                                                        .image}',
                                                    name: language == 'en'
                                                        ? '${menu
                                                        .CategoriesItemsData![index]
                                                        .items![indexNew]
                                                        .name!.en}'
                                                        : '${menu
                                                        .CategoriesItemsData![index]
                                                        .items![indexNew]
                                                        .name!.ar}',
                                                    description: language ==
                                                        'en'
                                                        ? '${menu
                                                        .CategoriesItemsData![index]
                                                        .items![indexNew]
                                                        .description!.en}'
                                                        : '${menu
                                                        .CategoriesItemsData![index]
                                                        .items![indexNew]
                                                        .description!.ar}',
                                                    price: menu
                                                        .CategoriesItemsData![index]
                                                        .items![indexNew]
                                                        .price,
                                                    id: '${menu
                                                        .CategoriesItemsData![index]
                                                        .items![indexNew]
                                                        .id}'),
                                                controller: controller,);
                                            }
                                                : () {
                                              DeliveryCubit.get(context)
                                                  .addValue(
                                                  language == 'en' ? '${menu
                                                      .CategoriesItemsData![index]
                                                      .items![indexNew]
                                                      .name!.en}' : '${menu
                                                      .CategoriesItemsData![index]
                                                      .items![indexNew]
                                                      .name!.ar}', 1, menu
                                                  .CategoriesItemsData![index]
                                                  .items![indexNew].image,
                                                  menu
                                                      .CategoriesItemsData![index]
                                                      .items![indexNew]
                                                      .price ?? 0, menu
                                                  .CategoriesItemsData![index]
                                                  .items![indexNew].id,
                                                  null);
                                            },
                                                    () {
                                                  DeliveryCubit.get(context)
                                                      .minusValue(
                                                      language == 'en'
                                                          ? '${menu
                                                          .CategoriesItemsData![index]
                                                          .items![indexNew]
                                                          .name!.en}'
                                                          : '${menu
                                                          .CategoriesItemsData![index]
                                                          .items![indexNew]
                                                          .name!.ar}', 1,
                                                      menu
                                                          .CategoriesItemsData![index]
                                                          .items![indexNew]
                                                          .image, menu
                                                      .CategoriesItemsData![index]
                                                      .items![indexNew]
                                                      .price ?? 0, menu
                                                      .CategoriesItemsData![index]
                                                      .items![indexNew].id);
                                                }, false)
                                                : null)),
                                  ],
                                );}
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
              ),*/
            ],
          ),
          bottomNavigationBar:  values.isNotEmpty?cartPaymentBottom(Strings.showCart.tr(context), (){navigate(context, Cart());}, true,context):null
          /* body:  SafeArea(
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
                                    itemBuilder: (context,indexNew) {
                                      print("new Index $indexNew" "index $index");
                                      return Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              bottomSheet(context,
                                                  ExtraItemsBottomSheet(
                                                    extra: menu
                                                        .CategoriesItemsData![index]
                                                        .items![indexNew]
                                                        .optionGroups,
                                                    itemImage: '${menu
                                                        .CategoriesItemsData![index]
                                                        .items![indexNew]
                                                        .image}',
                                                    name: language == 'en'
                                                        ? '${menu
                                                        .CategoriesItemsData![index]
                                                        .items![indexNew].name!
                                                        .en}'
                                                        : '${menu
                                                        .CategoriesItemsData![index]
                                                        .items![indexNew].name!
                                                        .ar}',
                                                    description: language ==
                                                        'en'
                                                        ? '${menu
                                                        .CategoriesItemsData![index]
                                                        .items![indexNew]
                                                        .description!.en}'
                                                        : '${menu
                                                        .CategoriesItemsData![index]
                                                        .items![indexNew]
                                                        .description!.ar}',
                                                    price: menu
                                                        .CategoriesItemsData![index]
                                                        .items![indexNew].price,
                                                    id: '${menu
                                                        .CategoriesItemsData![index]
                                                        .items![indexNew]
                                                        .id}',),
                                                  controller: controller);
                                            },
                                            child: menuItems(
                                                menu.CategoriesItemsData![index]
                                                    .items![indexNew]
                                                    .optionGroups!.isNotEmpty
                                                    ? () {
                                                  bottomSheet(context,
                                                      ExtraItemsBottomSheet(
                                                          extra: menu
                                                              .CategoriesItemsData![index]
                                                              .items![indexNew]
                                                              .optionGroups
                                                          ,
                                                          itemImage: '${menu
                                                              .CategoriesItemsData![index]
                                                              .items![indexNew]
                                                              .image}',
                                                          name: language == 'en'
                                                              ? '${menu
                                                              .CategoriesItemsData![index]
                                                              .items![indexNew]
                                                              .name!.en}'
                                                              : '${menu
                                                              .CategoriesItemsData![index]
                                                              .items![indexNew]
                                                              .name!.ar}',
                                                          description: language ==
                                                              'en' ?
                                                          '${menu
                                                              .CategoriesItemsData![index]
                                                              .items![indexNew]
                                                              .description!.en}'
                                                              : '${menu
                                                              .CategoriesItemsData![index]
                                                              .items![indexNew]
                                                              .description!
                                                              .ar}',
                                                          price:
                                                          menu
                                                              .CategoriesItemsData![index]
                                                              .items![indexNew]
                                                              .price,
                                                          id:
                                                          '${menu
                                                              .CategoriesItemsData![index]
                                                              .items![indexNew]
                                                              .id}'),
                                                      controller: controller);
                                                }
                                                    : () {
                                                  DeliveryCubit.get(context)
                                                      .addValue(
                                                      language == 'en' ? '${menu
                                                          .CategoriesItemsData![index]
                                                          .items![indexNew]
                                                          .name!.en}' : '${menu
                                                          .CategoriesItemsData![index]
                                                          .items![indexNew]
                                                          .name!.ar}', 1, menu
                                                      .CategoriesItemsData![index]
                                                      .items![indexNew].image,
                                                      menu
                                                          .CategoriesItemsData![index]
                                                          .items![indexNew]
                                                          .price ?? 0, menu
                                                      .CategoriesItemsData![index]
                                                      .items![indexNew].id,
                                                      null);
                                                }

                                                ,
                                                menu.CategoriesItemsData![index]
                                                    .items![indexNew]
                                                    .optionGroups!.length != 0
                                                    ? true
                                                    : false,
                                                menu.CategoriesItemsData![index]
                                                    .items![indexNew], context,
                                                DeliveryCubit.get(context)
                                                    .getValueById('${menu
                                                    .CategoriesItemsData![index]
                                                    .items![indexNew].id}') != 0
                                                    ? addOrRemoveOne(
                                                    DeliveryCubit.get(context)
                                                        .getValueById('${menu
                                                        .CategoriesItemsData![index]
                                                        .items![indexNew].id}'),
                                                    context, menu
                                                    .CategoriesItemsData![index]
                                                    .items![indexNew]
                                                    .optionGroups!.isNotEmpty
                                                    ? () {
                                                  bottomSheet(context,
                                                    ExtraItemsBottomSheet(
                                                        extra: menu
                                                            .CategoriesItemsData![index]
                                                            .items![indexNew]
                                                            .optionGroups,
                                                        itemImage: '${menu
                                                            .CategoriesItemsData![index]
                                                            .items![indexNew]
                                                            .image}',
                                                        name: language == 'en'
                                                            ? '${menu
                                                            .CategoriesItemsData![index]
                                                            .items![indexNew]
                                                            .name!.en}'
                                                            : '${menu
                                                            .CategoriesItemsData![index]
                                                            .items![indexNew]
                                                            .name!.ar}',
                                                        description: language ==
                                                            'en'
                                                            ? '${menu
                                                            .CategoriesItemsData![index]
                                                            .items![indexNew]
                                                            .description!.en}'
                                                            : '${menu
                                                            .CategoriesItemsData![index]
                                                            .items![indexNew]
                                                            .description!.ar}',
                                                        price: menu
                                                            .CategoriesItemsData![index]
                                                            .items![indexNew]
                                                            .price,
                                                        id: '${menu
                                                            .CategoriesItemsData![index]
                                                            .items![indexNew]
                                                            .id}'),
                                                    controller: controller,);
                                                }
                                                    : () {
                                                  DeliveryCubit.get(context)
                                                      .addValue(
                                                      language == 'en' ? '${menu
                                                          .CategoriesItemsData![index]
                                                          .items![indexNew]
                                                          .name!.en}' : '${menu
                                                          .CategoriesItemsData![index]
                                                          .items![indexNew]
                                                          .name!.ar}', 1, menu
                                                      .CategoriesItemsData![index]
                                                      .items![indexNew].image,
                                                      menu
                                                          .CategoriesItemsData![index]
                                                          .items![indexNew]
                                                          .price ?? 0, menu
                                                      .CategoriesItemsData![index]
                                                      .items![indexNew].id,
                                                      null);
                                                },
                                                        () {
                                                      DeliveryCubit.get(context)
                                                          .minusValue(
                                                          language == 'en'
                                                              ? '${menu
                                                              .CategoriesItemsData![index]
                                                              .items![indexNew]
                                                              .name!.en}'
                                                              : '${menu
                                                              .CategoriesItemsData![index]
                                                              .items![indexNew]
                                                              .name!.ar}', 1,
                                                          menu
                                                              .CategoriesItemsData![index]
                                                              .items![indexNew]
                                                              .image, menu
                                                          .CategoriesItemsData![index]
                                                          .items![indexNew]
                                                          .price ?? 0, menu
                                                          .CategoriesItemsData![index]
                                                          .items![indexNew].id);
                                                    }, false)
                                                    : null)),
                                      ],
                                    );}
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
                 if(values.isNotEmpty)cartPaymentBottom(Strings.showCart.tr(context), (){navigate(context, Cart());}, true,context)
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
  const OtherWidget({super.key, this.item, this.controller, });

  final Items? item;
  final AnimationController ?controller;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bottomSheet(context,
            ExtraItemsBottomSheet(
              extra: item?.optionGroups,
              itemImage: '${item?.image}',
              name: language == 'en'
                  ? '${item?.name?.en}'
                  : '${item?.name?.ar}',
              description: language ==
                  'en'
                  ? '${item?.description?.en}'
                  : '${item?.description?.ar}',
              price: item?.price,
              id: '${item?.id}',),
            controller: controller);
      },
      child: Container(
        height:144,
        decoration: BoxDecoration(
            color: ThemeModel.of(context).font4,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 12, top: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                   if (item?.optionGroups?.isNotEmpty??false)  AppTextWidget(
                        'Cusomizable',
                        style: TextStyleHelper.of(context)
                            .regular15
                            .copyWith(color: ThemeModel.of(context).font2),
                      ),
                      5.h.heightBox,
                      AppTextWidget(
                        language == 'en'
                            ? item?.name?.en ?? ''
                            : '${item?.name?.ar}',
                        style: TextStyleHelper.of(context).bold19,
                      ),
                      10.h.heightBox,
                      AppTextWidget(
                        language == 'en'
                            ? '${item?.description?.en}'
                            : '${item?.description?.ar}',
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: TextStyleHelper.of(context).regular12.copyWith(
                            color: ThemeModel.of(context).font2,
                            height: 1.3,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
                15.h.heightBox,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: ThemeModel.of(context).font2,
                    borderRadius: const BorderRadiusDirectional.only(
                        topEnd: Radius.circular(30),
                        bottomEnd: Radius.circular(30)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextWidget(
                        ' ${item?.price} ${Strings.sar.tr(context)}',
                        style: TextStyleHelper.of(context)
                            .regular15
                            .copyWith(color: ThemeModel.of(context).font3),
                      ),
                      5.w.widthBox,
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(ImagesApp.fire),
                          5.w.widthBox,
                          AppTextWidget(
                            '${item?.calories} ${Strings.calories.tr(context)}',
                            style: TextStyleHelper.of(context)
                                .regular15
                                .copyWith(color: ThemeModel.of(context).font3,),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              //  10.h.heightBox,
              ],
            ).expand,
            15.w.widthBox,
            //hi mostfa
            Stack(
              children: [
                image(item?.image, 144.0, 130.w, 20.0, BoxFit.cover),
                /* Container(
                  height:147.h ,
                width: 130.w,
                decoration:BoxDecoration(
                    color: ThemeModel.of(context).red,
                    borderRadius: BorderRadius.circular(20)
                )
              ),*/
                PositionedDirectional(
                    bottom: 2,
                    end: 3,
                    child: (DeliveryCubit.get(context).getValueById(item?.id??"")!=0)? addOrRemoveOne(
                        DeliveryCubit.get(context)
                            .getValueById('${item?.id}'),
                        context, item?.optionGroups?.isNotEmpty??false ?
                        () {
                      bottomSheet(context,
                        ExtraItemsBottomSheet(
                            extra: item?.optionGroups,
                            itemImage: '${item?.image}',
                            name: language == 'en'
                                ? '${item?.name!.en}'
                                : '${item?.name!.ar}',
                            description: language ==
                                'en'
                                ? '${item?.description!.en}'
                                : '${item?.description!.ar}',
                            price: item?.price,
                            id: '${item?.id}'),
                        controller: controller,);
                    }
                        : () {
                      DeliveryCubit.get(context)
                          .addValue(
                          language == 'en' ? '${item?.name!.en}' :
                          '${item?.name!.ar}', 1, item?.image,
                          item?.price ?? 0,item?.id,
                          null);
                    },
                            () {
                          DeliveryCubit.get(context)
                              .minusValue(
                              language == 'en'
                                  ? '${item?.name!.en}'
                                  : '${item?.name!.ar}'
                              , 1, item?.image, item?.price ?? 0,
                              item?.id);
                        }, false): InkWell(
                      onTap:
                          (){
                        ( item?.optionGroups?.isNotEmpty??false)?  bottomSheet(context,
                            ExtraItemsBottomSheet(
                                extra:item?.optionGroups
                                ,
                                itemImage: '${item?.image}',
                                name: language == 'en'
                                    ? '${item?.name?.en}'
                                    : '${item?.name?.ar}',
                                description: language ==
                                    'en' ?
                                '${item?.description?.en}'
                                    : '${item?.description?.ar}',
                                price: item?.price,
                                id:
                                '${item?.id}'),
                            controller: controller): DeliveryCubit.get(context)
                            .addValue(
                            language == 'en' ? '${item?.name!.en}' :
                            '${item?.name!.ar}', 1, item?.image,
                            item?.price ?? 0,item?.id,
                            null);
                      },
                      child: CircleAvatar(
                        backgroundColor: ThemeModel.of(context).primary,
                        radius: 15,
                        child: Icon(CupertinoIcons.add,
                            color: ThemeModel.of(context).backgroundColor),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key, this.value, this.title});

  final String? value;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextWidget(
          title ?? '',
          style: TextStyleHelper.of(context)
              .medium14
              .copyWith(color: ThemeModel.of(context).font1),
        ),
        10.h.heightBox,
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
              color: ThemeModel.of(context).greenAppBar,
              borderRadius: BorderRadius.circular(18)),
          child: AppTextWidget(
            '${value ?? ''} ${Strings.sar.tr(context)}',
            style: TextStyleHelper.of(context)
                .medium14
                .copyWith(color: ThemeModel.of(context).backgroundColor),
          ),
        )
      ],
    );
  }
}

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
       // Skeleton(width: 200.w,height: 30.h,radius: 16.0),
        20.h.heightBox,
        Skeleton(width: 100.w,height: 15.h,),
        10.h.heightBox,
        Container(
          height: 175.h,
          // padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: ThemeModel.of(context).cardsColor
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(width: 140.w,height: 179.h,radius: 18.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.h.heightBox,
                  Skeleton(width: 100.w,height: 15.h,),
                  12.h.heightBox,
                  Skeleton(width: 200.w,height: 20.h,),
                  // 5.h.heightBox,
                  Skeleton(width: 200.w,height: 5.h,),
                  Skeleton(width: 200.w,height: 5.h,),
                  12.h.heightBox,
                  Skeleton(width: 200.w,height: 30.h,radius: 16.0),
                ],)


            ],
          ),
        ),
      ],
    );
  }
}

