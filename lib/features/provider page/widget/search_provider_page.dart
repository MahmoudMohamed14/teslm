import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../common/colors/colors.dart';

bool showSearchProvider=false;
TextEditingController searchController = TextEditingController();
Widget searchProvider(context)=> Container(height: double.infinity,width: double.infinity,color: Colors.black54,child: Column(children: [
    Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(onPressed: (){
            showSearchProvider=false;
            DeliveryCubit.get(context).increment();}, icon: Icon(Icons.arrow_back_outlined,color: floatActionColor,)),
          Container(
            width: MediaQuery.sizeOf(context).width/1.35,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFFF5F5F5),),
            child: TextField(
              style: TextStyle(color: Colors.black87),
              autofocus: true,
              controller: searchController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter amount to stake',
                hintStyle: TextStyle(color: Colors.grey), // Change the hint text color
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.close,color: Colors.grey),
                  onPressed: () {
                    searchController.clear();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ],),);