import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/blocs/bottomNavBloc/bottom_nav_bloc.dart';
import '../blocs/auth/auth_bloc.dart';

class CheckAuthStatusScreen extends StatefulWidget {
  const CheckAuthStatusScreen({super.key});

  @override
  State<CheckAuthStatusScreen> createState() => _CheckAuthStatusScreenState();
}

class _CheckAuthStatusScreenState extends State<CheckAuthStatusScreen> {
  @override
  void initState()  {
    super.initState();
    context.read<AuthBloc>().add(const OnCheckAuthStatus());
  }

  @override
  Widget build(BuildContext context) {
     final bottomNavBloc = context.watch<BottomNavBloc>();
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) =>
              previous.authStatus != current.authStatus,
          listener: (context, state) {
            switch (state.authStatus) {
              case AuthStatus.checking:
                break;
              case AuthStatus.notAuthenticated:
                context.pushReplacement('/login');
                break;
              case AuthStatus.authenticated:
                context.pushReplacement('/main/${bottomNavBloc.state.index}');
                break;
              default:
                break;
            }
          },
          child: const Center(child: CircularProgressIndicator())),
    );
  }
}
