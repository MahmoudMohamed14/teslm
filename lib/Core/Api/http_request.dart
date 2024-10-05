import 'dart:convert';
import 'dart:io';

// import 'package:ansicolor/ansicolor.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

// import 'package:identification/Utilities/router_config.dart';
// import 'package:identification/Utilities/shared_preferences.dart';

import '../../Utilities/shared_preferences.dart';
import '../Error/exceptions.dart';
import '../Network/error_message_model.dart';

class HttpRequestHandler {
  final Uri uri;
  final Map<String, String> body;
  final Map<String, dynamic> bodyJson;
  final List<MultipartFile> files;
  final Map<String, String>? headers;
  final String method;

  HttpRequestHandler.post({
    required String url,
    required this.body,
    this.files = const [],
    this.headers,
  })  : method = "POST",
        uri = Uri.parse(url),
        bodyJson = {};

  HttpRequestHandler.postJson({
    required String url,
    required this.bodyJson,
    this.headers,
  })  : method = "POST",
        uri = Uri.parse(url),
        files = [],
        body = {};

  HttpRequestHandler.patchJson({
    required String url,
    required this.bodyJson,
    this.headers,
  })  : method = "PATCH",
        uri = Uri.parse(url),
        files = [],
        body = {};

  HttpRequestHandler.put({
    required String url,
    required this.body,
    this.files = const [],
    this.headers,
  })  : method = "PUT",
        uri = Uri.parse(url),
        bodyJson = {};

  HttpRequestHandler.putJson({
    required String url,
    required this.bodyJson,
    this.headers,
  })  : method = "PUT",
        uri = Uri.parse(url),
        files = [],
        body = {};

  //  todo
  HttpRequestHandler.postJsonUri({
    required this.uri,
    required this.bodyJson,
    this.headers,
  })  : method = "POST",
        files = [],
        body = {};
  HttpRequestHandler.putJsonUri({
    required this.uri,
    required this.bodyJson,
    this.headers,
  })  : method = "POST",
        files = [],
        body = {};

  HttpRequestHandler.get({
    required String url,
    this.headers,
  })  : method = "GET",
        body = {},
        files = [],
        uri = Uri.parse(url),
        bodyJson = {};

  HttpRequestHandler.getUri({
    required this.uri,
    this.headers,
  })  : method = "GET",
        body = {},
        files = [],
        bodyJson = {};

  HttpRequestHandler.delete({
    required String url,
    required this.bodyJson,
    this.headers,
  })  : method = "DELETE",
        body = {},
        files = [],
        uri = Uri.parse(url);

  HttpRequestHandler.deleteUri({
    required this.uri,
    this.headers,
  })  : method = "DELETE",
        body = {},
        files = [],
        bodyJson = {};

  HttpRequestHandler.customMethod({
    required this.method,
    this.bodyJson = const {},
    required String url,
    this.headers,
    this.files = const [],
    this.body = const {},
  }) : uri = Uri.parse(url);

  HttpRequestHandler.customMethodUri({
    required this.method,
    required this.uri,
    this.bodyJson = const {},
    this.headers,
    this.files = const [],
    this.body = const {},
  });

  Future<Map<String, dynamic>> request({bool printBody = true}) async {
    debugPrint(uri.toString());
    if (printBody) {
      debugPrint(json.encode(body));
    }
    var request = MultipartRequest(method, uri);
    request.fields.addAll(body);
    request.files.addAll(files);
    if (headers != null) request.headers.addAll(headers!);
    return await _ApiBaseHelper.httpSendRequest(request, this);
  }

  Future<Map<String, dynamic>> requestJson({bool printBody = true}) async {
    print("Start>>>>>>>");
    debugPrint(uri.toString());
    if (printBody) {
      debugPrint(json.encode(bodyJson));
    }
    var request = Request(method, uri);
    request.body = json.encode(bodyJson);
    if (headers != null) request.headers.addAll(headers!);
    return await _ApiBaseHelper.httpSendRequest(request, this);
  }
}

class _ApiBaseHelper {
  static Future<dynamic> httpSendRequest(
      BaseRequest request, HttpRequestHandler requestApi) async {
    StreamedResponse response;
    try {
      ///   -----
      request.headers.addAll({
        'Accept': '*/*',
        'content-type': 'application/json',
        "Authorization": "Bearer ${SharedPref.getToken()}",
        "lat": SharedPref.getLatLng()?[0] ?? "",
        "lng": SharedPref.getLatLng()?[1] ?? "",
        // "lang": CURRENT_CONTEXT!.locale.languageCode
      });

      response = await request.send().timeout(const Duration(seconds: 60));
      debugPrint("statusCode: ${response.statusCode}");
    } on SocketException {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: 500,
          statusMessage: "No Internet Connection",
          requestApi: requestApi,
        ),
      );
    } on FormatException {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: 500,
          statusMessage: "Bad Format",
          requestApi: requestApi,
        ),
      );
    } on Exception {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: 500,
          statusMessage: 'Unexpected error 😢',
          requestApi: requestApi,
        ),
      );
    }
    return _returnResponse(response, requestApi);
  }

  static Future<dynamic> _returnResponse(
      StreamedResponse response, HttpRequestHandler requestApi) async {
    String resStream = await response.stream.bytesToString();
    Map<String, dynamic> jsonResponse = {};

    ServerException serverException({String? message}) => ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: message,
              requestApi: requestApi,
              responseApi: jsonResponse),
        );

    try {
      jsonResponse = jsonDecode(resStream) is List
          ? {"data": jsonDecode(resStream) as List<dynamic>}
          : jsonDecode(resStream) as Map<String, dynamic>;
    } catch (e) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
            statusCode: response.statusCode,
            requestApi: requestApi,
            responseApi: {
              "_THIS_KEY_FROM_APP_THERE_IS_NO_KEY_GETTING_": resStream
            }),
      );
    }
    debugPrint("$jsonResponse");

    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        {
          if (jsonResponse["success"] == false) {
            print(".........> ${jsonResponse["message"].runtimeType}");
            throw serverException(
                message: (jsonResponse["message"] as List).first.toString());
          }
          return jsonResponse;
        }
      default:
        print(".........> ${jsonResponse["message"].runtimeType}");
        throw serverException(
            message: (jsonResponse["message"] as List).first.toString());
    }
  }
}
