import 'package:offline_first/features/auth/data/datasources/auth_datasource_impl.dart';
import 'package:offline_first/features/auth/domain/entities/user.dart';
import 'package:offline_first/features/auth/domain/repositories/auth_repository.dart';

import '../../domain/datasources/auth_datasource.dart';


class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl({AuthDatasource? datasource})
      : datasource = datasource ?? AuthDatasourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return datasource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String username, String password) {
    return datasource.login(username, password);
  }
}
