import 'package:dio/dio.dart';

import '../../../../core/data/services/api_service_impl.dart';
import '../../domain/datasources/auth_datasource.dart';
import '../../domain/entities/user.dart';
import '../errors/auth_errors.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final apiService = DioApiService();
  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await apiService.get('/auth/user',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      final user = User.fromJson(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError('Token inválido');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> login(String username, String password) async {
    try {
      final response = await apiService.post('/auth/login',
          data: {'username': username, 'password': password});

      final user = User.fromJson(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw CustomError(
            e.response?.data['message'] ?? ' Credenciales incorrectas');
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
