import 'package:equatable/equatable.dart';
import 'package:offline_first/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/services/key_value_storage_service.dart';
import '../../../domain/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required KeyValueStorageService keyValueStorageService,
    required AuthRepository authRepository,
  })  : _keyValueStorageService = keyValueStorageService,
        _authRepository = authRepository,
        super(const AuthState()) {
    on<OnLogin>(_onLogin);
    on<OnLogout>(_onLogout);
    on<OnCheckAuthStatus>(_onCheckAuthStatus);
  }
  final KeyValueStorageService _keyValueStorageService;
  final AuthRepository _authRepository;

  _onCheckAuthStatus(OnCheckAuthStatus event, Emitter<AuthState> emit) async {
    final token = await _keyValueStorageService.getValue<String>('token');
    emit(state.copyWith(token: token));
    if (token == null) {
      // await _keyValueStorageService.removeKey('token');
      return emit(state.copyWith(
          authStatus: AuthStatus.notAuthenticated,
          user: null,
          errorMessage: event.errorMessage,
          token: null));
    }
    try {
  
        final user = await _authRepository.checkAuthStatus(token);
        // await _keyValueStorageService.setKeyValue('token', user.token);
        emit(state.copyWith(
            authStatus: AuthStatus.authenticated, user: user, token: token));
      
    } catch (e) {
      // await _keyValueStorageService.removeKey('token');
      emit(state.copyWith(
          authStatus: AuthStatus.notAuthenticated,
          user: null,
          errorMessage: event.errorMessage,
          token: null));
    }
  }

  Future<void> _onLogin(OnLogin event, Emitter<AuthState> emit) async {
    final token = await _keyValueStorageService.getValue<String>('token');
    emit(state.copyWith(
        user: event.user,
        authStatus: AuthStatus.authenticated,
        errorMessage: '',
        token: token));
  }

  _onLogout(
    OnLogout event,
    Emitter<AuthState> emit,
  ) async {
    _keyValueStorageService.removeKey('token');
    emit(state.copyWith(
        user: null, authStatus: AuthStatus.notAuthenticated, token: null));
  }
}
