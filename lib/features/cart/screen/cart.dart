import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/constant%20values.dart';
import 'package:delivery/common/translate/applocal.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:delivery/features/auth/screen/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../payment page/screen/payment.dart';
import '../widgets/add_notes.dart';
import '../widgets/cart_bottom.dart';
import '../widgets/items_data.dart';
import '../widgets/unavailable_item.dart';
class Cart extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    TextEditingController _noteTextController = TextEditingController();
    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text(Strings.cart.tr(context),style: TextStyle(fontFamily: 'fontTop',fontSize: 20,fontWeight: FontWeight.bold,),),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children:[ Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Strings.myOrders.tr(context),style: TextStyle(color:isDark??false ? floatActionColor: brownColor,fontFamily: 'fontTop',fontSize: 20,fontWeight: FontWeight.bold,),),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context,index)=>seperate(),
                    itemCount: values.length,
                    itemBuilder: (context,index){
                      return itemsCart(index,context);}
                  ),
                  seperate(),
                  Text(Strings.orderNotes.tr(context),style: TextStyle(color:isDark??false ? floatActionColor: brownColor,fontFamily: 'fontTop',fontSize: 23,fontWeight: FontWeight.bold,),),
                  const SizedBox(height: 15,),
                  addNotes(_noteTextController),
                  SizedBox(height: 20,),
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
                      mainAxisAlignment : MainAxisAlignment.spaceBetween,
                      children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(Strings.sr.tr(context)),
                          ),
                          SizedBox(width: 5,),
                          Text('$price' ,maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontFamily: 'fontTop',fontSize: 17,fontWeight: FontWeight.w400,),),
                        ],
                      ),
                      Text(Strings.totalOrder.tr(context),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontFamily: 'fontTop',fontSize: 17,fontWeight: FontWeight.w400,),),
                    ],),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      cartBottom(context,(){navigate(context,(token!=''&&token!=null)? Payment(customerNotes: _noteTextController.text,):Login());if(token==''||token==null)loginFromCart=true;print(values);totalPrice=price+shippingPrice;},cartBottomColor.shade600,Strings.payNow.tr(context)),
                      cartBottom(context,(){Navigator.pop(context);},mainColor.shade400,Strings.addNew.tr(context)),
                    ],
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

