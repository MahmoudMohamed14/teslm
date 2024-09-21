import 'dart:async';
import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/constant%20values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/images/images.dart';
import '../home/screens/home.dart';

class OrderDetails extends StatelessWidget {
  int orderIndex;
  OrderDetails({super.key,required this.orderIndex});
  @override
  Widget build(BuildContext context) {
     int _index = 4;
    return BlocConsumer<DeliveryCubit, DeliveryState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(DeliveryCubit.get(context).position1??0, DeliveryCubit.get(context).position2??0),
                zoom: 12.4746),),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0,left: 20,right: 20),
              child: InkWell(
                onTap: (){Navigator.pop(context);},
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: borderColor.shade300,
                  child: Icon(
                    color: Colors.black,
                    size: 22,
                    Icons.arrow_back_ios_sharp,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 75.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(width:language=='English Language'? 140:100,height: 35,decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: mainColor,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    CircleAvatar(radius: 13,child: Icon(Icons.home,size: 25,color: mainColor.shade500,),backgroundColor: Colors.white,),
                    Text(language=='English Language'?'Apartment':'البيت',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
                  ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0),
                    child: CustomPaint(
                      size: const Size(300, 550),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomSheet:
      MyDraggableSheet(child: BottomSheetDummyUI(),orderIndex: orderIndex,),);
      },
    );
  }
}
class BottomSheetDummyUI extends StatelessWidget {
  const BottomSheetDummyUI({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           SizedBox(height: 10),
            seperate(),
            SizedBox(height: 15),
          ],
        ));
  }
}
class MyDraggableSheet extends StatelessWidget {
  final Widget child;
  int orderIndex;
  MyDraggableSheet({super.key, required this.child,required this.orderIndex});

  final sheet = GlobalKey();
  final controller = DraggableScrollableController();
  DraggableScrollableSheet get getSheet =>
      (sheet.currentWidget as DraggableScrollableSheet);

  @override
  Widget build(BuildContext context) {
    int _index = 3;
    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var order=DeliveryCubit.get(context).customerOrders;
    return LayoutBuilder(builder: (context, constraints) {
      return DraggableScrollableSheet(
        key: sheet,
        initialChildSize: 0.85,
        maxChildSize: 0.85,
        minChildSize: 0.85,
        expand: false,
        snap: false,

        controller: controller,
        builder: (BuildContext context, ScrollController scrollController) {
          return DecoratedBox(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
              child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    slivers: [
                      topButtonIndicator(),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                language == 'English Language'
                                    ? 'Estimated Arrival Time'
                                    : 'وقت الوصول المقدر',
                                textDirection: language == 'English Language'
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: isDark ?? false ? Colors.white : borderColor.shade700,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '6 ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    language == 'English Language' ? 'minutes' : 'دقيقة',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                              NumberStepper(
                                totalSteps: 3,
                                curStep: _index,
                                stepCompleteColor: mainColor.shade400,
                                currentStepColor: mainColor.shade100,
                                inactiveColor: Color(0xffbababa),
                                lineHeight: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                language == 'English Language'
                                    ? 'Mostafa is coming to you'
                                    : 'مصطفى تحرك من المطعم وفى الطريق اليك',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              seperate(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                   height: MediaQuery.sizeOf(context).height/1.6,
                   child: ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                          child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                         Image.asset(
                           ImagesApp.deliveryManImage,
                          width: 90,
                          height: 90,),
                          Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Mostafa',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                              Text(language=='English Language'?'Is your delivery hero for today':'هو بطل توصيل طلبك اليوم',textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: isDark??false?Colors.white:borderColor.shade700),)
                            ],),
                            ),
                            Row(
                          children: [
                            InkWell(
                              onTap: (){
                                makePhoneCall('+966566310766');
                              },
                              child: CircleAvatar(
                                  radius: 20,
                                  child: Icon(Icons.phone,size: 30,color: mainColor.shade400,)),
                            ),
                            SizedBox(width: 15,),
                            InkWell(
                              onTap: ()async{
                                openWhatsAppChat('+966566310766');
                              },
                              child: CircleAvatar(
                                  radius: 20,child: Image(image: AssetImage(ImagesApp.whatsAppImage),width: 40,height: 40,)),
                            ),
                            SizedBox(width: 15,),
                            CircleAvatar(
                                radius: 20,child: Icon(Icons.chat,size: 30,color: mainColor.shade400)),
                          ],
                                                ),
                                              ],),
                        ),
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
                      color: mainColor.shade50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: [
                              if(language=='English Language')
                            Text('You earned ${order!.data![orderIndex].totalPrice??0*10} points for this order',textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: borderColor.shade700),),
                              if(language!='English Language')
                              Row(
                                children: [
                                  Text('لقد حصلت على ',textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: isDark??false?Colors.white:borderColor.shade700),),
                                  Text(' ${(order!.data![orderIndex].totalPrice!+order.data![orderIndex].shippingPrice!)*10} ',textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: borderColor.shade700),),
                                  Text('من هذا الطلب',textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: isDark??false?Colors.white:borderColor.shade700),),
                                ],
                              ),
                              InkWell(onTap: (){
                                pageController=PageController(initialPage: 1);
                                navigate(context, Home());},
                            child: Text(language=='English Language'?'View rewards':'شوف هديتك',textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: isDark??false?Colors.white:mainColor.shade700),))
                          ],),
                        ),
                        Image(image: AssetImage(ImagesApp.giftImage),height: 60,width: 60,),
                      ],),),
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(language=='English Language'?'Delivering to':'توصيل إلى',textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: isDark??false?Colors.white:borderColor.shade700),),
                          Row(children: [Icon(Icons.home,size: 40,color: mainColor.shade500,),
                            SizedBox(width: 5,),
                            Text(language=='English Language'?'Apartment':'البيت',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                          ],),
                          Text('${DeliveryCubit.get(context).currentLocationName}',textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: isDark??false?Colors.white:borderColor.shade700),)
                        ],),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(language=='English Language'?'Your order from':'طلبك من',textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: isDark??false?Colors.white:borderColor.shade700),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text(language=='English Language'?'${order!.data![orderIndex].providerOrders!.providerName!.en}':'${order!.data![orderIndex].providerOrders!.providerName!.ar}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                            image('${order.data![orderIndex].providerOrders!.providerImage}', 40.0, 50.0, 5.0,BoxFit.cover),
                          ],),
                          Text(language=='English Language'?'${order.data![orderIndex].providerOrders!.description!.en}':'${order.data![orderIndex].providerOrders!.description!.ar}',textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: isDark??false?Colors.white:borderColor.shade700),)
                        ],),
                    ),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context,index)=>seperate(),
                            itemCount: order.data![orderIndex].items!.length,
                            itemBuilder: (context,itemIndex)=>Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: image('${order.data![orderIndex].items![itemIndex].image}', 70.0, 60.0, 40.0,BoxFit.fill),
                                ),
                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(language=='English Language'?'${order.data![orderIndex].items![itemIndex].item!.name!.en}':'${order.data![orderIndex].items![itemIndex].item!.name!.ar}',maxLines: 2, overflow: TextOverflow.ellipsis,style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),),
                                      SizedBox(height: 5,),
                                      Text('${order.data![orderIndex].items![itemIndex].price} SR',maxLines: 1, overflow: TextOverflow.ellipsis,style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                                    ],
                                  ),
                                )),
                                Padding(
                                  padding: const EdgeInsets.only(right:10,left:10.0),
                                  child: CircleAvatar(radius: 14,backgroundColor: mainColor.shade400,
                                  child: Text('${order.data![orderIndex].items![itemIndex].quantity}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17,color: Colors.white),),),
                                ),
                              ],))
                                   ],
                                   ),
                 ),
              ],
              ),
          );
        },
      );
    });
  },
);
  }

  SliverToBoxAdapter topButtonIndicator() {
    return SliverToBoxAdapter(
      child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    child: Center(
                        child: Wrap(children: <Widget>[
                          Container(
                              width: 100,
                              margin: const EdgeInsets.only(top: 10, bottom: 10),
                              height: 5,
                              decoration: const BoxDecoration(
                                color: Colors.black45,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              )),
                        ]))),
              ])),
    );
  }
}


class NumberStepper extends StatefulWidget {
  const NumberStepper({super.key,
    required this.curStep,
    required this.stepCompleteColor,
    required this.totalSteps,
    required this.inactiveColor,
    required this.currentStepColor,
    required this.lineHeight,});
  final totalSteps;
  final int curStep;
  final Color stepCompleteColor;
  final Color currentStepColor;
  final Color inactiveColor;
  final double lineHeight;
  @override
  State<NumberStepper> createState() => _NumberStepperState(
    curStep: curStep,
    stepCompleteColor: stepCompleteColor, totalSteps: totalSteps,
    inactiveColor: inactiveColor,
    currentStepColor: currentStepColor,
    lineHeight: lineHeight,);
}

class _NumberStepperState extends State<NumberStepper> with TickerProviderStateMixin{
  final totalSteps;
  final int curStep;
  final Color stepCompleteColor;
  final Color currentStepColor;
  final Color inactiveColor;
  final double lineHeight;
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;
  Timer? _animationTimer;
  _NumberStepperState({
    required this.curStep,
    required this.stepCompleteColor,
    required this.totalSteps,
    required this.inactiveColor,
    required this.currentStepColor,
    required this.lineHeight,
  });
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animationController
      ..duration = Duration(milliseconds: 1000)
      ..repeat(reverse: true);
    _animationController.addListener(() {
      setState(() {});
    });
    _startAnimation();
  }
  void _startAnimation() {
    _sizeAnimation = Tween<double>(begin: 28.0, end: 32.0).animate(_animationController);
    _colorAnimation = ColorTween(begin: Colors.grey, end: mainColor.shade400).animate(_animationController);
    _animationController.reset();
    _animationController.forward();
    _animationTimer = Timer(Duration(milliseconds: 1000), () {
      _changeAnimation();
    });
  }
  void _changeAnimation(){
    _sizeAnimation = Tween<double>(begin: 32.0, end: 28.0).animate(_animationController);
    _colorAnimation = ColorTween(begin: mainColor.shade400, end:Colors.grey ).animate(_animationController);
    _animationController.reset();
    _animationController.forward();
    _animationTimer = Timer(Duration(milliseconds: 1000), () {
      _startAnimation();
    });
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 10.0,
            left: 10.0,
            right: 24.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _steps(),
          ),
        ),
      ],
    );
  }
  List<Widget> _steps() {
    var list = <Widget>[];
    for (int i = 0; i < totalSteps; i++) {
      //colors according to state

      var circleColor = getCircleColor(i);
      var borderColor = getBorderColor(i);
      var lineColor = getLineColor(i);

      // step circles
      list.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width/4.5,
                  height: 6.0,
                  decoration: new BoxDecoration(
                    color: circleColor,
                    borderRadius: BorderRadius.circular(100),
                    border: new Border.all(
                      color: borderColor,
                      width: 1.0,
                    ),
                  ),
                ),
                  Padding(padding: EdgeInsets.all(10)),
              ],
            ),
          ],
        ),
      );
    }
    return list;
  }
  getCircleColor(i) {
    var color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep) {
      _animationController.forward();
      return _colorAnimation.value;
    } else {
      color = Colors.white;
    }
    return color;
  }

  getBorderColor(i) {
    var color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep) {
      return _colorAnimation.value;
    } else {
      color = inactiveColor;
    }
    return color;
  }

  Widget getInnerElementOfStepper(index) {
    if (index + 1 < curStep) {
      return Icon(
        Icons.check,
        color: Colors.white,
        size: 16.0,
      );
    } else if (index + 1 == curStep) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: _sizeAnimation.value,
        height: _sizeAnimation.value,
        child: Center(
          child: Text(
            '$curStep',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }}

  getLineColor(i) {
    var color =
    curStep > i + 1 ? mainColor.withOpacity(0.4) : Colors.grey[200];
    return color;
  }
}
Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}
Future<void> openWhatsAppChat(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'https',
    host: 'wa.me',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}
