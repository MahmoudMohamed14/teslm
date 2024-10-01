import '../../../Core/Api/generic_request.dart';
import '../../../Core/Api/http_request.dart';
import '../../../Core/Error/exceptions.dart';
import '../../../Core/Error/failures.dart';
import '../../../Core/Network/custom_either.dart';
import '../../../common/end_points_api/api_end_points.dart';

class ProviderDataHandler{

  static Future<Either<Failure, Map<String,dynamic>>>getProviderData ({

    required String id,
  }) async {
    try {
      print('${ApiEndPoint.providers}/$id');
      Map<String,dynamic> response = await GenericRequest<Map<String,dynamic>>(
        method: HttpRequestHandler.get(
            url: '${ApiEndPoint.providers}/$id'
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