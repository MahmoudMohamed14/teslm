
import 'package:delivery/common/extensions.dart';
import 'package:delivery/features/auth/widget/sign%20in%20card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../common/colors/theme_model.dart';
import '../../../common/text_style_helper.dart';



class PhoneFieldWidget extends StatelessWidget {
  final String? initialCountryCountry;
  final TextEditingController? controller;
  final bool? obscure;
  final bool? readOnly;
  final String? hint;
  final String? title;
  final Color? backGroundColor, focusedBorderColor;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final int? maxLine, minLines;
    final String? Function(PhoneNumber?)? validator;
  final TextInputType? textInputType;
  final bool? isDense;
  final Color? borderColor;
  final bool disableBorder;
  final FocusNode? focusNode;
  final double? borderRadiusValue, width, height;
  final void Function(String?)? onSave;
  final Widget? prefixIcon, suffixIcon;
  final void Function(PhoneNumber)? onchange;
  final Function()? onSuffixTap;
  final TextInputAction? textInputAction;
  final bool? expands;
  final bool enable,
      isError,
      isClickable,
      autoFocus,
      cancelDisableBackground,
      disableLabel;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final Function(Country)? onCountryChanged;

  const PhoneFieldWidget({
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
    this.initialCountryCountry,
    this.onCountryChanged, required this.isError,
  });
  @override
  Widget build(BuildContext context) {
    InputBorder? getBorder(BuildContext context,
        {double? radius, Color? color}) {
      if (disableBorder) return null;
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius ?? 12.h),
        borderSide: BorderSide(
          color: color ?? Colors.transparent,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: TextStyleHelper.of(context)
                .regular16
                .copyWith(color: ThemeModel.of(context).font1),
          ),
          8.h.heightBox
        ],
        SizedBox(
          height: height ?? 80.h,
          width: width ?? 380.w,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: IntlPhoneField(
              countries: CountriesHandler.availableCountries,
              languageCode: 'en',
              invalidNumberMessage: "",
              flagsButtonMargin: EdgeInsets.symmetric(horizontal: 8.w),
              autovalidateMode: AutovalidateMode.onUserInteraction,
               validator:validator,
              decoration: InputDecoration(
                disabledBorder: getBorder(context),
                errorStyle: const TextStyle(fontSize: 8),
               // errorBorder: getBorder(context,color: Colors.red),
               // focusedErrorBorder: getBorder(context,color: Colors.red),
                errorText:isError ? "":null,
                counter: const Offstage(),
                border: getBorder(context),
                enabledBorder: getBorder(context),
                focusedBorder: getBorder(context),
                fillColor: (backGroundColor ?? const Color(0xFFEDEEF0)),
                filled: true,
                isDense: isDense ?? false,
                hintText: hint,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
                prefixIcon: prefixIcon,
                hintStyle: hintStyle ??
                    TextStyleHelper.of(context)
                        .regular16
                        .copyWith(color: ThemeModel.of(context).font3),
              ),
              showDropdownIcon: false,
              initialCountryCode: initialCountryCountry ?? 'SA',
              initialValue:controller?.text == null ? null: controller!.text,
              onCountryChanged: onCountryChanged,
              controller: controller,
            
              onChanged: onchange,
             // textDirection: textDirection,
            
            
               // textDirection:TextDirection.ltr
            ),
          ),
        ),
      ],
    );
  }
}
