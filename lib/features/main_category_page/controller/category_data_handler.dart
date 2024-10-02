import 'package:delivery/models/provider_model.dart';

import '../../../Core/Api/generic_request.dart';
import '../../../Core/Api/http_request.dart';
import '../../../Core/Error/exceptions.dart';
import '../../../Core/Error/failures.dart';
import '../../../Core/Network/custom_either.dart';
import '../../../common/end_points_api/api_end_points.dart';
import '../../../models/categories_model.dart';
import '../../../models/categories_provider.dart';
import '../../../models/filter_model.dart';
import '../../../models/offers model.dart';
import '../../../models/offers_model.dart';

class CategoryDataHandler {
  static Future<Either<Failure, Advertising>> getCategoryAdvertising(String categoryId,) async {
    try {
      Advertising response = await GenericRequest<Advertising>(
        method: HttpRequestHandler.get(
          url: '${ApiEndPoint.getAdsByCategory}/$categoryId',
        ),
        fromMap: Advertising.fromJson,
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }

  static Future<Either<Failure, FilterProvidersModel>> getFilterProviders(String sortField,String sortBy) async {
    try {
      FilterProvidersModel response = await GenericRequest<FilterProvidersModel>(
        method: HttpRequestHandler.get(
          url: '${ApiEndPoint.providersCustomers}?sortOrder=$sortField&sortField=$sortBy',
        ),
        fromMap: FilterProvidersModel.fromJson,
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }

  static Future<Either<Failure, CategoryProviderModel>> getCategoryProviders(String categoryId) async {
    try {
      CategoryProviderModel response = await GenericRequest<CategoryProviderModel>(
        method: HttpRequestHandler.get(
          url: '${ApiEndPoint.categories}/$categoryId',
        ),
        fromMap: CategoryProviderModel.fromJson,
      ).getResponse(printBody: false);
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
