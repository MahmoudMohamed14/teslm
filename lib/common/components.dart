import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import '../features/map_page/screen/maps.dart';
import '../features/search/screen/search_page.dart';
import 'colors/colors.dart';
import 'colors/theme_model.dart';
import 'images/images.dart';
bool loginFromCart=false;
void showDialogHelper(BuildContext context,
    {required Widget contentWidget,
      Color? backgroundColor,
      bool isFullScreen = true}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ThemeModel.of(context).backgroundColor,
        contentPadding:
        EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
        content: contentWidget,
      ));
}
Widget actionAppbar(context)=>Padding(
  padding: const EdgeInsets.all(10.0),
  child: InkWell(
    onTap: (){
      showModalBottomSheet(context: context, builder: (BuildContext context){
        return Container(
          padding: EdgeInsets.all(10),
          height: 140,child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on,
                  size: 25.0, color: Colors.red,),
                Flexible(child: Text( DeliveryCubit.get(context).currentLocationName!=''?'${DeliveryCubit.get(context).currentLocationName}':language=='English Language'?'Current Location':'عنوانك الحالى',maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20,color:isDark??false? floatActionColor:brownColor),)),
              ],),
            Spacer(),
            bottom(Strings.changeOrderLocation.tr(context), (){
                  navigate(context,
                      Maps(initialLocationName: '${DeliveryCubit.get(context).currentLocationName}',firstPosition: DeliveryCubit.get(context).position1??0,secondPosition:DeliveryCubit.get(context).position2??0 ,
                      ));})
          ],),);});
    },
    child: Container(
      width: MediaQuery.sizeOf(context).width/1.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(child: Text(DeliveryCubit.get(context).currentLocationName!=''?'${DeliveryCubit.get(context).currentLocationName}':language=='English Language'?'Current Location':'عنوانك الحالى',maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(color:floatActionColor),)),
          const Icon(
            Icons.location_on,
            size: 25.0, color: Colors.white,),
        ],),
    ),
  ),
);
Widget container(context)=>Padding(
  padding: const EdgeInsets.all(10.0),);
Widget buildTextField(
    IconData icon, String hintText, bool isPassword, type,{controller,validator,Color? background}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      decoration: InputDecoration(
        fillColor:background ,

        prefixIcon: Icon(
          icon,
          color: ColorsApp.iconColor,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorsApp.textColor1),
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        focusedBorder:const OutlineInputBorder(
          borderSide: BorderSide(color: ColorsApp.textColor1),
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: hintText,
        hintStyle:const TextStyle(fontSize: 14, color: ColorsApp.textColor1),
      ),

    ),
  );
}
Widget date(text,selected){
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: isDark??false? ColorsApp.cardsDarkColor:ColorsApp.myAccountTextFieldLightColor,
      borderRadius: BorderRadius.circular(35)
    ),
    child: Row(
      children: [
        Icon(
          Icons.date_range_outlined,
        ),
        SizedBox(width: 15,),
        Text(text,style:TextStyle(fontSize: 14, ))
      ],
    ),
  );
}
navigate( context,screen) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => screen));
}
void navigateAndFinish(context , Widget) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Widget), (route) => false);

/*Widget bottom(data,onTap){
  return
}*/
class bottom extends StatelessWidget {
  bottom(this.title,this.onTap,{super.key,this.width,this.color,this.radius});
  Function()? onTap;
  String ?title;
  double? width;
  double? radius;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width??double.infinity,
        height: 46,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: color??ColorsApp.orangeColor,
            borderRadius: BorderRadius.circular(radius??10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1))
            ]),
        child: Center(child:  Text(title??''  , style: TextStyle( fontWeight: FontWeight.w500 , fontSize: 15,color: Colors.white))),
      ),
    );
  }
}

Widget cartPaymentBottom(text,onTap,isProvider,context)=>BlocListener<DeliveryCubit, DeliveryState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  child: Container(
  color: isDark??false? Colors.black12:floatActionColor,
  width: double.infinity,
  padding: const EdgeInsets.only(bottom: 10.0,top: 10,left: 15,right: 15),
  child: InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(color: mainColor.shade400,borderRadius: BorderRadius.circular(10)),
      height: 50,
      width: MediaQuery.sizeOf(context).width/1.25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Text(Strings.sar.tr(context),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
              SizedBox(width: 5,),
              if(isProvider)
              Text('$price',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
              if(!isProvider)
              Text(DeliveryCubit.get(context).couponData!=null? "${totalPrice-(DeliveryCubit.get(context).couponData!.discount)!.toInt()}":'$totalPrice',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
              if(DeliveryCubit.get(context).couponData!=null&&!isProvider)
              SizedBox(width: 5,),
              if(DeliveryCubit.get(context).couponData!=null&&!isProvider)
              Text('$totalPrice',style: TextStyle(fontSize: 16 ,decoration: TextDecoration.lineThrough,color:Colors.white),),
            ],
          ),
          Text(text,maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
        ],),
    ),
  ),
),
);
Future bottomSheet(context,widget,{controller})=>showModalBottomSheet(
    transitionAnimationController: controller,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return widget;});
Widget search(width,data,onTap)=>Padding(
  padding: const EdgeInsets.only(top: 20.0,left: 20,right: 20),
  child: InkWell(
    onTap: onTap,
    child: Container(
      width: width,
      height: 40,decoration: const BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 5,),
          Icon(Icons.search,size: 25,color: brownColor,),
          const SizedBox(width: 15,),
          Text(data,style: TextStyle(fontSize: 15,color: Colors.grey),),
        ],
      ),),
  ),
);
Widget searchData(dataSearch,controller)=>TextFormField(
  autofocus: true,
  validator: (value){
    if(value!.isEmpty){return 'Enter text to search';}
    return null;
  },
  onChanged: (String text){
    if(text.isNotEmpty)
      dataSearch;
  },
  controller: controller,
  decoration: const InputDecoration(label: Text('search'),
    prefixIcon: Icon(Icons.search),
    border: OutlineInputBorder(),
  ),
  keyboardType: TextInputType.text,
);
Widget Skeleton({height,width,radius})  {
    return Shimmer.fromColors(
      baseColor: borderColor[isDark??false? 600:300]!,
      highlightColor: borderColor[isDark??false? 600:100]!,
      child: Padding(
        padding: EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius??0.0),color: Colors.white,),
              height: height,
              width: width,
            ),

      ));}

Widget image(url,height,width,reduis,fit)=>ClipRRect(
  borderRadius: BorderRadius.circular(reduis),
  child: CachedNetworkImage(
    placeholder: (context,url) => const Center(child: CircularProgressIndicator()),
    errorWidget: (context, url, error) =>  Icon(Icons.error),
    imageUrl: '$url',
    height: height,
    width: width,
    fit: fit,),);
Widget topBar(name,color,textColor)=>Container(
  padding: EdgeInsets.all(8),
  decoration: BoxDecoration(
    border:Border(
      bottom: BorderSide(
        color: color,
        width: 2.0, ),),
  ),
  child: Center(
    child: Text(
      '$name', overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
      style:TextStyle(
          fontSize: 18,fontWeight: FontWeight.w600,color: textColor),
    ),
  ),);

Widget seperate() =>Padding(
  padding: const EdgeInsets.all(10.0),
  child: Container(decoration: BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: isDark??false ? floatActionColor:Colors.grey,
        width: 0.8,
      ),
    ),
    color: Colors.orangeAccent,
  )),
);
Widget appBar(BuildContext context, bool mainPage) => SizedBox(
  height: 167,
  child: Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          color: ColorsApp.secondColorGreen),

        height: 150,
        width: double.infinity,
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              mainPage
                  ? Padding(
                    padding: const EdgeInsetsDirectional.only(start: 10),
                    child: SvgPicture.asset(
                        ImagesApp.logoAppImage,
                       width: 100, // You can set width and height as needed
                      height: 30,
                                    fit: BoxFit.cover,
                      ),
                  )
                  : Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              actionAppbar(context),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: search(
          double.infinity,
          Strings.searchRestaurantStores.tr(context),
              () => navigate(context, SearchPage()),
        ),
      ),
    ],
  ),
);
Widget appBarWithIcons(text,image,navigator,context)=>SafeArea(
  child: Container(
    decoration: const BoxDecoration(
        color: ColorsApp.secondColorGreen,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if(navigator)
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: IconButton(
                  icon:const  Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10),
              child: Text(text, style: const TextStyle(color: Colors.white,
                  fontSize: 25, fontWeight: FontWeight.w700),),
            ),
          ],
        ),
        Transform.flip(
          flipX:language=='en'? false:true,
          child: SvgPicture.asset(
            image,
            width: 70, // You can set width and height as needed
            height: 70,
          ),
        )
      ],
    ),),
);
List<Map<String, dynamic>> values = [];



