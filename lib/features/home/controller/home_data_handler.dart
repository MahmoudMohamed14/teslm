import '../../../Core/Api/generic_request.dart';
import '../../../Core/Api/http_request.dart';
import '../../../Core/Error/exceptions.dart';
import '../../../Core/Error/failures.dart';
import '../../../Core/Network/custom_either.dart';
import '../../../common/end_points_api/api_end_points.dart';
import '../../../models/categories_model.dart';

class HomeDataHandler {
  static Future<Either<Failure, List<CategoriesModel>>> getCategoryHome() async {
    try {
      List<CategoriesModel> response = await GenericRequest<CategoriesModel>(
        method: HttpRequestHandler.get(
          url: ApiEndPoint.categories,
        ),
        fromMap: CategoriesModel.fromJson,
      ).getList(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }
}
