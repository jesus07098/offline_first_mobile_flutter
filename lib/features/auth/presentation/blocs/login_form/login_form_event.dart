part of 'login_form_bloc.dart';

abstract class LoginFormEvent {
  const LoginFormEvent();
}

class OnUsernameChange extends LoginFormEvent {
  final String username;

  const OnUsernameChange(this.username);
}

class OnPasswordChange extends LoginFormEvent {
  final String password;

  const OnPasswordChange(this.password);
}

class OnSubmitted extends LoginFormEvent {}