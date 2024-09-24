import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/colors/theme_model.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/common/images/images.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:delivery/features/main%20category%20page/widget/big_card.dart';
import 'package:delivery/features/main%20category%20page/widget/filter_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/components.dart';
import '../../provider page/screen/Provider page.dart';
import '../widget/category_shimmer_loading.dart';
import '../widget/change_view.dart';
import '../widget/filter.dart';
import '../widget/small_card.dart';

class MainCategories extends StatelessWidget {
  final String categoryName;

  const MainCategories({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(
      listener: (context, state) {
        // Handle state changes
      },
      builder: (context, state) {
        final scaffoldKey = GlobalKey<ScaffoldState>();
        var newOffers = DeliveryCubit.get(context).offersData;
        var view = DeliveryCubit.get(context).changeViewNew;
        var providers = DeliveryCubit.get(context).categoryProvideData;
        var filter = DeliveryCubit.get(context).filterProvideData;
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
                    preferredSize:const Size.fromHeight(65.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          newOffers!.data!.length,
                              (index) => InkWell(
                                onTap: (){
                                  DeliveryCubit.get(context).getProviderFoodData('${newOffers.data![index].provider?.id}');
                                  navigate(context, ProviderPage(
                                      providerDescription:language=='en'? '${newOffers.data![index].provider?.description!.en}':'${newOffers.data![index].provider?.description!.ar}',
                                      providerName: language=='en'?'${newOffers.data![index].provider?.providerName!.en}':'${newOffers.data![index].provider?.providerName!.ar}',
                                      providerCover: '${newOffers.data![index].provider?.providerCover}', providerImage: '${newOffers.data![index].provider?.providerImage}'));
                                },
                                child: Stack(
                                  children: [
                                Container(
                                  padding:const EdgeInsets.all(10),
                                  width: MediaQuery.sizeOf(context).width / 1.8,
                                  height: 117,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) =>
                                      const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                      imageUrl: '${newOffers.data![index].image}',
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 20,
                                  right: 20,
                                  bottom: 15,
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width / 5,
                                    padding: const EdgeInsets.only(left: 8, right: 8),
                                    color: Colors.black45,
                                    child: Row(
                                      children: [
                                        Text(
                                          language=='en'?'${newOffers.data![index].provider!.providerName!.en}':
                                          '${newOffers.data![index].provider!.providerName!.ar}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.58,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                                            ],
                                                          ),
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 15),
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
                ),
                SliverPersistentHeader(
                  pinned: true,  // Sticks the header at the top after scrolling
                  delegate: _SliverAppBarDelegate(
                    minHeight: 50.0,
                    maxHeight: 50.0,
                    child: Container(
                      color: Colors.white,
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
                          providerItem = filter.data![index];
                        } else {
                          providerItem = providers.providers![index];
                        }
                        return view
                            ? Padding(
                              padding:const EdgeInsets.only(left: 8.0,right: 8.0),
                              child: bigCardCategory(providerItem,
                                () {
                              DeliveryCubit.get(context).getProviderFoodData(providerItem.id);
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
                                ),
                              );
                              },context
                              ),
                            )
                            : Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                              child: smallCard(providerItem, () {
                                                        DeliveryCubit.get(context).getProviderFoodData(providerItem.id);
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