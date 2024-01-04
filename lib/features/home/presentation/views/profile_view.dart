import 'package:offline_first/core/config/theme/app_fonts.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/presentation/blocs/bottomNavBloc/bottom_nav_bloc.dart';
import '../../../../core/presentation/blocs/network/network_bloc.dart';
import '../../../auth/presentation/blocs/auth/auth_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final bottomNavBloc = context.watch<BottomNavBloc>();
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.grey300,
            child: Icon(FluentIcons.person_20_regular, size: 40),
          ),
          const SizedBox(height: 10),
          Text(
              state.user == null
                  ? ''
                  : ' ${state.user!.data.user.merchant.name}',
              style: getMediumStyle(fontSize: FontSize.s16)),
          const SizedBox(height: 10),
          BlocBuilder<NetworkBloc, NetworkState>(
            builder: (context, state) {
              return ListTile(
                  leading: const Icon(FluentIcons.power_24_regular, size: 20),
                  title: Text(
                    'Cerrar sesión',
                    style: getRegularStyle(
                        fontSize: FontSize.s14,
                        color: state.isConnected
                            ? AppColors.black
                            : AppColors.grey300),
                  ),
                  onTap: state.isConnected
                      ? () {
                          context.read<AuthBloc>().add(const OnLogout());
                          context.pushReplacement('/login');
                             bottomNavBloc.add(const OnTabChange(0));
                        }
                      : null);
            },
          )
        ]);
      },
    );
  }
}
