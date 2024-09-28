import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:delivery/features/auth/screen/login.dart';
import 'package:delivery/features/provider%20page/controller/provider_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/images/images.dart';
import '../../payment page/screen/payment.dart';
import '../widgets/add_notes.dart';
import '../widgets/items_data.dart';
import '../widgets/unavailable_item.dart';
class Cart extends StatelessWidget{
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController noteTextController = TextEditingController();
    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(98.0),
        child: appBarWithIcons(Strings.cart.tr(context),ImagesApp.cartAppbar,true,context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children:[ Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Strings.myOrders.tr(context),style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w700,),),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: values.length,
                    itemBuilder: (context,index){
                      return itemsCart(index,context);}
                  ),
                  Text(Strings.orderNotes.tr(context),style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w700,),),
                  const SizedBox(height: 15,),
                  addNotes(noteTextController),
                  const SizedBox(height: 20,),
                  unavailableItem(context)
                ],
              ),
            ),
          ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0,top: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text('${Strings.totalOrder.tr(context)}: ',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,
                          style:const TextStyle(fontSize: 17,fontWeight: FontWeight.w400,),),
                      const SizedBox(width: 5,),
                      Text('${ProviderCubit.get(context).getPrice()}' ,maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,
                        style:const TextStyle(fontSize: 18,fontWeight: FontWeight.w900,),),
                        Text(Strings.sr.tr(context),style:const TextStyle(fontSize: 18,fontWeight: FontWeight.w900,),),
                      ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        bottom(Strings.addNew.tr(context), (){Navigator.pop(context);},radius: 20,color: ThemeModel.dark().myAccountBackgroundDarkColor,),
                        const SizedBox(height: 10,),
                        bottom(Strings.payNow.tr(context), (){navigate(context,(token!=''&&token!=null)? Payment(customerNotes: noteTextController.text,)
                            :const Login());if(token==''||token==null)loginFromCart=true;
                        totalPrice=ProviderCubit.get(context).getPrice().toInt()+shippingPrice;},radius: 20,),
                      ],
                    ),
                  ),
                ],
              )
            ),
          ]
        ),
      ),
    );
  },
);
  }
  int? getValueByName(String name) {
    for (var map in values) {
      if (map.containsKey(name)) {
        return map[name];
      }
    }
    return null; // Return null if the name is not found
  }

}

