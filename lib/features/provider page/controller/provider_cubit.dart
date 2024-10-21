
import 'dart:async';
import 'dart:convert';

import 'package:delivery/features/provider%20page/controller/provider_data_handler.dart';
import 'package:delivery/features/provider%20page/controller/provider_state.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';
import '../../../models/provider_items_model.dart';
import '../../../shared_preference/shared preference.dart';
import 'package:collection/collection.dart';


class ProviderCubit extends Cubit<ProviderState> {
  ProviderCubit() : super(ProviderInitial()){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollControllerColumn.addListener(onScroll);  // Call onScroll after the widget is ready
      scrollControllerColumn.addListener(_scrollAnimation);
      if(providerFoodData!=null)
        _calculateListOffsets();
    });
  }

  static ProviderCubit get(context) => BlocProvider.of(context);
  void addValue(String name, int value,image,double foodPrice,id,description,extraId,providerId) {
    bool valueExists = false;
    int totalItems = 0;
    for (var map in values) {
      if (map['itemId'] == id) {

        map['quantity'] = (map['quantity']! + 1);
        totalItems = map['quantity']!;

        valueExists = true;
        break;
      }
    }


    cardList.forEach((action){
      if (action['itemId'] == id) {
        action['quantity'] = totalItems;
        //print(" after cardList${action!['quantity']}  $values;");


      }

    });


    if (!valueExists) {
      values.add({
        'name': name,
        'quantity': value,
        'image': image,
        "ProviderId":providerId,
        "isRestaurant":isRestaurant,
        'price': foodPrice,
        'itemId': id,
       'description':description,
        'selectedOptionGroups': extraId??[]
      });
      cardList.add({
        'name': name,
        'quantity': value,
       'image': image,
        "ProviderId":providerId,
        "isRestaurant":isRestaurant,
        'price': foodPrice,
        'itemId': id,
       'description':description,
        'selectedOptionGroups': extraId??[]
      });
      if (kDebugMode) {
        print(" inside add $values");
      }


    }


   // price+=foodPrice;
    emit(Reload());
    //print(values);
    saveCardList();
  }

  void increment(){
    emit(Reload());
  }

  ProviderItemsMenu? providerFoodData;
  late AnimationController controller;
  Future<void> getProviderData(id) async {
    emit(GetProviderFoodLoading());
    final result = await ProviderDataHandler.getProviderData(id: id.toString());
    result.fold((l) {
      if (kDebugMode) {
        print("error is ${l.errorModel.statusMessage}");
      }

      emit(GetProviderFoodError());
    }, (r) {
      providerFoodData=ProviderItemsMenu.fromJson(r);
      if (kDebugMode) {
        print(r);
      }
      _calculateListOffsets();
      emit(GetProviderFoodSuccess());
    });
   /* DioHelper.getData(url: '${ApiEndPoint.providers}/$id',)
        .then((value) {
      providerFoodData=ProviderItemsMenu.fromJson(value.data);
      print(value.data);
      emit(GetProviderFoodSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetProviderFoodError());
    });*/
  }
  int itemsNumber = 1;
  bool isRestaurant=false;
  String ?categoryId;
  List<Map<String, dynamic>> cardList = [];
  double getPrice(){

    double total = 0.0;
    values.forEach((item){
      if(item['selectedOptionGroups']?.isNotEmpty??false){
        print('here');
        total+= item['price']! * item['quantity']!;
        item['selectedOptionGroups'][0]['selectedOption']?.forEach((value){
          total+= value['price']! * item['quantity']!;
        });
      }else{
        total+= item['price']! * item['quantity']!;
      }
    });

    return total;

  }
  void saveCardList() {


    Save.savedata(key: 'myCart', value: jsonEncode(cardList)).then((onValue){
      if(onValue){
        getCartList();

      }
    });
  }
  void getCartList(){
    cardList=[];
    String? json = Save.getdata(key: 'myCart');
    if(json!=null){
      cardList =  (jsonDecode(json) as List<dynamic>)
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
      if (kDebugMode) {
        print(" myCart=$cardList");
      }
    }
  }
  void minusValue(String name, int value, image, double foodPrice, id) {

    bool valueExists = false;
   // List<Map<String, dynamic>> valuesCopy = List.from(values.reversed);
    int totalItems = 0;
    for (var map in values) {

      if (map['itemId'] == id) {

        map['quantity'] = (map['quantity']! - 1);
        totalItems= map['quantity'];
        if (map['quantity'] == 0) {
          values.remove(map);
        }
        valueExists = true;
        break;
      }
    }

      for (var map in cardList) {
        if (map['itemId'] == id) {

          map['quantity'] =totalItems;
          if (map['quantity'] == 0) {
            cardList.remove(map);
          }
          valueExists = true;
          break;
        }

    }

    if (valueExists) {
     // values = List.from(valuesCopy.reversed);
     // price -= foodPrice;
      emit(Reload());
    }
    saveCardList();
    emit(Reload());

  }
  void RemoveValue(index) {
    if (index >= 0 && index < values.length) {
      int productPrice = values[index]['price'].toInt();
      price -= productPrice;
       cardList.remove(values[index]);
      values.removeAt(index);

      emit(Reload());
    }
    saveCardList();
  }
  bool isNameInList(String name) {
    for (var map in values) {
      if (map['name'] == name) {
        return true;
      }
    }
    return false;
  }
  int getValueById(String itemId) {
   // /* return values.fold(0, (int total, Map<String, dynamic> item) {
   //    if (item['itemId'] == itemId) {
   //      return total + item['quantity'] as int;
   //    }
   //    return total;
   //  });*/
    return values.firstWhereOrNull((item) => item['itemId'].toString() == itemId)?['quantity']??0;
  }
  int calculateItemsBeforeIndex(int foodIndex) {
    int totalItems = 0;
    if (providerFoodData!.categoriesItemsData!.isNotEmpty && foodIndex >= 0 && foodIndex < providerFoodData!.categoriesItemsData!.length) {
      for (int i = 0; i < foodIndex; i++) {
        totalItems += providerFoodData!.categoriesItemsData![i].items!.length;
      }
    }
    return totalItems;
  }
  void submitValue(value) {
    emit(SubmitValueEvent(value));
  }
  List<Map<String, dynamic>>  addExtra=[];
  void addIdToSelectedOption(List optionsGroups,List<List<bool>> checklist) {
    bool valueExists = false;
    for(int i=0;i<optionsGroups.length;i++){
      for(int j=0;j<(optionsGroups[i].options?.length??0);j++){
       if(checklist[i][j]==true){
         for (var group in addExtra) {
           if (group["id"] == "${optionsGroups[i].id}") {
             valueExists=true;
             group["selectedOption"].add({
               "id": optionsGroups[i].options?[j].id,
               "price": optionsGroups[i].options?[j].price
             });
             break;
           }
         }
         if(!valueExists){
           addExtra.add({
             "id":optionsGroups[i].id,
             "selectedOption": [
               {
                 "id": optionsGroups[i].options?[j].id,
                 "price": optionsGroups[i].options?[j].price
               }
             ]
           });
         }
       }



      }

    }




  }
  bool showSearchProvider=false;
  void showSearch(){
    showSearchProvider= true;
    print(showSearchProvider);
    emit(Reload());

  }
  void hideSearch(){
    showSearchProvider= false;
    print(showSearchProvider);
    emit(Reload());
  }
  List<Items>allItems=[];
  List<Items>searchedItems=[];
  final RegExp english = RegExp(r'^[a-zA-Z]+');
  bool langEn=true;
  void changeLang(String text){
    if (english.hasMatch(text)) {
      langEn = true;
    } else {
      langEn = false;
    }
  }
  void searchProvider(String name){

    changeLang(name);
   allItems=[];
   searchedItems=[];
   if(name.isNotEmpty) {
     providerFoodData?.categoriesItemsData?.forEach((element) {
       element.items?.forEach((element1) {
         allItems.add(element1);
       });
     });
     searchedItems = allItems.where((element) =>
     (langEn ? element.name?.en?.toLowerCase().contains(name.toLowerCase()) ??
         false : element.name?.ar?.toLowerCase().contains(name.toLowerCase()) ??
         false) ||
         (langEn ? element.description?.en?.toLowerCase().contains(
             name.toLowerCase()) ?? false : element.description?.ar
             ?.toLowerCase().contains(name.toLowerCase()) ?? false) ||
         (element.price.toString().contains(name))||((element.calories?.toString().contains(name))??false)
     ).toList();
     print('Search: $searchedItems');
     print(searchedItems.lastOrNull?.name?.en??''+"SEARCH HERE"+"${searchedItems.firstOrNull?.price}");
   }

    emit(Reload());
  }
  double opecity=1;
  final ItemScrollController itemScrollController = ItemScrollController();
  double expandedHeight = 80.0;
   ScrollController scrollControllerColumn = ScrollController();
  ScrollController get scrollController => scrollControllerColumn;
  _scrollAnimation(){
    final double offset = scrollControllerColumn.offset;
    if (offset > 20 && offset < 50) {
      if (expandedHeight > 30) {
        expandedHeight -= offset * 0.1;
      }
      if (opecity > 0.2) {
        opecity -= 0.2;
      } else {
        opecity = 0;
      }
    }
    else if (offset <= 20) {
      opecity = 1.0;
      expandedHeight = 80.0;
    } else {
      opecity = 0;
      expandedHeight = 30;
    }
    emit(Reload());
  }

  List<int> listOffsets = [];

  void _calculateListOffsets() {
    listOffsets.clear();  // Clear any previous offsets before recalculating
    int offset = 0;

    if (providerFoodData?.categoriesItemsData != null) {
      for (int i = 0; i < providerFoodData!.categoriesItemsData!.length; i++) {
        listOffsets.add(offset);
        offset += (providerFoodData!.categoriesItemsData![i].items!.length * 170); // Calculate total height for each category
      }
    }
  }

  int currentIndex = 0;

  void onScroll() {
    final itemHeight = 170; // Replace with the actual height of each item
    final offset = scrollControllerColumn.offset;
    int? currentIndexNew;

    print('Scroll offset: $offset'); // To see current scroll position

    // Ensure that listOffsets are calculated once and providerFoodData is valid
    if (listOffsets.isEmpty || providerFoodData == null || providerFoodData!.categoriesItemsData == null) {
      print('Exiting onScroll: listOffsets or providerFoodData is not ready');
      return;  // Exit if there's no valid data
    }

    for (int i = 0; i < listOffsets.length; i++) {
      final startOffset = listOffsets[i];
      final endOffset = startOffset + providerFoodData!.categoriesItemsData![i].items!.length * itemHeight;

      if (offset >= startOffset && offset < endOffset) {
        currentIndexNew = i;
        break;
      }
    }

    // Check if the scrollControllerColumn is at the last page
    final totalHeight = listOffsets.last + providerFoodData!.categoriesItemsData![listOffsets.length - 1].items!.length * itemHeight;
    if (scrollControllerColumn.position.pixels >= totalHeight - scrollControllerColumn.position.viewportDimension) {
      currentIndexNew = providerFoodData!.categoriesItemsData!.length - 1;  // Set to last index
    }

    // Ensure currentIndexNew is within bounds
    if (currentIndexNew != null && currentIndexNew >= 0 && currentIndexNew < providerFoodData!.categoriesItemsData!.length) {
      if (currentIndexNew != currentIndex) {
        print('Updating currentIndex from $currentIndex to $currentIndexNew');
        currentIndex = currentIndexNew;
        Timer(Duration(milliseconds: 200), () {
          itemScrollController.jumpTo(
            index: currentIndex,
            alignment: currentIndex == 0 || currentIndex == 1 ? 0.0 : 0.3,
          );
        });
      } else {
        print('currentIndex remains unchanged: $currentIndex');
      }
    } else {
      print('currentIndexNew is null or out of bounds');
    }

    print('Final currentIndex: $currentIndex'); // This should always print before the state reload
    emit(Reload());
  }


  void scrollToIndex(int index) {
    int items = calculateItemsBeforeIndex(index);
    scrollController.animateTo(


      items * 170,
      // Replace ITEM_HEIGHT with the height of each item in your list
      duration: Duration(milliseconds: 500), // Adjust the duration as per your preference
      curve: Curves.easeOut, // Adjust the curve as per your preference
    );

    emit(Reload());
  }

}
