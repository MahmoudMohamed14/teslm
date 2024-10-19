
import 'package:delivery/common/extensions.dart';
import 'package:delivery/common/images/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../common/colors/theme_model.dart';
import '../common/text_style_helper.dart';
import 'app_text_widget.dart';

class CreditCardWidget extends StatefulWidget {
  final CardModel? cardModel;
 final int id ;
  const CreditCardWidget({super.key, this.cardModel, required this.id});

  @override
  State<CreditCardWidget> createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {



  @override
  Widget build(BuildContext context) {
    return Card(

      child: Container(
        decoration: BoxDecoration(
          color: ThemeModel.of(context).primary.withOpacity(widget.id/10),
          borderRadius: BorderRadius.circular(20.h),
        ),
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               SvgPicture.asset(
                 ImagesApp.logoSvg,
               )
      
              ],
            ),
            32.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppTextWidget(
      
                  "${1234} ••• ••• ••• •••",
                  textAlign: TextAlign.start,
                  style: TextStyleHelper.of(context)
                      .regular16
                      .copyWith(fontWeight: FontWeight.w600),
                ).expand,
                8.w.widthBox,
             /*   GestureDetector(
                  onTap: _showData,
                  child: SvgPicture.asset(
                    dataIsVisible ? Assets.hideCardData : Assets.showCardData,
                    height: 24.h,
                    width: 24.w,
                    colorFilter: ColorFilter.mode(
                        ThemeModel.of(context).font1, BlendMode.srcIn),
                  ),
                )*/
              ],
            ),
            32.h.heightBox,
            Row(
              children: [
                AppTextWidget(
                  "••••• •••••",
                  style: TextStyleHelper.of(context).regular16,
                ),
                const Spacer(),
                Column(
                  children: [
                    AppTextWidget(
                      "CVV",
                      style: TextStyleHelper.of(context).regular12.copyWith(
                            color: ThemeModel.of(context).font1,
                          ),
                    ),
                    12.h.heightBox,
                    AppTextWidget(
                       "•••",
                      style: TextStyleHelper.of(context).regular16.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                32.w.widthBox,
                Column(
                  children: [
                    AppTextWidget(
                      "EXP",
                      style: TextStyleHelper.of(context).regular12.copyWith(
                            color: ThemeModel.of(context).font1,
                          ),
                    ),
                    12.h.heightBox,
                    AppTextWidget(
                       "••/••••",
                      style: TextStyleHelper.of(context).regular16.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class CardModel {
  final int? id;
  final int? userId;
  final String? cardNumber;
  final String? cardName;
  final String? cardholderName;
  final String? expiryDate;
  final String? balance;
  final String? status;
  final double? limit;
  final DateTime? createdAt;
  final DateTime? updatedAt;
 // final List<Transaction> transactions;

  CardModel({
    this.id,
    this.userId,
    this.cardNumber,
    this.cardName,
    this.cardholderName,
    this.expiryDate,
    this.balance,
    this.status,
    this.limit,
    this.createdAt,
    this.updatedAt,
    //this.transactions = const [],
  });

  CardModel copyWith({
    int? id,
    int? userId,
    String? cardNumber,
    String? cardName,
    String? cardholderName,
    String? expiryDate,
    String? balance,
    String? status,
    double? limit,
    DateTime? createdAt,
    DateTime? updatedAt,
    //List<Transaction>? transactions,
  }) =>
      CardModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        cardNumber: cardNumber ?? this.cardNumber,
        cardName: cardName ?? this.cardName,
        cardholderName: cardholderName ?? this.cardholderName,
        expiryDate: expiryDate ?? this.expiryDate,
        balance: balance ?? this.balance,
        status: status ?? this.status,
        limit: limit ?? this.limit,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
       // transactions: transactions ?? this.transactions,
      );

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
    id: json["id"],
    userId: json["user_id"],
    cardNumber: json["card_number"],
    cardName: json["card_name"],
    cardholderName: json["cardholder_name"],
    expiryDate: json["expiry_date"],
    balance: json["balance"],
    status: json["status"],
    limit: json["limit"]?.toDouble(),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    //transactions: json["transactions"] == null
       // ? []
       // : List<Transaction>.from(
       // json["transactions"]!.map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "card_number": cardNumber,
    "card_name": cardName,
    "cardholder_name": cardholderName,
    "expiry_date": expiryDate,
    "balance": balance,
    "status": status,
    "limit": limit,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
   // "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
  };
}

