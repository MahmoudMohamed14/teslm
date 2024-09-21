import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/constant%20values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Support extends StatelessWidget {
  const Support({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('الدعم والمساعدة'),),
        body: Directionality(
          textDirection: language=='English Language'?TextDirection.ltr:TextDirection.rtl,
          child: SingleChildScrollView(
          child: Container(
            child: _buildPanel(language=='English Language'? itemsEn:itemsAr),
          ),
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
        children: items.map<ExpansionPanel>((Item item) {
          return ExpansionPanel(
              canTapOnHeader:true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(item.headerValue,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,),),
              );
            },
            body: Container(
              child: Visibility(
                visible: item.isExpanded,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: AnimatedOpacity(
                  opacity: item.isExpanded ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 600),
                  child:Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(item.expandedValue,style: TextStyle(fontSize:18,fontWeight: FontWeight.w700,color: isDark??false ?borderColor.shade300:borderColor.shade600),),
                    ),
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
