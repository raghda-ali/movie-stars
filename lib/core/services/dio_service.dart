import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_stars/core/constants/remote_urls.dart';

class DioService {
  final Dio dio;

  DioService({
    required this.dio,
  }) {
    dio
      ..options.baseUrl = RemoteUrls.baseUrl
      ..options.connectTimeout = const Duration(seconds: 15)
      ..options.receiveTimeout = const Duration(seconds: 15)
      ..options.responseType = ResponseType.json
      ..options.headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${RemoteUrls.token}',
        'lang': 'en',
      };
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (kDebugMode) {
        print(response);
      }
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('ERROR => $e');
      }
      rethrow;
    }
  }
}