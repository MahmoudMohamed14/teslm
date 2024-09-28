import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/common/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/colors/colors.dart';
import '../controller/provider_cubit.dart';
import '../controller/provider_state.dart';
import '../screen/Provider page.dart';


TextEditingController searchController = TextEditingController();
Widget searchProvider(context)=> Container(height: double.infinity,width: double.infinity,color: Colors.black54,child:
BlocConsumer<ProviderCubit, ProviderState>(
  listener: (context, state){},
 builder: (context, state) {
   return Padding(
     padding: EdgeInsets.all(16.0),
     child: Column(
       children: [
         Row(
           children: [
             IconButton(onPressed: (){
               // showSearchProvider=false;

               ProviderCubit.get(context).hideSearch();
               DeliveryCubit.get(context).increment();}, icon: Icon(Icons.arrow_back_outlined,color: floatActionColor,)),
             Container(
               width: MediaQuery.sizeOf(context).width/1.35,
               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFFF5F5F5),),
               child: TextField(
                 style: TextStyle(color: Colors.black87),
                 onChanged: (value){
                   ProviderCubit.get(context).searchProvider(value);
                 },
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
                       ProviderCubit.get(context).searchProvider('');
                       searchController.clear();
                     },
                   ),
                 ),
               ),
             ),
           ],
         ),
         ListView.separated(
             itemBuilder: (context, index) =>OtherWidget(item: ProviderCubit.get(context).searchedItems[index],controller: ProviderCubit.get(context).controller,),
             physics: const NeverScrollableScrollPhysics(),
             shrinkWrap: true,
             separatorBuilder: (context, index) => 10.h.heightBox,
             itemCount: ProviderCubit.get(context).searchedItems.length ).expand
       ],
     ),
   );
 }
),);
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
