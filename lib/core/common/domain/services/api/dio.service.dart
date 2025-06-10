import 'dart:developer';

import "package:dio/dio.dart";
import 'package:fpdart/fpdart.dart';

import '../../../../../config/constants/api/api.constants.dart';
import '../../../../../config/constants/gen/locale_keys.g.dart';
import '../../../../di/main.di.dart';
import '../../../data/models/error/app_error.model.dart';
import 'interceptor/connectivity_interceptor.dart';
import 'interceptor/dio_error_interceptor.dart';

class DioService {
  final Dio _dio = Dio();

  DioService() {
    _dio
      ..options.baseUrl = ApiConstants.baseAPIURL
      ..options.receiveTimeout = ApiConstants.receiveTimeout
      ..options.connectTimeout = ApiConstants.connectTimeout
      // Adding PrettyDioLogger for detailed logging of requests and responses.
      // Adding a custom error interceptor for enhanced error handling.
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(const ConnectivityInterceptor());

    // if (kDebugMode) {
    //   _dio.interceptors.add(MockerInterceptor());
    // }
  }

  // change the base URL
  void setBaseURL(String newBaseUrl) {
    _dio.options.baseUrl = newBaseUrl;
  }

  Dio get dio => _dio;
}

class ApiHandler {
  static Future<Either<AppErrorModel, T>> _call<T>(
    Future<Response<Map<String, dynamic>>> Function() apiCall, {
    required Future<T> Function(Map<String, dynamic>) onSuccess,
    AppErrorModel Function(Map<String, dynamic>)? onError,
    AppErrorModel defaultErrorMessage = const AppErrorModel(
      message: LocaleKeys.common_errors_somethingWentWrong,
    ),
    int? successCode = 200,
    String? successMessage = "OK",
  }) async {
    try {
      final response = await apiCall();
      if (response.statusCode == successCode ||
          response.statusMessage == "OK") {
        if (response.data == null) {
          return const Left(
            AppErrorModel(message: LocaleKeys.common_errors_somethingWentWrong),
          );
        }
        return Right(await onSuccess.call(response.data ?? {}));
      } else {
        return Left(onError?.call(response.data ?? {}) ?? defaultErrorMessage);
      }
    } on DioException catch (e) {
      log(e.toString(), name: 'ApiHandler-DioException');
      onError?.call(e.response?.data ?? {});
      return Left(AppErrorModel.fromDioException(e));
    } catch (e) {
      log(e.toString(), name: 'ApiHandler-Exception');
      onError?.call({'message': e.toString()});
      return Left(AppErrorModel(message: e.toString()));
    }
  }

  static Future<Either<AppErrorModel, T>> get<T>({
    required String url,
    Map<String, dynamic>? queryParams,
    required Future<T> Function(Map<String, dynamic>) onSuccess,
    AppErrorModel Function(Map<String, dynamic>)? onError,
    AppErrorModel defaultErrorMessage = const AppErrorModel(
      message: LocaleKeys.common_errors_somethingWentWrong,
    ),
    int? successCode = 200,
    String? successMessage = "OK",
  }) async {
    return _call<T>(
      () => sl<DioService>().dio.get(url, queryParameters: queryParams),
      onSuccess: onSuccess,
      defaultErrorMessage: defaultErrorMessage,
      onError: onError,
      successCode: successCode,
      successMessage: successMessage,
    );
  }

  static Future<Either<AppErrorModel, T>> post<T>({
    required String url,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    required Future<T> Function(Map<String, dynamic>) onSuccess,
    AppErrorModel Function(Map<String, dynamic>)? onError,
    AppErrorModel defaultErrorMessage = const AppErrorModel(
      message: LocaleKeys.common_errors_somethingWentWrong,
    ),
    int? successCode = 201,
    String? successMessage = "OK",
  }) async {
    return _call<T>(
      () => sl<DioService>().dio.post(
        url,
        queryParameters: queryParams,
        data: data,
      ),
      onSuccess: onSuccess,
      defaultErrorMessage: defaultErrorMessage,
      onError: onError,
      successCode: successCode,
      successMessage: successMessage,
    );
  }

  static Future<Either<AppErrorModel, T>> put<T>({
    required String url,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    required Future<T> Function(Map<String, dynamic>) onSuccess,
    AppErrorModel Function(Map<String, dynamic>)? onError,
    AppErrorModel defaultErrorMessage = const AppErrorModel(
      message: LocaleKeys.common_errors_somethingWentWrong,
    ),
    int? successCode = 200,
    String? successMessage = "OK",
  }) async {
    return _call<T>(
      () => sl<DioService>().dio.put(
        url,
        queryParameters: queryParams,
        data: data,
      ),
      onSuccess: onSuccess,
      defaultErrorMessage: defaultErrorMessage,
      onError: onError,
      successCode: successCode,
      successMessage: successMessage,
    );
  }

  static Future<Either<AppErrorModel, T>> delete<T>({
    required String url,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    required Future<T> Function(Map<String, dynamic>) onSuccess,
    AppErrorModel Function(Map<String, dynamic>)? onError,
    AppErrorModel defaultErrorMessage = const AppErrorModel(
      message: LocaleKeys.common_errors_somethingWentWrong,
    ),
    int? successCode = 200,
    String? successMessage = "OK",
  }) async {
    return _call<T>(
      () => sl<DioService>().dio.delete(
        url,
        queryParameters: queryParams,
        data: data,
      ),
      onSuccess: onSuccess,
      defaultErrorMessage: defaultErrorMessage,
      onError: onError,
      successCode: successCode,
      successMessage: successMessage,
    );
  }
}
