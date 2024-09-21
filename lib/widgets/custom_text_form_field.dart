import 'package:delivery/common/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/colors/theme_model.dart';
import '../common/text_style_helper.dart';
import 'app_text_widget.dart';


class CustomTextFormField extends StatelessWidget {
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
  final bool enable,
      isClickable,
      autoFocus,
      cancelDisableBackground,
      disableLabel;
  final TextDirection? textDirection;
  final TextAlign? textAlign;

  const CustomTextFormField({
    super.key,
    this.isDense,
    this.style,
    this.onchange,
    this.title,
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

  InputBorder? getBorder(BuildContext context, {double? radius, Color? color}) {
    if (disableBorder) return null;
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 12.h),
      borderSide: BorderSide(
        color: color ?? Colors.transparent,
      ),
    );
  }

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
        SizedBox(
          height: height ?? 48.h,
          width: width ?? 380.w,
          child: TextFormField(
            keyboardType: textInputType,
            onChanged: onchange,

            style: TextStyleHelper.of(context).regular16,
            enabled: enable,
            controller: controller,
            textDirection: textDirection,
            textAlign: textAlign ?? TextAlign.start,
            autofocus: autoFocus,
            mouseCursor: isClickable ? SystemMouseCursors.click : null,
            textInputAction: textInputAction ??
                (onSave != null ? null : TextInputAction.next),
            onFieldSubmitted: onSave,
            focusNode: focusNode,
            readOnly: readOnly ?? false,
            textAlignVertical: TextAlignVertical.center,
            validator: validator,
            inputFormatters: formatter,
            obscureText: obscure ?? false,
            expands: expands ?? false,
            maxLines: maxLine ?? 1,
            minLines: minLines ?? 1,

            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                  onTap: onSuffixTap,
                  child: suffixIcon?.paddingSymmetric(horizontal: 12.w)),
              suffixIconConstraints: BoxConstraints(
                maxHeight: 32.h,
                maxWidth: 48.w,
              ),
              errorStyle: const TextStyle(height: 0, fontSize: 0),
              enabledBorder: getBorder(context,
                  radius: borderRadiusValue, color: borderColor),
              disabledBorder: getBorder(context,
                  radius: borderRadiusValue, color: borderColor),
              errorBorder: getBorder(context,color: Colors.red,radius: borderRadiusValue),
              focusedBorder: getBorder(context, radius: borderRadiusValue),
              border: getBorder(context, radius: borderRadiusValue),
              isDense: isDense ?? false,
            //  fillColor: (backGroundColor ?? ThemeModel.of(context).card),
              filled: true,
              hintText: hint,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
              prefixIcon: prefixIcon,
              hintStyle: hintStyle ??
                  TextStyleHelper.of(context)
                      .regular16
                      .copyWith(color: ThemeModel.of(context).font3),
            ),
          ),
        ),
      ],
    );
  }
}
