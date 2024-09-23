
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../common/constant/constant values.dart';
import 'package:flutter/foundation.dart';
import 'package:intl_phone_field/countries.dart';
Container buildSignupSection(countryCode,numberController) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    child: IntlPhoneField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 16),
        labelText:language=='English Language'? 'Phone number':"رقم الهاتف",),
      initialCountryCode: 'SA',

      onCountryChanged: (code){
        countryCode=code.fullCountryCode;
      },

      countries: CountriesHandler.availableCountries,
      validator: (value){return language=='English Language'?'Enter Valid phone number':"ادخل رقم هاتف صحيح";},
      invalidNumberMessage:language=='English Language'?'Enter Valid phone number':"ادخل رقم هاتف صحيح",
      controller: numberController,),
  );
}


class CountriesHandler {
  static List<Country> availableCountries = [
    const Country(
      name: "Saudi Arabia",
      nameTranslations: {
        "sk": "Saudská Arábia",
        "se": "Saudi-Arábia",
        "pl": "Arabia Saudyjska",
        "no": "Saudi-Arabia",
        "ja": "サウジアラビア",
        "it": "Arabia Saudita",
        "zh": "沙特阿拉伯",
        "nl": "Saoedi-Arabië",
        "de": "Saudi-Arabien",
        "fr": "Arabie saoudite",
        "es": "Arabia Saudí",
        "en": "Saudi Arabia",
        "pt_BR": "Arábia Saudita",
        "sr-Cyrl": "Саудијска Арабија",
        "sr-Latn": "Saudijska Arabija",
        "zh_TW": "沙烏地阿拉",
        "tr": "Suudi Arabistan",
        "ro": "Arabia Saudită",
        "ar": "السعودية",
        "fa": "عربستان سعودی",
        "yue": "沙地阿拉伯"
      },
      flag: "🇸🇦",
      code: "SA",
      dialCode: "966",
      minLength: 9,
      maxLength: 9,
    ),


      const Country(
        name: "Egypt",
        nameTranslations: {
          "sk": "Egypt",
          "se": "Egypt",
          "pl": "Egipt",
          "no": "Egypt",
          "ja": "エジプト",
          "it": "Egitto",
          "zh": "埃及",
          "nl": "Egypt",
          "de": "Ägypt",
          "fr": "Égypte",
          "es": "Egipt",
          "en": "Egypt",
          "pt_BR": "Egito",
          "sr-Cyrl": "Египат",
          "sr-Latn": "Egipat",
          "zh_TW": "埃及",
          "tr": "Mısır",
          "ro": "Egipt",
          "ar": "مصر",
          "fa": "مصر",
          "yue": "埃及"
        },
        flag: "🇪🇬",
        code: "EG",
        dialCode: "20",
        minLength: 10,
        maxLength: 10,
      ),
  ];
}
