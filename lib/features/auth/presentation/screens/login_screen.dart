import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/theme/theme.dart';
import '../../../../core/data/services/key_value_storage_service_impl.dart';

import '../../../../core/presentation/widgets/widgets.dart';
import '../../../../core/utils/alerts.dart';
import '../../domain/repositories/auth_repository.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/login_form/login_form_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginFormBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
          keyValueStorageService: KeyValueStorageServiceImpl()),
      child: ScaffoldCustom(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();

    return BlocConsumer<LoginFormBloc, LoginFormState>(
      listenWhen: (previous, current) =>
          previous.formStatus != current.formStatus,
      listener: (context, state) {
        switch (state.formStatus) {
          case FormzSubmissionStatus.initial:
            break;
          case FormzSubmissionStatus.inProgress:
            break;
          case FormzSubmissionStatus.success:
            authBloc.add(OnLogin(AuthStatus.authenticated, state.user!));
            context.pushReplacement("/main/0");
            break;
          case FormzSubmissionStatus.failure:
            if (state.errorMessage.isNotEmpty) {
              AlertsManager.showSnackBarCustom(
                  context, SnackBarCustom.snackBarError(state.errorMessage));
            }

            break;
          case FormzSubmissionStatus.canceled:
            break;
        }
      },
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FlutterLogo(size: 130),
                  const SizedBox(height: 70),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormFieldCustom(
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
                        hinttext: 'Usuario',
                        errorText: state.isFormPosted
                            ? state.username.errorMessage
                            : null,
                        onChanged: (value) => context
                            .read<LoginFormBloc>()
                            .add(OnUsernameChange(value.trim())),
                      ),
                      const SizedBox(height: 20),
                      _TextFieldPassword(state: state),
                      const SizedBox(height: 20),
                      ElevatedButtonCustom(
                          isLoading: state.formStatus ==
                                  FormzSubmissionStatus.inProgress
                              ? true
                              : false,
                          label: 'Iniciar sesión',
                          action: () {
                            // AlertsManager.hideSnackBarCustom(context);
                            // context.read<LoginFormBloc>().add(OnSubmitted());
                            context.push('/main/0');
                          }),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '¿No tienes una cuenta?',
                            style: getRegularStyle(color: AppColors.grey600),
                          ),
                          TextButton(
                              onPressed: () {
                                context.push('/register');
                              },
                              child: Text('Registrar aquí',
                                  style: getMediumStyle(
                                      color: AppColors.primaryColor)))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TextFieldPassword extends StatefulWidget {
  const _TextFieldPassword({required this.state});
  final LoginFormState state;
  @override
  State<_TextFieldPassword> createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<_TextFieldPassword> {
  bool isObscured = true;
  @override
  Widget build(BuildContext context) {
    return TextFormFieldCustom(
        suffixIcon: _IconObscureText(
          onPressed: () {
            setState(() {
              isObscured = !isObscured;
            });
          },
          isObscured: isObscured,
        ),
        hinttext: 'Contraseña',
        errorText: widget.state.isFormPosted
            ? widget.state.password.errorMessage
            : null,
        onChanged: (value) =>
            context.read<LoginFormBloc>().add(OnPasswordChange(value.trim())),
        obscureText: isObscured);
  }
}

class _IconObscureText extends StatelessWidget {
  const _IconObscureText({required this.onPressed, required this.isObscured});
  final Function()? onPressed;
  final bool isObscured;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        splashColor: AppColors.transparent,
        highlightColor: AppColors.transparent,
        onPressed: onPressed,
        icon: Icon(
          isObscured
              ? FluentIcons.eye_off_16_regular
              : FluentIcons.eye_16_regular,
          size: 18,
        ));
  }
}
