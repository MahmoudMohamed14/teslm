import '../../../Core/Api/generic_request.dart';
import '../../../Core/Api/http_request.dart';
import '../../../Core/Error/exceptions.dart';
import '../../../Core/Error/failures.dart';
import '../../../Core/Network/custom_either.dart';
import '../../../common/end_points_api/api_end_points.dart';
import '../../../models/categories_model.dart';

class HomeDataHandler {
  static Future<Either<Failure, List<Categories>>> getCategoryHome() async {
    try {
      List<Categories> response = await GenericRequest<Categories>(
        method: HttpRequestHandler.get(
          url: ApiEndPoint.categories,
        ),
        fromMap: Categories.fromJson,
      ).getList(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }
}
