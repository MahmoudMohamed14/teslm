import 'package:delivery/features/order%20details/widgets/steper_design.dart';
import 'package:flutter/material.dart';
import '../../../common/colors/colors.dart';
import '../../../common/constant/constant values.dart';
import '../screen/orderDetails.dart';

Widget orderStatus(index)=>SliverToBoxAdapter(
  child: Padding(
    padding: const EdgeInsets.only(left: 10.0, right: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          language == 'English Language'
              ? 'Estimated Arrival Time'
              : 'وقت الوصول المقدر',
          textDirection: language == 'English Language'
              ? TextDirection.ltr
              : TextDirection.rtl,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: isDark ?? false ? Colors.white : borderColor.shade700,
          ),
        ),
        Row(
          children: [
            const Text(
              '6 ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Text(
              language == 'English Language' ? 'minutes' : 'دقيقة',
              style:const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        NumberStepper(
          totalSteps: 3,
          curStep: index,
          stepCompleteColor: mainColor.shade400,
          currentStepColor: mainColor.shade100,
          inactiveColor:const Color(0xffbababa),
          lineHeight: 3,
        ),
      ],
    ),
  ),
);