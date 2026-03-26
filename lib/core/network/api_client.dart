import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../storage/local_storage.dart';

/// Dio-based API client with auth interceptor and college header injection.
class ApiClient {
  late final Dio _dio;
  final LocalStorage _storage;

  ApiClient({required LocalStorage storage}) : _storage = storage {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.getString('auth_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          final collegeId = await _storage.getString('selected_college');
          if (collegeId != null && collegeId != 'all') {
            options.headers['X-College-Id'] = collegeId;
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // Token expired — attempt refresh
            try {
              final refreshToken =
                  await _storage.getString('refresh_token');
              if (refreshToken != null) {
                final response = await Dio().post(
                  '${ApiConstants.baseUrl}${ApiConstants.refreshToken}',
                  data: {'refresh_token': refreshToken},
                );
                final newToken = response.data['access_token'] as String;
                await _storage.setString('auth_token', newToken);

                // Retry original request
                error.requestOptions.headers['Authorization'] =
                    'Bearer $newToken';
                final retryResponse =
                    await _dio.fetch(error.requestOptions);
                return handler.resolve(retryResponse);
              }
            } catch (_) {
              await _storage.clear();
            }
          }
          handler.next(error);
        },
      ),
    );
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.get<T>(path, queryParameters: queryParameters);
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.post<T>(path, data: data, queryParameters: queryParameters);
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.put<T>(path, data: data, queryParameters: queryParameters);
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.patch<T>(path, data: data, queryParameters: queryParameters);
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.delete<T>(path, data: data, queryParameters: queryParameters);
  }
}
