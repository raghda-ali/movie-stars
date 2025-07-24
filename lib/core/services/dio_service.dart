// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:movie_stars/core/constants/remote_urls.dart';
//
// class DioService {
//   final Dio dio;
//
//   DioService({
//     required this.dio,
//   }) {
//     print('Bearer token is: ${RemoteUrls.token}');
//
//     dio
//       ..options.baseUrl = RemoteUrls.baseUrl
//       ..options.connectTimeout = const Duration(seconds: 15)
//       ..options.receiveTimeout = const Duration(seconds: 15)
//       ..options.responseType = ResponseType.json
//       ..options.headers = {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${RemoteUrls.token}',
//         // 'lang': 'en',
//       };
//     dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) {
//           options.headers = {
//             'Accept': 'application/json',
//             'Authorization': 'Bearer ${RemoteUrls.token}',
//           };
//           return handler.next(options);
//         },
//       ),
//     );
//   }
//
//   Future<Response> get({
//     required String url,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     try {
//       final Response response = await dio.get(
//         url,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onReceiveProgress: onReceiveProgress,
//       );
//       if (kDebugMode) {
//         print(response);
//       }
//       return response;
//     } catch (e) {
//       if (kDebugMode) {
//         print('ERROR => $e');
//       }
//       rethrow;
//     }
//   }
// }

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
