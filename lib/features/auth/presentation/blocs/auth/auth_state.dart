part of 'auth_bloc.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final String errorMessage;
  final User? user;
  final String? token;
  const AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = '',
      this.token
      });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
    String? token
  }) {
    return AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
        token: token ?? this.token
        );
  }

  @override
  List<Object?> get props => [authStatus, user, errorMessage, token];
}
