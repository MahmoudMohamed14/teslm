import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/common/colors/theme_model.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/common/images/images.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:delivery/features/provider%20page/controller/provider_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/components.dart';
import '../../home/controller/home_cubit.dart';
import '../../provider page/screen/Provider page.dart';
import '../controller/category_cubit.dart';
import '../widget/big_card.dart';
import '../widget/category_offers.dart';
import '../widget/category_shimmer_loading.dart';
import '../widget/change_view.dart';
import '../widget/filter.dart';
import '../widget/filter_loading.dart';
import '../widget/small_card.dart';

class MainCategories extends StatelessWidget {
  final String categoryName;

  const MainCategories({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        // Handle state changes
      },
      builder: (context, state) {
       var cubit=CategoryCubit.get(context);
        final scaffoldKey = GlobalKey<ScaffoldState>();
        //var newOffers = HomeCubit.get(context).offersData;
        var view = CategoryCubit.get(context).changeViewNew;
        var providers = CategoryCubit.get(context).categoryProvideData;
        var filter = CategoryCubit.get(context).filterProvideData;
        return Scaffold(
          key: scaffoldKey,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(200.0),
            child:appBar(context,false),
          ),
          body:providers!=null&&state is !CategoryProviderLoading? Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: Container(),
                  bottom: PreferredSize(
                    preferredSize:const Size.fromHeight(100.0),
                    child: categorySlider(context),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        categoryName,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: [
                          viewNew(ImagesApp.categoryBigViewImage, view ? ThemeModel.of(context).greenAppBar :  ThemeModel.of(context).greenAppBar.withOpacity(0.4), context),
                          viewNew(ImagesApp.categorySmallViewImage, view ?  ThemeModel.of(context).greenAppBar.withOpacity(0.4) : ThemeModel.of(context).greenAppBar, context),
                        ],
                      ),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,  // Sticks the header at the top after scrolling
                  delegate: _SliverAppBarDelegate(
                    minHeight: 50.0,
                    maxHeight: 50.0,
                    child: Container(
                      color: ThemeModel.of(context).cardsColor,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(2, (index) => changeItems(index, context)),
                        ),
                      ),
                    ),
                  ),
                ),
                if (providers.providers!.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 170),
                      child: Center(
                        child: Text(Strings.thisNotWorkLocation.tr(context),
                          style:const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                        ),
                      ),
                    ),
                  ) ,
                if (providers.providers!.isNotEmpty)
                state is FilterProviderLoading?
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: 1,
                (context, index) {
                  return view? filterBigViewLoading():filterSmallViewLoading();
                }))
                :SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        var providerItem;
                        if (filter != null) {
                          providerItem = filter.data?[index];
                        } else {
                          providerItem = providers.providers?[index];
                        }
                        return view
                            ? Padding(
                              padding:const EdgeInsets.only(left: 8.0,right: 8.0),
                              child: bigCardCategory(providerItem,
                                () {
                                  ProviderCubit.get(context).expandedHeight=80;
                                  ProviderCubit.get(context).opecity=1;
                              ProviderCubit.get(context).getProviderFoodData(providerItem.id);
                                  values=[];
                                  ProviderCubit.get(context).cardList.forEach((action){
                                    if(providerItem?.id==action['ProviderId']){
                                      values.add(action);

                                    }
                                  });

                              navigate(
                                context,
                                ProviderPage(
                                  providerDescription: language == 'en'
                                      ? providerItem.description!.en
                                      : providerItem.description!.ar,
                                  providerName: language == 'en'
                                      ? providerItem.providerName!.en
                                      : providerItem.providerName!.ar,
                                  providerCover: providerItem.providerCover,
                                  providerImage: providerItem.providerImage,
                                  providerId: providerItem.id,
                                ),
                              );
                              },context
                              ),
                            )
                            : Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                              child: smallCard(providerItem, () {

                                ProviderCubit.get(context).expandedHeight=80;
                                ProviderCubit.get(context).opecity=1;
                                ProviderCubit.get(context).getProviderFoodData(providerItem.id);
                                values=[];
                                ProviderCubit.get(context).cardList.forEach((action){
                                  if(providerItem?.id==action['ProviderId']){
                                    values.add(action);

                                  }
                                });
                                                        navigate(context,
                              ProviderPage(
                                providerDescription: language == 'en'
                                    ? providerItem.description!.en
                                    : providerItem.description!.ar,
                                providerName: language == 'en'
                                    ? providerItem.providerName!.en
                                    : providerItem.providerName!.ar,
                                providerCover: providerItem.providerCover,
                                providerImage: providerItem.providerImage,
                                providerId: providerItem.id,
                              ),
                                                        );
                                                      },context),
                            );
                      },
                      childCount:filter!=null? filter.data!.length:providers.providers!.length,
                    ),
                  ),
              ],
            ),
          ):categoryLoading(categoryName, view, context),
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}