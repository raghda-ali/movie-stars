import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_stars/core/constants/remote_urls.dart';

class DioService {
  final Dio dio;

  DioService({required this.dio}) {
    dio.options
      ..baseUrl = RemoteUrls.baseUrl
      ..connectTimeout = const Duration(seconds: 15)
      ..receiveTimeout = const Duration(seconds: 15)
      ..responseType = ResponseType.json;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Accept'] = 'application/json';
          options.headers['Authorization'] = 'Bearer ${RemoteUrls.token}';
          if (kDebugMode) {
            print('Sending request to: ${options.uri}');
            print('Headers: ${options.headers}');
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          if (kDebugMode) {
            print('Dio error: ${e.response?.statusCode} => ${e.response?.data}');
          }
          return handler.next(e);
        },
      ),
    );
    // if (kDebugMode) {
    //   dio.interceptors.add(
    //     PrettyDioLogger(
    //       enabled: true,
    //       requestHeader: true,
    //       requestBody: true,
    //       responseBody: true,
    //       responseHeader: false,
    //       error: true,
    //       compact: true,
    //     ),
    //   );
    // }
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
