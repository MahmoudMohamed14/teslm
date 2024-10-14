import 'package:delivery/models/provider_model.dart';

import '../../../Core/Api/generic_request.dart';
import '../../../Core/Api/http_request.dart';
import '../../../Core/Error/exceptions.dart';
import '../../../Core/Error/failures.dart';
import '../../../Core/Network/custom_either.dart';
import '../../../common/end_points_api/api_end_points.dart';
import '../../../models/categories_model.dart';
import '../../../models/offers_model.dart';

class HomeDataHandler {
  static Future<Either<Failure, AdvertisingModel>> getAdvertisingHome() async {
    try {
      AdvertisingModel response = await GenericRequest<AdvertisingModel>(
        method: HttpRequestHandler.get(
          url: ApiEndPoint.ads,
        ),
        fromMap: AdvertisingModel.fromJson,
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }

  static Future<Either<Failure, List<CategoriesModel>>>
      getCategoryHome() async {
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

  static Future<Either<Failure, ProviderHome>> getProvidersHome() async {
    try {
      ProviderHome response = await GenericRequest<ProviderHome>(
        method: HttpRequestHandler.get(
          url: ApiEndPoint.providersHome,
        ),
        fromMap: ProviderHome.fromJson,
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }
}
