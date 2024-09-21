import 'package:flutter/cupertino.dart';

import '../../../Cubite/delivery_cubit.dart';
import '../../../common/components.dart';
import 'add_or_remove.dart';

Widget itemsCart(index,context)=>Dismissible(
  key: ValueKey(values[index]),
  onDismissed: (DismissDirection direction) {
    DeliveryCubit.get(context).RemoveValue(index);
    if(values.isEmpty){Navigator.pop(context);}
  },
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: image('${values[index]['image']}', 70.0, 60.0, 40.0,BoxFit.fill),
      ),
      Expanded(child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('${values[index]['name']}',maxLines: 2, overflow: TextOverflow.ellipsis,style:const TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),),
            const SizedBox(height: 5,),
            Text('${values[index]['price']} SR',maxLines: 1, overflow: TextOverflow.ellipsis,style:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
          ],
        ),
      )),
      Flexible(
        child: addOrRemoveOne(
            values[index]['quantity'],
            context,
                (){ DeliveryCubit.get(context).addValue(values[index]['name'],1,values[index]['image'],values[index]['price'],values[index]['id'],values[index]['extraId']);},
                (){ DeliveryCubit.get(context).minusValue(values[index]['name'],1,values[index]['image'],values[index]['price'],values[index]['id']);
            if(values.isEmpty){Navigator.pop(context);}
            },
            false
        ),
      ),
    ],),
);