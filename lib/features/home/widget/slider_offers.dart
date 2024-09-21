import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../common/components.dart';
import '../../../common/constant values.dart';
import '../../provider page/screen/Provider page.dart';

Widget slider(market,controller,context)=>CarouselSlider(
    carouselController: controller,
    items: DeliveryCubit.get(context).offersData!.data!.map((e) => Padding(
      padding: const EdgeInsets.only(top: 10.0,right: 10),
      child:InkWell(
        onTap: (){
          DeliveryCubit.get(context).getProviderFoodData('${e.provider!.id}');
          navigate(context, ProviderPage(
              providerDescription:language=='en'? '${e.provider!.description!.en}':'${e.provider!.description!.ar}',
              providerName: language=='en'?'${e.provider!.providerName!.en}':'${e.provider!.providerName!.ar}',
              providerCover: '${e.provider!.providerCover}', providerImage: '${e.provider!.providerImage}'));
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: CachedNetworkImage(
            placeholder: (context,url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageUrl: '${e.image}',
            width: double.infinity,
            fit: BoxFit.cover,),
        ),
      ),
    )).toList(),
    options: CarouselOptions(
      onPageChanged: (index, reason) {
        DeliveryCubit.get(context).changeAdds(index);
      },
      enlargeFactor:0.3,
      aspectRatio: 9.0 / 16.0,
      enlargeCenterPage: true,
      viewportFraction: 0.5,
      initialPage:DeliveryCubit.get(context).offersData!.data!.length,height: 220,autoPlay: true,autoPlayInterval:const Duration(seconds: 10),
      autoPlayAnimationDuration: const Duration(seconds: 3),enableInfiniteScroll: true,
    ));