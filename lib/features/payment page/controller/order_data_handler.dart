import '../../../Core/Api/generic_request.dart';
import '../../../Core/Api/http_request.dart';
import '../../../Core/Error/exceptions.dart';
import '../../../Core/Error/failures.dart';
import '../../../Core/Network/custom_either.dart';
import '../../../common/end_points_api/api_end_points.dart';
import '../../../models/otp_model.dart';

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
              "code" : coupon,
              "subtotal":subtotal,
              "shippingPrice":shippingPrice
            }),
        fromMap: (data) {
          return data["statusCode"] == 200||data["statusCode"] == 201;
        },
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }

  static Future<Either<Failure, bool>> postOrder({
    String? coupon,
    required List items,
    required String customerNotes,
  }) async {
    try {
      bool response = await GenericRequest<bool>(
        method: HttpRequestHandler.postJson(
            url: ApiEndPoint.orders,
            bodyJson: {
              "couponId": coupon,
              "items": items,
              "customerNotes": customerNotes
            }),
        fromMap: (data) {
          return data["statusCode"] == 200||data["statusCode"] == 201;
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
