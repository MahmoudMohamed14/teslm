import '../../../Core/Api/generic_request.dart';
import '../../../Core/Api/http_request.dart';
import '../../../Core/Error/exceptions.dart';
import '../../../Core/Error/failures.dart';
import '../../../Core/Network/custom_either.dart';
import '../../../common/end_points_api/api_end_points.dart';
import '../../../models/customer_orders_model.dart';
import '../../../models/get_user_data.dart';

class OrderDataHandler{
  static Future<Either<Failure, CustomerOrders>>getCustomerOrders()  async {
    try {
      CustomerOrders response = await GenericRequest<CustomerOrders>(
        method: HttpRequestHandler.get(
            url: ApiEndPoint.myOrders
        ),
        fromMap: (data) {
          return CustomerOrders.fromJson(data);
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