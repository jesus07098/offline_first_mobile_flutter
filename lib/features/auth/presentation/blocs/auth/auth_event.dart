part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class OnLogin extends AuthEvent {
  final User user;
  final AuthStatus authStatus;

  const OnLogin(this.authStatus, this.user);
}

class OnLogout extends AuthEvent {
  const OnLogout();
}

class OnCheckAuthStatus extends AuthEvent {
  final User? user;
  final String? errorMessage;
  const OnCheckAuthStatus({this.user, this.errorMessage});
}
