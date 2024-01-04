// Clase que implementa la interfaz ApiService utilizando el patrón Singleton
import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';
import 'api_service.dart';

class DioApiService implements ApiService {
  static DioApiService? _instance;
  final String baseUrl = Environment.apiUrl;
  Dio dio = Dio();
  DioApiService._internal() {
    dio.options.baseUrl = baseUrl;
  }

  factory DioApiService() {
    _instance ??= DioApiService._internal();
    return _instance!;
  }

  @override
  Future<Response> get(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int p1, int p2)? onReceiveProgress}) async {
    try {
      return await dio.get(path,
          queryParameters: queryParameters,
          options: options,
          data: data,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
    } catch (error) {
      throw Exception("Error en la solicitud GET: $error");
    }
  }

  @override
  Future<Response> patch(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int p1, int p2)? onSendProgress,
      void Function(int p1, int p2)? onReceiveProgress}) async {
    try {
      return await dio.patch(path,
          data: data,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress);
    } catch (error) {
      throw Exception("Error en la solicitud PATCH: $error");
    }
  }

  @override
  Future<Response> post(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int p1, int p2)? onSendProgress,
      void Function(int p1, int p2)? onReceiveProgress}) async {
    try {
      return await dio.post(path,
          data: data,
          options: options,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress);
    } catch (error) {
      throw Exception("Error en la solicitud POST: $error");
    }
  }

  @override
  Future<Response> put(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int p1, int p2)? onSendProgress,
      void Function(int p1, int p2)? onReceiveProgress}) async {
    try {
      return await dio.put(path,
          data: data,
          options: options,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress);
    } catch (error) {
      throw Exception("Error en la solicitud POST: $error");
    }
  }
}
