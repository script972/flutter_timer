import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/network/api_client.dart';

class HttpManager {
  static final HttpManager _singleton = new HttpManager._internal();

  factory HttpManager() {
    return _singleton;
  }

  HttpManager._internal();

  final JsonDecoder _decoder = new JsonDecoder();

  dynamic decodeResp(d) {
    var response = d as Response;
    final dynamic jsonBody = response.data;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new Exception("statusCode: $statusCode");
    }

    if (jsonBody is String) {
      return _decoder.convert(jsonBody);
    } else {
      return jsonBody;
    }
  }

  Dio get dio {
    Dio dio = Dio();
    dio.options.baseUrl = ApiClient.BASE_URL;
    dio.options.connectTimeout = 20000;
    dio.options.receiveTimeout = 20000;
    dio.options.responseType = ResponseType.json;
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      debugPrint("<<<<<<REQUEST=${options}");
      return options;
    }, onResponse: (Response response) async {
      debugPrint("<<<<<<RESPONSE=${response}");
      return response;
    }));
    return dio;
  }
}
