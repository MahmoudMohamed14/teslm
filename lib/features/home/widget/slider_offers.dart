import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';
import '../../provider page/controller/provider_cubit.dart';
import '../../provider page/screen/Provider page.dart';
import '../controller/home_cubit.dart';

Widget slider(market, controller, context) => CarouselSlider(
    carouselController: controller,
    items: HomeCubit.get(context)
        .offersData
        ?.data
        ?.map((e) => Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10),
              child: InkWell(
                onTap: () {
                  print(e.provider?.categories?.length??'test');
                  //  Save.remove(key: 'MyCart');
                  if ((e.provider?.categories?.firstOrNull?.name?.en?.toLowerCase()??'') == 'restaurants') {

                    ProviderCubit.get(context)
                        .isRestaurant = true;

                  } else {

                    ProviderCubit.get(context).isRestaurant = false;

                  }
                  values = [];
                  ProviderCubit.get(context)
                      .cardList
                      .forEach((action) {
                    if (e.provider?.id == action['ProviderId']) {
                      values.add(action);
                    }
                  });

                  ProviderCubit.get(context)
                      .getProviderData('${e.provider?.id}');
                  navigate(
                      context,
                      ProviderPage(
                        providerDescription: language == 'en'
                            ? '${e.provider?.description?.en}'
                            : '${e.provider?.description?.ar}',
                        providerName: language == 'en'
                            ? '${e.provider?.providerName?.en}'
                            : '${e.provider?.providerName?.ar}',
                        providerCover: '${e.provider?.providerCover}',
                        providerImage: '${e.provider?.providerImage}',
                        providerId: e.provider?.id ?? '',
                      ));
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      child: CachedNetworkImage(
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        imageUrl: '${e.image}',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              color: ThemeModel.mainColor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              language == 'en'? '${e.name?.en}':'${e.name?.ar}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ))
        .toList(),
    options: CarouselOptions(
      aspectRatio: 9.0 / 16.0,
      enlargeCenterPage: true,
      viewportFraction: 0.35,
      initialPage: HomeCubit.get(context).offersData?.data?.length ?? 0,
      height: 150,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 2),
      autoPlayAnimationDuration: const Duration(seconds: 2),
      enableInfiniteScroll: true,
    ));
