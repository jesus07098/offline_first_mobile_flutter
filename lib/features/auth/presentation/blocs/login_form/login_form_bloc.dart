import 'package:equatable/equatable.dart';
import 'package:offline_first/core/data/services/key_value_storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../core/presentation/inputs/inputs.dart';
import '../../../data/errors/auth_errors.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc(
      {required AuthRepository authRepository,
      required KeyValueStorageService keyValueStorageService})
      : _authRepository = authRepository,
        _keyValueStorageService = keyValueStorageService,
        super(const LoginFormState()) {
    on<OnUsernameChange>(_onUsernameChange);
    on<OnPasswordChange>(_onPasswordChange);
    on<OnSubmitted>(_onSubmitted);
  }
  final AuthRepository _authRepository;
  final KeyValueStorageService _keyValueStorageService;

  Future<void> _onSubmitted(
      OnSubmitted event, Emitter<LoginFormState> emit) async {
    final username = Username.dirty(state.username.value);
    final password = Password.dirty(state.password.value);

    emit(state.copyWith(
        formStatus: FormzSubmissionStatus.inProgress,
        isFormPosted: true,
        username: username,
        password: password,
        isValid: Formz.validate([password, username])));
    if (!state.isValid) {
      emit(state.copyWith(
          user: null, formStatus: FormzSubmissionStatus.failure));
      return;
    }
    try {
      final user = await _authRepository.login(
          state.username.value, state.password.value);
      await _keyValueStorageService.setKeyValue('token', user.token);
      await _keyValueStorageService.setKeyValue('userId', user.data.user.id);
      emit(state.copyWith(
        user: user,
        formStatus: FormzSubmissionStatus.success,
        username: const Username.pure(),
        password: const Password.pure(),
      ));
    } on CustomError catch (e) {
      await _keyValueStorageService.removeKey('token');
      emit(state.copyWith(
          user: null,
          formStatus: FormzSubmissionStatus.failure,
          errorMessage: e.message));
    } catch (e) {
      await _keyValueStorageService.removeKey('token');
      emit(state.copyWith(
          user: null,
          formStatus: FormzSubmissionStatus.failure,
          errorMessage: 'Valide los datos suministrados'));
    }
  }

  void _onUsernameChange(
    OnUsernameChange event,
    Emitter<LoginFormState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
        username: username,
        isValid: Formz.validate([
          username,
          state.password,
        ])));
  }

  void _onPasswordChange(
    OnPasswordChange event,
    Emitter<LoginFormState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.username])));
  }
}
