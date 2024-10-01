import '../../../Core/Api/generic_request.dart';
import '../../../Core/Api/http_request.dart';
import '../../../Core/Error/exceptions.dart';
import '../../../Core/Error/failures.dart';
import '../../../Core/Network/custom_either.dart';
import '../../../common/end_points_api/api_end_points.dart';
import '../../../models/otp_model.dart';

class AuthDataHandler {
  static Future<Either<Failure, bool>> generateOTP({
    required String phoneNumber,
    required String code,
  }) async {
    try {
      bool response = await GenericRequest<bool>(
        method: HttpRequestHandler.postJson(
            url: ApiEndPoint.generateOtp,
            bodyJson: {
              'phoneNumber': "$code$phoneNumber",
            }),
        fromMap: (data) {
          return data["message"] == "OTP generated successfully";
        },
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }

  static Future<Either<Failure, LoginOTP>> userLoginOTP({
    required String phoneNumber,
    required String otp,
  }) async {
    // print("otp is $otp");
    try {
      LoginOTP response = await GenericRequest<LoginOTP>(
        method:
            HttpRequestHandler.postJson(url: ApiEndPoint.verifyOtp, bodyJson: {
          'otp': otp,
          'phoneNumber': phoneNumber,
        }),
        fromMap: (data) => LoginOTP.fromJson(data),
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }
}
