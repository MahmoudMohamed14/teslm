import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:delivery/features/provider%20page/widget/check_list_widget.dart';
import 'package:flutter/material.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../common/colors/colors.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/constant/constant values.dart';
import '../widget/add_or_remove_in_provider.dart';

class ExtraItemsBottomSheet extends StatefulWidget {
  final String itemImage;
  final String name;
  final String id;
  final String categoryId;
  dynamic price;
  final String description;
  var extra;
  @override
  ExtraItemsBottomSheet({required this.extra,required this.itemImage,required this.name,required this.description,required this.price,required this.id,required this.categoryId});
  @override
  _ExtraItemsBottomSheetState createState() => _ExtraItemsBottomSheetState();
}

class _ExtraItemsBottomSheetState extends State<ExtraItemsBottomSheet> {
  Color containerColor = Colors.white;
  final ScrollController _bottomSheetController = ScrollController();
  late AnimationController controller;
  int itemsNumber = 1;
  int totalExtraPrice = 0;
  String extraName = '';
  late double imageBottomSheetHeight = MediaQuery
      .sizeOf(context)
      .height / 4;
  List<List<bool>> checklist = [];

  void changeChecklistValue(int checklistIndex, int itemIndex, bool value) {
    setState(() {
      checklist[checklistIndex][itemIndex] =
      !checklist[checklistIndex][itemIndex];
    });
  }

  int getTrueCountAtIndex(int index) {
    return checklist[index]
        .where((value) => value)
        .length;
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.extra.length; i++) {
      if (widget.extra[i].isMandatory ?? false) {
        addIdToSelectedOption(
            widget.extra[i].id, '${widget.extra[i].options[0].id}');
      }
    }
    _bottomSheetController.addListener(bottomSheetScroll);
    checklist = List.generate(
      widget.extra.length,
          (index) =>
          List.generate(
              widget.extra[index].options.length,
                  (optionIndex) =>
              widget.extra[index].isMandatory && optionIndex == 0
          ),);
  }

  void bottomSheetScroll() {
    setState(() {
      if (_bottomSheetController.offset > 20 &&
          _bottomSheetController.offset < 32) {
        imageBottomSheetHeight = MediaQuery
            .sizeOf(context)
            .height / 4 - _bottomSheetController.offset * 2.5;
      } else if (_bottomSheetController.offset <= 25) {
        imageBottomSheetHeight = MediaQuery
            .sizeOf(context)
            .height / 4;
      }
    });
  }

  @override
  void dispose() {
    _bottomSheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery
              .of(context)
              .size
              .height - 120,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              // Duration of the animation
              height: imageBottomSheetHeight,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  image: DecorationImage(
                      image: NetworkImage(widget.itemImage),
                      fit: BoxFit.cover
                  )),
              child: Container(
                padding: const EdgeInsets.only(top: 90, left: 20),
              ),),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                widget.name, maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Text(
                widget.description,
                style: TextStyle(
                    color: isDark ?? false ? floatActionColor : borderColor),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: ListView.builder(
                  controller: _bottomSheetController,
                  itemCount: widget.extra.length != 0 ? widget.extra.length : 0,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${getTrueCountAtIndex(index)}/${widget
                                  .extra[index].maxSelections}',
                                style:const TextStyle(fontSize: 17,
                                    fontWeight: FontWeight.bold,),),
                              Text(language == 'English Language' ? '${widget
                                  .extra[index].name.en}' : '${widget
                                  .extra[index].name.ar}', style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold, ),),
                            ],
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, otherIndex,) {
                            final bool isChecked = checklist[index][otherIndex];
                            return checkList(isChecked, () {
                              if (widget.extra[index].maxSelections == 1) {
                                if (widget.extra[index].isMandatory) {
                                  if (!isChecked) {
                                    for (int i = 0; i <
                                        widget.extra[index].options
                                            .length; i++) {
                                      if (i != otherIndex &&
                                          checklist[index][i]) {
                                        changeChecklistValue(index, i, false);
                                        totalExtraPrice -= (itemsNumber *
                                            widget.extra[index].options[i]
                                                .price).toInt();
                                        addExtra.removeWhere((item) =>
                                            item['selectedOption'].any((
                                                option) =>
                                            option['id'] ==
                                                widget.extra[index].options[i]
                                                    .id));
                                      } else if (i == otherIndex) {
                                        changeChecklistValue(
                                            index, otherIndex, isChecked);
                                        totalExtraPrice += (itemsNumber *
                                            widget.extra[index]
                                                .options[otherIndex].price)
                                            .toInt();
                                        addIdToSelectedOption(
                                            '${widget.extra[index].id}',
                                            '${widget.extra[index]
                                                .options[otherIndex].id}');
                                      }
                                    }
                                  }
                                }
                                else {
                                  for (int i = 0; i <
                                      checklist[index].length; i++) {
                                    if (i != otherIndex &&
                                        checklist[index][i]) {
                                      changeChecklistValue(index, i, isChecked);
                                      totalExtraPrice -= (itemsNumber *
                                          widget.extra[index].options[i].price)
                                          .toInt();
                                      extraName = extraName.replaceAll(
                                          language == 'English Language'
                                              ? '+${widget.extra[index]
                                              .options[i].name.en}'
                                              : '+${widget.extra[index]
                                              .options[i].name.ar}', '');
                                      addExtra.removeWhere((item) =>
                                          item['selectedOption'].any((option) =>
                                          option['id'] ==
                                              widget.extra[index].options[i]
                                                  .id));
                                    } else if (i == otherIndex) {
                                      changeChecklistValue(
                                          index, otherIndex, isChecked);
                                      if (!isChecked) {
                                        totalExtraPrice += (itemsNumber *
                                            widget.extra[index]
                                                .options[otherIndex].price)
                                            .toInt();
                                        if (!extraName.contains(
                                            language == 'English Language'
                                                ? widget.extra[index]
                                                .options[otherIndex].name.en
                                                : widget.extra[index]
                                                .options[otherIndex].name.ar)) {
                                          extraName +=
                                          language == 'English Language'
                                              ? '+${widget.extra[index]
                                              .options[otherIndex].name.en}'
                                              : '+${widget.extra[index]
                                              .options[otherIndex].name.ar}';
                                        }
                                        addIdToSelectedOption(
                                            widget.extra[index].id,
                                            '${widget.extra[index]
                                                .options[otherIndex].id}');
                                      } else {
                                        totalExtraPrice -= (itemsNumber *
                                            widget.extra[index].options[i]
                                                .price).toInt();
                                        extraName = extraName.replaceAll(
                                            language == 'English Language'
                                                ? '+${widget.extra[index]
                                                .options[i].name.en}'
                                                : '+${widget.extra[index]
                                                .options[i].name.ar}', '');
                                        addExtra.removeWhere((item) =>
                                            item['selectedOption'].any((
                                                option) =>
                                            option['id'] ==
                                                widget.extra[index].options[i]
                                                    .id));
                                      }
                                    }
                                  }
                                }
                              } else {
                                if (!isChecked && getTrueCountAtIndex(index) <
                                    widget.extra[index].maxSelections) {
                                  changeChecklistValue(
                                      index, otherIndex, isChecked);
                                  totalExtraPrice += (itemsNumber *
                                      widget.extra[index].options[otherIndex]
                                          .price).toInt();
                                  if (!extraName.contains(
                                      language == 'English Language' ? widget
                                          .extra[index].options[otherIndex].name
                                          .en : widget.extra[index]
                                          .options[otherIndex].name.ar)) {
                                    extraName +=
                                    language == 'English Language' ? '+${widget
                                        .extra[index].options[otherIndex].name
                                        .en}' : '+${widget.extra[index]
                                        .options[otherIndex].name.ar}';
                                  }
                                  addIdToSelectedOption(widget.extra[index].id,
                                      '${widget.extra[index].options[otherIndex]
                                          .id}');
                                } else if (isChecked) {
                                  changeChecklistValue(
                                      index, otherIndex, isChecked);
                                  totalExtraPrice -= (itemsNumber *
                                      widget.extra[index].options[otherIndex]
                                          .price).toInt();
                                  extraName = extraName.replaceAll(
                                      language == 'English Language'
                                          ? '+${widget.extra[index]
                                          .options[otherIndex].name.en}'
                                          : '+${widget.extra[index]
                                          .options[otherIndex].name.ar}', '');
                                  addExtra.removeWhere((item) =>
                                      item['selectedOption'].any((option) =>
                                      option['id'] == widget.extra[index]
                                          .options[otherIndex].id));
                                }
                              }
                            }, language == 'English Language'
                                ? '${widget.extra[index].options[otherIndex]
                                .name.en}'
                                : '${widget.extra[index].options[otherIndex]
                                .name.ar}',
                                '${widget.extra[index].options[otherIndex]
                                    .price}',
                                widget.extra[index].options[otherIndex].image,
                                context
                            );
                          }, itemCount: widget.extra[index].options.length,),
                      ],
                    );
                  }
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, bottom: 10),
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery
                      .sizeOf(context)
                      .width / 2,
                  height: 50,
                  decoration:const BoxDecoration(
                      color: ThemeModel.mainColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        DeliveryCubit.get(context).addValue(widget.name +
                            extraName, itemsNumber, widget.itemImage, DeliveryCubit.get(context).getPrice().toInt() +((widget.price as int)*itemsNumber) + (totalExtraPrice * itemsNumber ) , widget
                            .id,widget.description ,addExtra);
                        DeliveryCubit.get(context).submitValue(itemsNumber);
                        Navigator.pop(context);
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text(
                              Strings.sar.tr(context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: const TextStyle(fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              '${widget.price * itemsNumber +
                                  totalExtraPrice * itemsNumber}', maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: const TextStyle(fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              Strings.addCart.tr(context), maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: const TextStyle(fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                addOrRemoveOne(itemsNumber, context, () {
                  setState(() {
                    if (itemsNumber >= 30) {
                      itemsNumber = 30;
                    }
                    else {
                      itemsNumber += 1;
                    }
                  },);
                }, () {
                  setState(() {
                    if (itemsNumber <= 1) {
                      itemsNumber = 1;
                    }
                    else {
                      itemsNumber -= 1;
                    }
                  });
                }, true),
              ],)
          ],
        ),
      ),
    );
  }
}
List<Map<String, dynamic>>  addExtra=[];
void addIdToSelectedOption(optionGroupId,optionId) {
  bool valueExists = false;
  for (var group in addExtra) {
    if (group["id"] == "$optionGroupId") {
      valueExists=true;
      group["selectedOption"].add({
        "id": optionId
      });
      break;
    }
  }
  if(!valueExists){
    addExtra.add({
      "id": optionGroupId,
      "selectedOption": [
        {
          "id": optionId
        }
      ]
    });
  }
}
