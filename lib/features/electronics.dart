import 'package:delivery/common/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/colors/theme_model.dart';
import '../common/components.dart';

class Electronics extends StatelessWidget {
  const Electronics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [actionAppbar(context)]),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
        Container(
          height: double.infinity,
          width: MediaQuery.sizeOf(context).width/1.4,
          child: GridView.count(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            childAspectRatio: 1/1.3,
            crossAxisSpacing: 0.1,
            mainAxisSpacing: 0.2,
          crossAxisCount: 2,
          children: List.generate(40,
                (index)=> true? ElectronicCard():Skeleton(height: 300.0,width: double.infinity,),)),
        ),
        Container(
          width: MediaQuery.sizeOf(context).width/4,
          color: Colors.grey.shade800,
          child: ListView.builder(
              itemCount: 50,
              itemBuilder: (context,index)=>Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Container(
                  decoration: BoxDecoration(
                    color:index==0? ThemeModel.mainColor:borderColor.shade800,
                  ),
                    child: Center(child: Text('جولات',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,))),
              )),
        )
      ],),
    );
  }
}
Widget ElectronicCard() => SizedBox(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      image('https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-card-40-iphone15prohero-202309_FMT_WHH?wid=508&hei=472&fmt=p-jpg&qlt=95&.v=1693086369818', 135.0, 135.0, 5.0, BoxFit.fill),
      Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: SizedBox(
          width: 135,
          child: Text(
            'جوال iphone 15 pro max',
            style: TextStyle(fontSize: 10),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: SizedBox(
          width: 135,
          child: Text(
            '20 ريال',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200, color: ThemeModel.mainColor),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ],
  ),
);