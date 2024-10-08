import 'package:delivery/Utilities/shared_preferences.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:flutter/material.dart';
import '../../../../../Core/Api/generic_request.dart';
import '../../../../../Core/Api/http_request.dart';
import '../../../../../Core/Error/exceptions.dart';
import '../../../../../Core/Error/failures.dart';
import '../../../../../Core/Network/custom_either.dart';
import '../../../../../common/end_points_api/api_end_points.dart';
import '../../../../../models/post_coupon.dart';
import '../Models/get_coupons_model.dart';

class CouponsDataHandler {
  static Future<Either<Failure, GetCouponsModel>> getUserCoupons() async {
    try {
      debugPrint("TOKEN::::::::<<<< ${SharedPref.getToken()}");
      GetCouponsModel response = await GenericRequest<GetCouponsModel>(
        method: HttpRequestHandler.getUri(
            uri: ApiEndPoint.uri(path: ApiEndPoint.coupons,)

        ),
        fromMap: (data) {
          print("DATA::::::::<<<< $data");
          return GetCouponsModel.fromJson(data);
        },
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }
  static Future<Either<Failure, PostCoupon>> saveCoupon({
    required String couponCode,
  }) async {
    // print("otp is $otp");
    try {
      PostCoupon response = await GenericRequest<PostCoupon>(
        method:
        HttpRequestHandler.postJson(url: ApiEndPoint.saveCouponCustomer, bodyJson: {
          'couponCode': couponCode,
        }),
        fromMap: (data) => PostCoupon.fromJson(data),
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }
}
