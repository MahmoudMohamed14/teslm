import '../../../Core/Api/generic_request.dart';
import '../../../Core/Api/http_request.dart';
import '../../../Core/Error/exceptions.dart';
import '../../../Core/Error/failures.dart';
import '../../../Core/Network/custom_either.dart';
import '../../../common/constant/constant values.dart';
import '../../../common/end_points_api/api_end_points.dart';

class PointDataHandler{
  static Future<Either<Failure, Map<String,dynamic>>>getPointsAndBalance()  async {
    try {
      Map<String,dynamic> response = await GenericRequest<Map<String,dynamic>>(
        method: HttpRequestHandler.get(
            url: '${ApiEndPoint.wallet}/$customerId'
        ),
        fromMap: (data) {
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
  static Future<Either<Failure, Map<String,dynamic>>>getCouponsData()  async {
    try {
      Map<String,dynamic> response = await GenericRequest<Map<String,dynamic>>(
        method: HttpRequestHandler.get(
            url: '${ApiEndPoint.wallet}/$customerId'
        ),
        fromMap: (data) {
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
}