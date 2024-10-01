import 'package:delivery/Utilities/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../../../../../Core/Api/generic_request.dart';
import '../../../../../Core/Api/http_request.dart';
import '../../../../../Core/Error/exceptions.dart';
import '../../../../../Core/Error/failures.dart';
import '../../../../../Core/Network/custom_either.dart';
import '../../../../../common/end_points_api/api_end_points.dart';
import '../../../../../models/get_user_data.dart';

class AccountDataHandler {
  static Future<Either<Failure, GetUserData>> getNewCustomer() async {
    try {
      debugPrint("TOKEN::::::::<<<< ${SharedPref.getToken()}");
      GetUserData response = await GenericRequest<GetUserData>(
        method: HttpRequestHandler.get(url: ApiEndPoint.getNewCustomer),
        fromMap: (data) {
          print("DATA::::::::<<<< $data");
          return GetUserData.fromJson(data);
        },
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }

  static Future<Either<Failure, GetUserData>> updateUser(
      {required Map<String, dynamic> bodyJson}) async {
    try {
      GetUserData response = await GenericRequest<GetUserData>(
        method: HttpRequestHandler.patchJson(
            url: ApiEndPoint.getNewCustomer, bodyJson: bodyJson),
        fromMap: (data) {
          print("DATA::::::::<<<< ");
          return GetUserData.fromJson(data);
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
