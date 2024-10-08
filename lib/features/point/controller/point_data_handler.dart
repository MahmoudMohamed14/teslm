import '../../../Core/Api/generic_request.dart';
import '../../../Core/Api/http_request.dart';
import '../../../Core/Error/exceptions.dart';
import '../../../Core/Error/failures.dart';
import '../../../Core/Network/custom_either.dart';
import '../../../common/constant/constant values.dart';
import '../../../common/end_points_api/api_end_points.dart';
import '../../../models/get_user_data.dart';
import '../../profile/navigator/my_coupons/Models/get_coupons_model.dart';

class PointDataHandler {
  static Future<Either<Failure, Points>> getPointsAndBalance() async {
    try {
      Points response = await GenericRequest<Points>(
        method:
            HttpRequestHandler.get(url: '${ApiEndPoint.wallet}/$customerId'),
        fromMap: (data) {
          return Points.fromJson(data);
        },
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }

  static Future<Either<Failure, GetCouponsModel>> getCouponsData() async {
    try {
      GetCouponsModel response = await GenericRequest<GetCouponsModel>(
        method: HttpRequestHandler.get(
            url: '${ApiEndPoint.saveCouponCustomer}'),
        fromMap: (data) {
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

  static Future<Either<Failure, bool>> redeemPointsCustomer() async {
    try {
      bool response = await GenericRequest<bool>(
        method: HttpRequestHandler.post(
            url:
                '${ApiEndPoint.wallet}/$customerId/${ApiEndPoint.redeemPoints}',
            body: {}),
        fromMap: (data) {
          return data['status'] == "ACTIVE";
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
