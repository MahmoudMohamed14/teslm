import 'package:collection/collection.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:delivery/features/provider%20page/controller/provider_cubit.dart';
import 'package:delivery/features/provider%20page/widget/check_list_widget.dart';
import 'package:flutter/material.dart';

import '../../../common/colors/colors.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/constant/constant values.dart';
import '../../../models/provider_items_model.dart';
import '../widget/add_or_remove_in_provider.dart';

class ExtraItemsBottomSheet extends StatefulWidget {
  final String itemImage;
  final String name;
  final String id;
  final String categoryId;
  final double? price;
  final String description;
  final List<OptionGroups> extra;
  @override
  ExtraItemsBottomSheet(
      {super.key,
      required this.extra,
      required this.itemImage,
      required this.name,
      required this.description,
      required this.price,
      required this.id,
      required this.categoryId});
  @override
  _ExtraItemsBottomSheetState createState() => _ExtraItemsBottomSheetState();
}

class _ExtraItemsBottomSheetState extends State<ExtraItemsBottomSheet> {
  Color containerColor = Colors.white;
  final ScrollController _bottomSheetController = ScrollController();
  late AnimationController controller;

  int totalExtraPrice = 0;
  String extraName = '';
  late double imageBottomSheetHeight = MediaQuery.sizeOf(context).height / 4;
  List<List<bool>> checklist = [];

  void changeChecklistValue(int checklistIndex, int itemIndex, bool value) {
    setState(() {
      checklist[checklistIndex][itemIndex] =
          !checklist[checklistIndex][itemIndex];
    });
  }

  int getTrueCountAtIndex(int index) {
    return checklist[index].where((value) => value).length;
  }

  @override
  void initState() {
    super.initState();
    ProviderCubit.get(context).itemsNumber = 1;
    ProviderCubit.get(context).addExtra = [];
    for (int i = 0; i < widget.extra.length; i++) {
      if (widget.extra[i].isMandatory ?? false) {
        debugPrint("isisMandatory${widget.extra[i].isMandatory}");
      }
    }
    _bottomSheetController.addListener(bottomSheetScroll);
    checklist = List.generate(
      widget.extra.length ?? 0,
      (index) => List.generate(
          widget.extra[index].options?.length ?? 0,
          (optionIndex) =>
              (widget.extra[index].isMandatory ?? false) && optionIndex == 0),
    );
  }

  void bottomSheetScroll() {
    setState(() {
      if (_bottomSheetController.offset > 20 &&
          _bottomSheetController.offset < 32) {
        imageBottomSheetHeight = MediaQuery.sizeOf(context).height / 4 -
            _bottomSheetController.offset * 2.5;
      } else if (_bottomSheetController.offset <= 25) {
        imageBottomSheetHeight = MediaQuery.sizeOf(context).height / 4;
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
    var cubit = ProviderCubit.get(context);
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height - 120,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              // Duration of the animation
              height: imageBottomSheetHeight,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  image: DecorationImage(
                      image: NetworkImage(widget.itemImage),
                      fit: BoxFit.cover)),
              child: Container(
                padding: const EdgeInsets.only(top: 90, left: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                widget.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
              ///   -------    todo
              child: EnhancedOptionsWidget(
                extra: widget.extra,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, bottom: 10),
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.sizeOf(context).width / 2,
                  height: 50,
                  decoration: const BoxDecoration(
                      color: ThemeModel.mainColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        ProviderCubit.get(context)
                            .addIdToSelectedOption(widget.extra, checklist);
                        ProviderCubit.get(context).addValue(
                            widget.name + extraName,
                            ProviderCubit.get(context).itemsNumber,
                            widget.itemImage,
                            (widget.price as double),
                            widget.id,
                            widget.description,
                            cubit.addExtra,
                            widget.categoryId);
                        ProviderCubit.get(context).submitValue(
                            ProviderCubit.get(context).itemsNumber);
                        Navigator.pop(context);
                      });

                      print("${cubit.addExtra} add extra");
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
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              '${widget.price ?? 0 * ProviderCubit.get(context).itemsNumber + totalExtraPrice * ProviderCubit.get(context).itemsNumber}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              Strings.addCart.tr(context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                addOrRemoveOne(ProviderCubit.get(context).itemsNumber, context,
                    () {
                  setState(
                    () {
                      if (ProviderCubit.get(context).itemsNumber >= 30) {
                        ProviderCubit.get(context).itemsNumber = 30;
                      } else {
                        ProviderCubit.get(context).itemsNumber += 1;
                      }
                    },
                  );
                }, () {
                  setState(() {
                    if (ProviderCubit.get(context).itemsNumber <= 1) {
                      ProviderCubit.get(context).itemsNumber = 1;
                    } else {
                      ProviderCubit.get(context).itemsNumber -= 1;
                    }
                  });
                }, true),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class OptionsWidget extends StatefulWidget {
  final List<OptionGroups> extra;
  const OptionsWidget({super.key, this.extra = const []});

  @override
  State<OptionsWidget> createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<OptionsWidget> {
  final ScrollController _bottomSheetController = ScrollController();
  late AnimationController controller;

  int totalExtraPrice = 0;
  String extraName = '';
  late double imageBottomSheetHeight = MediaQuery.sizeOf(context).height / 4;
  List<OptionGroups> selectedOptions = [];
  List<List<bool>> checklist = [];

  void changeChecklistValue(int checklistIndex, int itemIndex, bool value) {
    setState(() {
      checklist[checklistIndex][itemIndex] =
          !checklist[checklistIndex][itemIndex];
    });
  }

  int getTrueCountAtIndex(int index) {
    return checklist[index].where((value) => value).length;
  }

  ///   ----------   Init state
  @override
  void initState() {
    super.initState();
    ProviderCubit.get(context).itemsNumber = 1;
    ProviderCubit.get(context).addExtra = [];
    for (int i = 0; i < widget.extra.length; i++) {
      if (widget.extra[i].isMandatory ?? false) {
        debugPrint("isisMandatory${widget.extra[i].isMandatory}");
      }
    }
    _bottomSheetController.addListener(bottomSheetScroll);
    checklist = List.generate(
      widget.extra.length,
      (index) => List.generate(
          widget.extra[index].options?.length ?? 0,
          (optionIndex) =>
              (widget.extra[index].isMandatory ?? false) && optionIndex == 0),
    );
  }

  void bottomSheetScroll() {
    setState(() {
      if (_bottomSheetController.offset > 20 &&
          _bottomSheetController.offset < 32) {
        imageBottomSheetHeight = MediaQuery.sizeOf(context).height / 4 -
            _bottomSheetController.offset * 2.5;
      } else if (_bottomSheetController.offset <= 25) {
        imageBottomSheetHeight = MediaQuery.sizeOf(context).height / 4;
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
    var cubit = ProviderCubit.get(context);
    return ListView.builder(
        controller: _bottomSheetController,
        itemCount: widget.extra.length,
        itemBuilder: (context, upperIndex) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      language == 'en'
                          ? '${widget.extra[upperIndex].name?.en}'
                          : '${widget.extra[upperIndex].name?.ar}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${getTrueCountAtIndex(upperIndex)}/${widget.extra[upperIndex].maxSelections}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (
                  context,
                  innerIndex,
                ) {
                  final bool isChecked = checklist[upperIndex][innerIndex];
                  return checkList(
                    isChecked,
                    isMandatory: widget.extra[upperIndex].isMandatory,
                    (optionID) {
                      if (widget.extra[upperIndex].maxSelections == 1) {
                        if (widget.extra[upperIndex].isMandatory ?? false) {
                          if (!isChecked) {
                            for (int i = 0;
                                i <
                                    (widget.extra[upperIndex].options?.length ??
                                        0);
                                i++) {
                              if (i != innerIndex && checklist[upperIndex][i]) {
                                changeChecklistValue(upperIndex, i, false);

                                totalExtraPrice -=
                                    (ProviderCubit.get(context).itemsNumber *
                                            (widget.extra[upperIndex]
                                                    .options![i].price ??
                                                0))
                                        .toInt();
                              } else if (i == innerIndex) {
                                changeChecklistValue(
                                    upperIndex, innerIndex, isChecked);
                                totalExtraPrice +=
                                    (ProviderCubit.get(context).itemsNumber *
                                            (widget
                                                    .extra[upperIndex]
                                                    .options?[innerIndex]
                                                    .price ??
                                                0))
                                        .toInt();
                              }
                            }
                          }
                        } else {
                          for (int i = 0;
                              i < checklist[upperIndex].length;
                              i++) {
                            if (i != innerIndex && checklist[upperIndex][i]) {
                              changeChecklistValue(upperIndex, i, isChecked);
                              totalExtraPrice -=
                                  (ProviderCubit.get(context).itemsNumber *
                                          (widget.extra[upperIndex].options?[i]
                                                  .price ??
                                              0))
                                      .toInt();
                              extraName = extraName.replaceAll(
                                  language == 'en'
                                      ? '+${widget.extra[upperIndex].options?[i].name?.en}'
                                      : '+${widget.extra[upperIndex].options?[i].name?.ar}',
                                  '');
                              /* cubit.addExtra.removeWhere((item) =>
                                          item['selectedOption'].any((option) =>
                                          option['id'] ==
                                              widget.extra[index].options[i]
                                                  .id));*/
                            } else if (i == innerIndex) {
                              changeChecklistValue(
                                  upperIndex, innerIndex, isChecked);
                              if (!isChecked) {
                                totalExtraPrice +=
                                    (ProviderCubit.get(context).itemsNumber *
                                            (widget
                                                    .extra[upperIndex]
                                                    .options?[innerIndex]
                                                    .price ??
                                                0))
                                        .toInt();
                                if (!extraName.contains(language == 'en'
                                    ? (widget.extra[upperIndex]
                                            .options![innerIndex].name?.en ??
                                        '')
                                    : (widget.extra[upperIndex]
                                            .options![innerIndex].name?.ar ??
                                        ''))) {
                                  extraName += language == 'en'
                                      ? '+${widget.extra[upperIndex].options![innerIndex].name!.en}'
                                      : '+${widget.extra[upperIndex].options![innerIndex].name!.ar}';
                                }
                              } else {
                                totalExtraPrice -=
                                    (ProviderCubit.get(context).itemsNumber *
                                            (widget.extra[upperIndex]
                                                    .options?[i].price ??
                                                0))
                                        .toInt();
                                extraName = extraName.replaceAll(
                                    language == 'en'
                                        ? '+${widget.extra[upperIndex].options?[i].name?.en}'
                                        : '+${widget.extra[upperIndex].options?[i].name?.ar}',
                                    '');
                              }
                            }
                          }
                        }
                      } else {
                        if (!isChecked &&
                            getTrueCountAtIndex(upperIndex) <
                                (widget.extra[upperIndex].maxSelections ?? 0)) {
                          changeChecklistValue(
                              upperIndex, innerIndex, isChecked);
                          totalExtraPrice +=
                              (ProviderCubit.get(context).itemsNumber *
                                      (widget.extra[upperIndex]
                                              .options?[innerIndex].price ??
                                          0))
                                  .toInt();
                          if (!extraName.contains(language == 'en'
                              ? (widget.extra[upperIndex].options?[innerIndex]
                                      .name?.en ??
                                  '')
                              : (widget.extra[upperIndex].options?[innerIndex]
                                      .name?.ar ??
                                  ''))) {
                            extraName += language == 'en'
                                ? '+${widget.extra[upperIndex].options?[innerIndex].name?.en}'
                                : '+${widget.extra[upperIndex].options?[innerIndex].name?.ar}';
                          }
                        } else if (isChecked) {
                          changeChecklistValue(
                              upperIndex, innerIndex, isChecked);
                          totalExtraPrice -=
                              (ProviderCubit.get(context).itemsNumber *
                                      (widget.extra[upperIndex]
                                              .options?[innerIndex].price ??
                                          0))
                                  .toInt();
                          extraName = extraName.replaceAll(
                              language == 'en'
                                  ? '+${widget.extra[upperIndex].options?[innerIndex].name?.en}'
                                  : '+${widget.extra[upperIndex].options?[innerIndex].name?.ar}',
                              '');
                        }
                      }
                      print("${cubit.addExtra} here extra");
                    },
                    context,
                    optionModel: widget.extra[upperIndex].options?[innerIndex],
                  );
                },
                itemCount: widget.extra[upperIndex].options?.length ?? 0,
              ),
            ],
          );
        });
  }
}

///   ------------  Enhanced OptionsList  ---------------
class EnhancedOptionsWidget extends StatefulWidget {
  final List<OptionGroups> extra;
  const EnhancedOptionsWidget({super.key, this.extra = const []});

  @override
  State<EnhancedOptionsWidget> createState() => _EnhancedOptionsWidgetState();
}

class _EnhancedOptionsWidgetState extends State<EnhancedOptionsWidget> {
  final ScrollController _bottomSheetController = ScrollController();
  late AnimationController controller;

  int totalExtraPrice = 0;
  String extraName = '';
  late double imageBottomSheetHeight = MediaQuery.sizeOf(context).height / 4;
  List<OptionGroups> selectedOptions = [];

  void changeChecklistValue(int checklistIndex, String optionID) {
    setState(() {
      Options? currentOption = selectedOptions[checklistIndex]
          .options
          ?.firstWhereOrNull((element) => element.id == optionID);
      currentOption?.isSelected = !(currentOption.isSelected ?? true);
    });
  }

  int getTrueCountAtIndex(int index) {
    return selectedOptions[index]
            .options
            ?.where((value) => value.isSelected)
            .length ??
        0;
  }

  ///   ----------   Init state
  @override
  void initState() {
    super.initState();
    ProviderCubit.get(context).itemsNumber = 1;
    ProviderCubit.get(context).addExtra = [];
    for (int i = 0; i < widget.extra.length; i++) {
      if (widget.extra[i].isMandatory ?? false) {
        debugPrint("isisMandatory${widget.extra[i].isMandatory}");
      }
    }
    selectedOptions = widget.extra;
    _bottomSheetController.addListener(bottomSheetScroll);
    selectedOptions = selectedOptions.map((e) {
      print("Is Required >>>>>>>  ${e.isMandatory}");
      print(
          "Is Required >>>>>>>  ${e.maxSelections} ---- ${(e.maxSelections ?? 0) <= (e.options?.length ?? 0) ? (e.maxSelections ?? 0) : (e.options?.length ?? 0)}");
      List<Options> options = e.options ?? [];
      if (e.isMandatory ?? false) {
        for (int i = 0;
            i <
                ((e.maxSelections ?? 0) <= (e.options?.length ?? 0)
                    ? (e.maxSelections ?? 0)
                    : (e.options?.length ?? 0));
            i++) {
          print("::::::::::::::::Index >> $i");
          options[i].isSelected = true;
        }
      } else {
        for (int i = 0; i < (e.options?.length ?? 0); i++) {
          options[i].isSelected = false;
        }
      }
      return e.copyWith(
        options: options,
      );
    }).toList();
    // List.generate(
    //   widget.extra.length,
    //   (index) {
    //     return OptionGroups(
    //       id: widget.extra[index].id,
    //       name: widget.extra[index].name,
    //       isMandatory: widget.extra[index].isMandatory,
    //       maxSelections: widget.extra[index].maxSelections,
    //       options: (widget.extra[index].isMandatory ?? false)
    //           ? widget.extra[index].options
    //                   ?.sublist(
    //                       0,
    //                       (widget.extra[index].options?.length ?? 0) >=
    //                               (widget.extra[index].maxSelections ?? 0)
    //                           ? (widget.extra[index].maxSelections ?? 0)
    //                           : (widget.extra[index].options?.length ?? 0))
    //                   .toList() ??
    //               []
    //           : [],
    //     );
    //   },
    // );
    // print("selectedOptions: $selectedOptions");
  }

  void bottomSheetScroll() {
    setState(() {
      if (_bottomSheetController.offset > 20 &&
          _bottomSheetController.offset < 32) {
        imageBottomSheetHeight = MediaQuery.sizeOf(context).height / 4 -
            _bottomSheetController.offset * 2.5;
      } else if (_bottomSheetController.offset <= 25) {
        imageBottomSheetHeight = MediaQuery.sizeOf(context).height / 4;
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
    var cubit = ProviderCubit.get(context);
    return ListView.builder(
        controller: _bottomSheetController,
        itemCount: widget.extra.length,
        itemBuilder: (context, upperIndex) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      language == 'en'
                          ? '${widget.extra[upperIndex].name?.en}'
                          : '${widget.extra[upperIndex].name?.ar}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${getTrueCountAtIndex(upperIndex)}/${widget.extra[upperIndex].maxSelections}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (
                  context,
                  innerIndex,
                ) {
                  final bool isChecked = selectedOptions[upperIndex]
                          .options?[innerIndex]
                          .isSelected ??
                      false;
                  print("isChecked:....... $isChecked");
                  return checkList(
                    isChecked,
                    isMandatory: widget.extra[upperIndex].isMandatory,
                    (item) {
                      if (isChecked) {
                        if ((widget.extra[upperIndex].isMandatory ?? false) &&
                            ((selectedOptions[upperIndex]
                                        .options
                                        ?.where((e) => e.isSelected)
                                        .length ??
                                    0) ==
                                (widget.extra[upperIndex].maxSelections ??
                                    0))) {
                          return;
                        } else if ((widget.extra[upperIndex].isMandatory ??
                                false) &&
                            ((selectedOptions[upperIndex]
                                        .options
                                        ?.where((e) => e.isSelected)
                                        .length ??
                                    0) >
                                (widget.extra[upperIndex].maxSelections ??
                                    0))) {
                          changeChecklistValue(upperIndex, item.id!);
                        } else if (!(widget.extra[upperIndex].isMandatory ??
                                false) &&
                            ((selectedOptions[upperIndex]
                                        .options
                                        ?.where((e) => e.isSelected)
                                        .length ??
                                    0) <=
                                (widget.extra[upperIndex].maxSelections ??
                                    0))) {
                          changeChecklistValue(upperIndex, item.id!);
                          totalExtraPrice -= (item.price ?? 0).toInt();
                        }
                      } else {
                        if ((widget.extra[upperIndex].isMandatory ?? false) &&
                            ((selectedOptions[upperIndex]
                                        .options
                                        ?.where((e) => e.isSelected)
                                        .length ??
                                    0) ==
                                (widget.extra[upperIndex].maxSelections ??
                                    0))) {
                          selectedOptions[upperIndex] =
                              selectedOptions[upperIndex].copyWith(
                            options: selectedOptions[upperIndex]
                                .options
                                ?.map((e) => e.copyWith(isSelected: false))
                                .toList(),
                          );
                          changeChecklistValue(upperIndex, item.id!);
                        } else if (!(widget.extra[upperIndex].isMandatory ??
                                false) &&
                            ((selectedOptions[upperIndex]
                                        .options
                                        ?.where((e) => e.isSelected)
                                        .length ??
                                    0) <
                                (widget.extra[upperIndex].maxSelections ??
                                    0))) {
                          changeChecklistValue(upperIndex, item.id!);
                          totalExtraPrice += (item.price ?? 0).toInt();
                        }
                      }
                    },
                    context,
                    optionModel:
                        selectedOptions[upperIndex].options?[innerIndex],
                  );
                },
                itemCount: widget.extra[upperIndex].options?.length ?? 0,
              ),
            ],
          );
        });
  }
}
