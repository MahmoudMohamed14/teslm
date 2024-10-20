import 'package:delivery/common/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/colors/colors.dart';
import '../common/colors/theme_model.dart';
import '../common/constant/constant values.dart';
import '../common/text_style_helper.dart';
import 'app_text_widget.dart';

class NewCustomTextEdited extends StatelessWidget {

  final TextEditingController? controller;
  final bool? obscure;
  final bool? readOnly;
  final String? hint;
  final String? title;
  final Color? backGroundColor, focusedBorderColor;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final int? maxLine, minLines;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final bool? isDense;
  final Color? borderColor;
  final bool disableBorder;
  final FocusNode? focusNode;
  final double? borderRadiusValue, width, height;
  final void Function(String?)? onSave;
  final Widget? prefixIcon, suffixIcon;
  final void Function(String)? onchange;
  final Function()? onSuffixTap;
  final List<TextInputFormatter>? formatter;
  final TextInputAction? textInputAction;
  final bool? expands;
  final int?maxLength;
  final bool enable,

      isClickable,
      autoFocus,
      cancelDisableBackground,
      disableLabel;
  final TextDirection? textDirection;
  final TextAlign? textAlign;

  const NewCustomTextEdited({
    super.key,
    this.isDense,
    this.style,
    this.onchange,
    this.title,
    this.maxLength,
    this.validator,
    this.maxLine,
    this.hint,
    this.backGroundColor,
    this.controller,
    this.obscure = false,
    this.enable = true,
    this.textDirection,
    this.readOnly = false,
    this.disableLabel = false,
    this.textInputType = TextInputType.text,
    this.borderColor,
    this.borderRadiusValue,
    this.prefixIcon,
    this.width,
    this.hintStyle,
    this.suffixIcon,
    this.onSuffixTap,
    this.height,
    this.formatter,
    this.focusNode,
    this.focusedBorderColor,
    this.onSave,
    this.minLines,
    this.disableBorder = false,
    this.textInputAction,
    this.expands,
    this.isClickable = false,
    this.autoFocus = false,
    this.cancelDisableBackground = false,
    this.textAlign = TextAlign.start,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          AppTextWidget(
            title!,
            style: TextStyleHelper.of(context)
                .regular16
                .copyWith(color: ThemeModel.of(context).font1),
          ),
          8.h.heightBox
        ],
        TextFormField(
          onChanged: onchange,
          onSaved: onSave,
          maxLength: maxLength,

          keyboardType: textInputType,

          validator: validator,
          controller: controller,
         // readOnly: readOnly,
          decoration: InputDecoration(

            prefixIcon: prefixIcon,

            fillColor: ThemeModel.of(context).myAccountTextFieldLightColor,
            filled: true,
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
              borderRadius: BorderRadius.all(Radius.circular(borderRadiusValue??20.0)),
            ) ,
            enabledBorder:  OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
              borderRadius: BorderRadius.all(Radius.circular(borderRadiusValue??20.0)),
            ),
            errorBorder:  OutlineInputBorder(
              borderSide: const BorderSide(
                  color:  Colors.red ),
              borderRadius: BorderRadius.all(Radius.circular(borderRadiusValue??20.0)),
            ),
            hintText: hint,
            focusedBorder:  OutlineInputBorder(
              borderSide: const BorderSide(
                  color:  Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(borderRadiusValue??20.0)),
            ),
            labelStyle: TextStyle(
                fontSize:  12,
                color: isDark ?? false ? Colors.white : Colors.black),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
      ],
    );
  }
}
