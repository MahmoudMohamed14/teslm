import 'dart:convert';

import '../../../Core/Api/generic_request.dart';
import '../../../Core/Api/http_request.dart';
import '../../../Core/Error/exceptions.dart';
import '../../../Core/Error/failures.dart';
import '../../../Core/Network/custom_either.dart';
import '../../../common/end_points_api/api_end_points.dart';

class PostOrderDataHandler {
  static Future<Either<Failure, bool>> postCoupon({
    required String coupon,
    required int subtotal,
    required int shippingPrice,
  }) async {
    try {
      bool response = await GenericRequest<bool>(
        method: HttpRequestHandler.postJson(
            url: ApiEndPoint.couponsValidate,
            bodyJson: {
              "code": coupon,
              "subtotal": subtotal,
              "shippingPrice": shippingPrice
            }),
        fromMap: (data) {
          return data["statusCode"] == 200 || data["statusCode"] == 201;
        },
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }

  static Future<Either<Failure, Map<String,dynamic>>> postOrder({
    String? coupon,
    required List items,
    required String customerNotes,
    bool? isScheduled, // Pass the scheduling status
    DateTime? scheduledDate,
  }) async {
    try {
      print("coupon is $coupon");
      print({"couponId": coupon, "items": items, "customerNotes": customerNotes});
      Map<String,dynamic> response = await GenericRequest<Map<String,dynamic>>(
        method: HttpRequestHandler.postJson(url: ApiEndPoint.orders, bodyJson: {
          "couponId": coupon,
          "items": items,
          "customerNotes": customerNotes,
          "isScheduled": isScheduled??false, // Pass the scheduling status
          "scheduledDate":isScheduled??false? scheduledDate?.toIso8601String():null,
        }),
        fromMap: (data) {
          print("orderData#####3${data['id']} test");

          return {"status":data['id']!=null,"id":data['id']??''};
        },
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }

  static Future<Either<Failure, Map<String, dynamic>>> paymentMethod() async {
    final data = {
      "amount": 600,
      "currency": "SAR",
      "description": "Payment for order #123456789",
      "callback_url": "https://example.com/thankyou",
      "source": {
        "type": "creditcard",
        "name": "mahmoud mohamed",
        "number": "4201320111111010",
        "cvc": "123",
        "month": "12",
        "year": "26"
      }
    };

    const apiKey = 'pk_test_Z9MJdDVC96N12UzYPUgdkLREmQJHCmHdjZzY5EZm';
    final encodedApiKey = base64Encode(utf8.encode(apiKey));

    // Request headers
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $encodedApiKey',
    };
    try {
      Map<String, dynamic> response =
          await GenericRequest<Map<String, dynamic>>(
        method: HttpRequestHandler.postJson(
            headers: headers,
            useCustomHeader: true,
            url: 'https://api.moyasar.com/v1/payments',
            bodyJson: data),
        fromMap: (data) {
          print("data is $data");
          return data;
        },
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }
  static Future<Either<Failure, bool>> createPayment({
    required String moyasarId,
    required String moyasarPaymentUrl,
    required String orderId,
  }) async {
    try {
      bool response = await GenericRequest<bool>(
        method: HttpRequestHandler.postJson(
            url: ApiEndPoint.createPayments,
            bodyJson: {
              "moyasarId":moyasarId,
              "moyasarPaymentUrl": moyasarPaymentUrl,
              "orderId": orderId
            }),
        fromMap: (data) {
          print("data is payment $data");
          return data["moyasarPaymentId"] !=null && data["moyasarPaymentUrl"] !=null&& data["order"]['id'] !=null;
        },
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }
}
