// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_starter_kit_2024/app/data/config/encryption.dart';
import 'package:get_starter_kit_2024/app/data/config/logger.dart';
import 'package:get_starter_kit_2024/app/data/local/user_provider.dart';
import 'package:get_starter_kit_2024/app/utils/network_call_back.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:http_parser/http_parser.dart' as http_parser;
import 'package:path/path.dart' as path;

/// DIO interceptor to add the authentication token
InterceptorsWrapper addAuthToken({String authTokenHeader = 'authToken'}) =>
    InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        options.headers.addAll(<String, dynamic>{
          authTokenHeader: 'Bearer ${UserProvider.authToken}',
        });
        handler.next(options); //continue
      },
    );

/// Dio interceptor to encrypt the request body
InterceptorsWrapper encryptBody() => InterceptorsWrapper(
  onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
    final String method = options.method.toUpperCase();

    if (options.headers['encrypt'] as bool) {
      switch (method) {
        case 'POST':
        case 'PUT':
        case 'PATCH':
          logW('encrypting $method method');
          if (options.data.runtimeType.toString() ==
              '_InternalLinkedHashMap<String, dynamic>') {
            logI('Data will be encrypted before sending request');
            options.data = <String, dynamic>{
              'data': AppEncryption.encrypt(
                  plainText: jsonEncode(options.data)),
            };
          } else {
            logI(
                'Skipping encryption for ${options.data.runtimeType} type');
          }

          break;
        default:
          logWTF('Skipping encryption for $method method');
          break;
      }
    }
    handler.next(options); //continue
  },
);

/// API service of the application. To use Get, POST, PUT and PATCH rest methods
class APIService {
  static final Dio _dio = Dio();

  static late String _prodBaseApiUrl;
  static late String _devBaseApiUrl;


  static String get _baseUrl => kReleaseMode ? _prodBaseApiUrl : _devBaseApiUrl;


  // /// Basic authentication string
  // static String basicAuth =
  //     'Basic ${base64Encode(utf8.encode('TODO(ASHISH):TODO(ASHISH'))}';

  /// Initialize the API service
  static void initializeAPIService({
    required String devBaseUrl,
    required String prodBaseUrl,
    bool encryptData = false,
    String authHeader = 'authToken',
    String xAPIKeyHeader = 'x-api-key',
    String xAPIKeyValue = 'x-api-key',
  }) {
    _devBaseApiUrl = devBaseUrl;
    _prodBaseApiUrl = prodBaseUrl;

    _dio.options.headers.addAll(<String, dynamic>{
      xAPIKeyHeader: xAPIKeyValue,
    });
    /*if (UserProvider.isLoggedIn) {
      _dio.options.headers.addAll(<String, dynamic>{
        authHeader: UserProvider.authToken,
      });
    }*/
    _dio.interceptors.add(addAuthToken(authTokenHeader: authHeader));
    //Add interceptor for encryption layer
    if (encryptData) {
      logI('Data will be encrypted for POST / PUT / PATCH');
      _dio.interceptors.add(encryptBody());
    }
    if (kDebugMode) {
      //Add interceptor for console logs
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ));
    }

    // _restClient.getTasks();
  }

  /// GET rest API call
  /// Used to get data from backend
  ///
  /// Use [forcedBaseUrl] when want to use specific baseurl other
  /// than configured
  ///
  /// The updated data to be passed in [data]
  ///
  /// [params] are query parameters
  ///
  /// [path] is the part of the path after the base URL
  ///
  /// set [encrypt] to true if the body needs to be encrypted. Make sure the
  /// encryption keys in the backend matches with the one in frontend
  static Future<Response<Map<String, dynamic>?>> get({
    required String path,
    required NetworkCallBack callBack,
    Map<String, dynamic>? params,
    bool encrypt = true,
    String? forcedBaseUrl,
  }) async {
    try {
      final Response<Map<String, dynamic>?> response =
      await _dio.get<Map<String, dynamic>?>(
        (forcedBaseUrl ?? _baseUrl) + path,
        queryParameters: params,
        options: Options(
          headers: <String, dynamic>{
            'encrypt': encrypt,
            // 'authorization':
            // (forcedBaseUrl?.isEmpty ?? true) || forcedBaseUrl == null
            //     ? basicAuth
            //     : null,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Call the success callback if the response status code is 200 or 201
        callBack.onSuccess.call(response.data ?? {});
      } else {
        // Call the failure callback for other status codes
        callBack.onFailure.call(response.data ?? {});
      }
      return response;
    } on DioError catch (e) {
      logE('Dio error exception || $e');
      rethrow;
    }
  }

  // static Future<Response<Map<String, dynamic>?>?> get({
  //   required String path,
  //   Map<String, dynamic>? params,
  //   bool encrypt = true,
  //   String? forcedBaseUrl,
  // }) async =>
  //     _dio.get<Map<String, dynamic>?>(
  //       (forcedBaseUrl ?? _baseUrl) + path,
  //       queryParameters: params,
  //       options: Options(headers: <String, dynamic>{
  //         'encrypt': encrypt,
  //       }),
  //     );

  /// POST rest API call
  /// Used to send any data to server and get a response
  ///
  /// Use [forcedBaseUrl] when want to use specific baseurl other
  /// than configured
  ///
  /// The updated data to be passed in [data]
  ///
  /// [params] are query parameters
  ///
  /// [path] is the part of the path after the base URL
  ///
  /// set [encrypt] to true if the body needs to be encrypted. Make sure the
  /// encryption keys in the backend matches with the one in frontend

  static Future<Response<Map<String, dynamic>?>> post({
    required String path,
    required NetworkCallBack callBack,
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    bool encrypt = true,
    String? forcedBaseUrl,
  }) async {
    try {
      final Response<Map<String, dynamic>?> response =
      await _dio.post<Map<String, dynamic>?>(
        (forcedBaseUrl ?? _baseUrl) + path,
        data: data,
        queryParameters: params,
        options: Options(
          headers: <String, dynamic>{
            'encrypt': encrypt,
            // 'authorization': basicAuth,
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Call the success callback if the response status code is 200 or 201
        callBack.onSuccess.call(response.data!);
      } else {
        // Call the failure callback for other status codes
        callBack.onFailure.call(response.data!);
      }
      return response;
    } on DioError catch (e) {
      logE('Dio error exception || $e');
      rethrow;
    }
  }

  // static Future<Response<Map<String, dynamic>?>?> post({
  //   required String path,
  //   Map<String, dynamic>? data,
  //   Map<String, dynamic>? params,
  //   bool encrypt = true,
  //   String? forcedBaseUrl,
  // }) async => _dio.post<Map<String, dynamic>?>(
  //       (forcedBaseUrl ?? _baseUrl) + path,
  //       data: data,
  //       queryParameters: params,
  //       options: Options(
  //         headers: <String, dynamic>{
  //           'encrypt': encrypt,
  //           'authorization': basicAuth,
  //           'Content-Type': 'application/json',
  //           'Accept': '*/*',
  //           'Accept-Encoding': 'gzip, deflate, br',
  //           'Connection': 'keep-alive',
  //         },
  //       ),
  //     );

  /// PUT rest API call
  /// Usually used to create new record
  ///
  /// Use [forcedBaseUrl] when want to use specific baseurl other
  /// than configured
  ///
  /// The updated data to be passed in [data]
  ///
  /// [params] are query parameters
  ///
  /// [path] is the part of the path after the base URL
  ///
  /// set [encrypt] to true if the body needs to be encrypted. Make sure the
  /// encryption keys in the backend matches with the one in frontend
  static Future<Response<Map<String, dynamic>?>?> put({
    required String path,
    FormData? data,
    Map<String, dynamic>? params,
    bool encrypt = true,
    String? forcedBaseUrl,
  }) async =>
      _dio.put<Map<String, dynamic>?>(
        (forcedBaseUrl ?? _baseUrl) + path,
        data: data,
        queryParameters: params,
        options: Options(headers: <String, dynamic>{
          'encrypt': encrypt,
        }),
      );

  /// PATCH rest API call
  /// Usually used to update any record
  ///
  /// Use [forcedBaseUrl] when want to use specific baseurl other
  /// than configured
  ///
  /// The updated data to be passed in [data]
  ///
  /// [params] are query parameters
  ///
  /// [path] is the part of the path after the base URL
  ///
  /// set [encrypt] to true if the body needs to be encrypted. Make sure the
  /// encryption keys in the backend matches with the one in frontend
  static Future<Response<Map<String, dynamic>?>?> patch({
    required String path,
    FormData? data,
    Map<String, dynamic>? params,
    bool encrypt = true,
    String? forcedBaseUrl,
  }) async =>
      _dio.patch<Map<String, dynamic>?>(
        (forcedBaseUrl ?? _baseUrl) + path,
        data: data,
        queryParameters: params,
        options: Options(headers: <String, dynamic>{
          'encrypt': encrypt,
        }),
      );

  /// Upload file to the server. You will get the URL in the response if the
  /// [file] was uploaded successfully. Else you will get null in response.
  ///
  static Future<String?> uploadFile({
    required File file,
    required String folder,
    required NetworkCallBack callBack,
  }) async {
    final Response<Map<String, dynamic>?>? response = await APIService.post(
      callBack: callBack,
      path: '/user/upload/$folder/images',
      data: <String, dynamic>{
        'images': MultipartFile.fromBytes(
          List<int>.from(await file.readAsBytes()),
          contentType:
          http_parser.MediaType('image', path.extension(file.path)),
          filename: file.path,
        ),
      },
      encrypt: false,
    );

    if (response?.statusCode != 200) {
      return null;
    }

    final Map<String, dynamic>? data = response?.data;

    if (data?['code'] == 'FILE_UPLOADED') {
      logE(data?['file']);
      return data?['file'] as String?;
    } else {
      return null;
    }
  }

  /// Get with list dynamic
  static Future<Response<List<dynamic>?>> getWithListDynamic({
    required String path,
    required NetworkCallBackList callBack,
    Map<String, dynamic>? params,
    bool encrypt = true,
    String? forcedBaseUrl,
  }) async {
    try {
      final Response<List<dynamic>?> response = await _dio.get<List<dynamic>?>(
        (forcedBaseUrl ?? _baseUrl) + path,
        queryParameters: params,
        options: Options(
          headers: <String, dynamic>{
            'encrypt': encrypt,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Call the success callback if the response status code is 200 or 201
        callBack.onSuccess.call(response.data ?? <dynamic>[]);
      } else {
        logE(
          'Get with list dynamic error || ${response.data}',
        );
      }
      return response;
    } on DioError catch (e) {
      log('Dio error exception || $e');
      rethrow;
    }
  }

  /// Get with list dynamic
  static Future<Response<Map<String, dynamic>?>> getTapPayment({
    required String url,
    required String authorization,
    required NetworkCallBack callBack,
  }) async {
    try {
      final Response<Map<String, dynamic>?> response =
      await _dio.get<Map<String, dynamic>?>(
        url,
        options: Options(
          headers: <String, dynamic>{
            'Authorization': authorization,
            'accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Call the success callback if the response status code is 200 or 201
        callBack.onSuccess.call(response.data ?? {});
      } else {
        // Call the failure callback for other status codes
        callBack.onFailure.call(response.data ?? {});
      }
      return response;
    } on DioError catch (e) {
      logE('Dio error exception || $e');
      rethrow;
    }
  }

  /// Post tap payment
  static Future<Response<Map<String, dynamic>?>> postTapPayment({
    required NetworkCallBack callBack,
    required String url,
    required String authorization,
    Map<String, dynamic>? data,
  }) async {
    try {
      final Response<Map<String, dynamic>?> response =
      await _dio.post<Map<String, dynamic>?>(
        url,
        data: data,
        options: Options(
          headers: <String, dynamic>{
            'Authorization': authorization,
            'accept': 'application/json',
            'content-type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Call the success callback if the response status code is 200 or 201
        callBack.onSuccess.call(response.data!);
      } else {
        // Call the failure callback for other status codes
        callBack.onFailure.call(response.data!);
      }
      return response;
    } on DioError catch (e) {
      logE('Dio error exception || $e');
      rethrow;
    }
  }
}
