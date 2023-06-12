import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/src/helpers/PrefManager.dart';
import 'package:ecommerce_app/src/models/base_model.dart';
import 'package:ecommerce_app/src/repositories/app_repo.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/AppKeys.dart';
import '../constants/constants_colors.dart';
import '../helpers/utils.dart';

class AppConfig {
  //static String baseUrl = "";
  static String baseUrlProduction = "https://keunepakistan.com/store/app/api/";
  //static String baseUrlProduction = "http://182.185.238.112:9999/api/";

  static final String route = "api/";
}

enum HttpMethod { Get, Post, Put, Patch, Delete }

class NetworkManager {
  List<Cookie> cookies = [];
  static final NetworkManager _singleton = NetworkManager._internal();
  factory NetworkManager() {
    return _singleton;
  }
  NetworkManager._internal();

  Dio dio = Dio();
  void setDioOptions() {
    dio.options.contentType = Headers.jsonContentType;
  }

  Future<Response?> callApi({
    required HttpMethod method,
    required String? urlEndPoint,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    dynamic body,
    bool isProgressing = true,
    bool isFormDataRequest = false,
    FormData? formData,
    bool isLoading = true,
    bool isGetCookie = false,
  }) async {
    this.setDioOptions();

    dio.interceptors
      ..add(LogInterceptor(requestBody: true, responseBody: true));
    var requestURL;
    requestURL = AppConfig.baseUrlProduction + urlEndPoint!;
    /* if (isFormDataRequest) {
      dio.options.headers = {
        "Content-Type": "multipart/form-data",

        //'Cookie': 'XDEBUG_SESSION=PHPSTORM'
      };
    } */
    /*  String headerKey =
        await getx.Get.find<PrefManager>().read(AppKeys.HEADER_KEY);
    if (headerKey != null) {
      dio.options.headers = {
        'Authorization': headerKey,

        //'Cookie': 'XDEBUG_SESSION=PHPSTORM'
      };
    } */
    /* dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError e, handler) async {
          //  if (e.isConnectionError()) {
         // Utils.hideLoader();
          EasyLoading.dismiss();

          getx.Get.snackbar(
            
              'Network Error', 'Please check your network connection',
              snackPosition: getx.SnackPosition.TOP,
              colorText: Colors.white,
              backgroundColor: ConstantColor.primaryColorRed);
          // globalBloc.showConnectionErrorSnackBar();
          /*   return handler.next(e);
          } */

          return handler.next(e);
        },
      ),
    ); */
    /*  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    }; */
    String? token = await PrefManager().read(AppKeys.token);
    dio.options.headers = {
      'token': 'eyJpdiI6Iklja2NJNEJEeTRYcGtPTjdDcmxSTkE9PSIsInZhbHVlIjoieHhFdGpiaVoyaUV1M2lBNnRPbWNyczNvZnhlbjExd2NPUUtkKzlZcWRJcz0iLCJtYWMiOiI4NTFkNDViMjZjYzVlZjkzMjI5YTg4M2RkZjRjZmZhNmIyYmQ1MDRiNmM4MTE1NzZmMDE1NGVmYzUwMmI3Y2Q0IiwidGFnIjoiIn0=',

      //'Cookie': 'XDEBUG_SESSION=PHPSTORM'
    };
    Response? response;
    try {
      if (isLoading) {
        /// Utils.showLoader();
        EasyLoading.show();
      }
      switch (method) {
        case HttpMethod.Get:
          response = await dio.get(
            requestURL,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case HttpMethod.Post:
          response = await dio.post(
            requestURL,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
            data: isFormDataRequest ? formData : body,
          );
          break;
        case HttpMethod.Put:
          response = await dio.put(
            requestURL,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
            data: body,
          );
          break;
        case HttpMethod.Patch:
          break;
        case HttpMethod.Delete:
          response = await dio.delete(requestURL, data: body);
          break;
      }
      EasyLoading.dismiss();
      //Utils.hideLoader();
      // EasyLoading.dismiss();

      if (response?.statusCode == 200) {
        return response;
      } else {
        BaseModel baseModel = BaseModel.fromJson(response!.data);
        Fluttertoast.showToast(
            msg: baseModel.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return response;
      }
    } on DioError catch (errorResponse) {
      //Utils.hideLoader();
      EasyLoading.dismiss();

      BaseModel baseModel = BaseModel.fromMap(errorResponse.response?.data);
      Fluttertoast.showToast(
          msg: baseModel.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return errorResponse.response;
      //EasyLoading.dismiss();
      // Map<String, dynamic> errorResponse = error.response.data;
      /*  if (error.response.statusCode == 401) {
        //  Fluttertoast.showToast(msg: 'Please entter a valid code');
      } */

      /*  Response errResponse =
          Response(data: errorResponse, statusCode: error.response.statusCode); */
      //return error.response;
      // throw ApiException(error);
    }
  }
}

extension ErrorHandling on DioError {
  /// [false] for connection errors etc
  /// [true] for anything with a status code -- proper HTTP API errors
  bool isHttpError() {
    // return this.response.statusCode != null;
    return this.type == DioErrorType.response;
  }

  bool isConnectionError() {
    if (this.type == DioErrorType.other &&
        this.response == null &&
        this.error == null) {
      return true;
    }
    // Triggers for connection refused
    if (this.type == DioErrorType.other && this.error is SocketException)
      return true;
    // This can happen because we grab Firebase token inside a Dio listener

    return [
      DioErrorType.sendTimeout,
      DioErrorType.receiveTimeout,
      DioErrorType.connectTimeout,

      // Can happen when connection is off, DNS errors
      // Note we're assuming it's a connection error, it's probably true
      // Still, might want to behave differently in some cases if connection is off
      // A list so far:
      // - HttpException, uri = ..
      // - SocketException: OS Error: Connection refused
      // - HandshakeException: Connection terminated during handshake
      DioErrorType.other,
    ].contains(this.type);
  }

  bool isRequestSent() {
    return ![
      DioErrorType.other,
      DioErrorType.connectTimeout,
      DioErrorType.sendTimeout
    ].contains(this.type);
  }
}
