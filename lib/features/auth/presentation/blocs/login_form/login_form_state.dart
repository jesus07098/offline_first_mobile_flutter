part of 'login_form_bloc.dart';

class LoginFormState extends Equatable {
  final Username username;
  final Password password;
  final FormzSubmissionStatus formStatus;
  final bool isFormPosted;
  final bool isValid;
  final User? user;
  final String errorMessage;
  const LoginFormState({
    this.formStatus = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.isFormPosted = false,
    this.user,
       this.errorMessage = ''
  });

  LoginFormState copyWith(
      {FormzSubmissionStatus? formStatus,
      Username? username,
      Password? password,
      bool? isValid,
      bool? isFormPosted,
      User? user,
      String? errorMessage
      }) {
    return LoginFormState(
        username: username ?? this.username,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus,
        isValid: isValid ?? this.isValid,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props =>
      [username, password, formStatus, isValid, isFormPosted, user, errorMessage];

  @override
  String toString() => ''''{ formStatus: $formStatus, 
      username: $username,
      password: $password,
      isValid: $isValid,
       isFormPosted: $isFormPosted,
       user: $user,
       errorMessage: $errorMessage
      }''';
}
