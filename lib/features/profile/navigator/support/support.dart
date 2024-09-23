import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/components.dart';
import '../../../../common/images/images.dart';
import '../../../../common/translate/strings.dart';

class Support extends StatelessWidget {
  const Support({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: appBarWithIcons(Strings.helpSupport.tr(context),ImagesApp.supportImage,true,context)),
        body: SingleChildScrollView(
        child: Container(
          child: _buildPanel(language=='en'? itemsEn:itemsAr),
        ),
              ),
    );
  }

  Widget _buildPanel(items) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
            items[index].isExpanded = isExpanded;
            DeliveryCubit.get(context).increment();
        },
        expandIconColor:Colors.orange,
        children: items.map<ExpansionPanel>((Item item) {
          return ExpansionPanel(
              canTapOnHeader:true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(item.headerValue,style:const TextStyle(fontWeight: FontWeight.w700,fontSize: 18,),),
              );
            },
            body: Visibility(
              visible: item.isExpanded,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: AnimatedOpacity(
                opacity: item.isExpanded ? 1.0 : 0.0,
                duration:const Duration(milliseconds: 600),
                child:Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(item.expandedValue,style:const TextStyle(fontSize:18,fontWeight: FontWeight.w300,),),
                  ),
                ),
              ),
            ),
            isExpanded: item.isExpanded,
          );
        }).toList(),
    );
  },
);
  }
}
