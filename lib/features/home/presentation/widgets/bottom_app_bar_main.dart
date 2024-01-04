import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_fonts.dart';
import '../../../../core/presentation/blocs/bottomNavBloc/bottom_nav_bloc.dart';

class BottomAppBarMain extends StatelessWidget {
  const BottomAppBarMain({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavBloc = context.watch<BottomNavBloc>();
    return BottomAppBar(
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 12),
      notchMargin: 12,
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _Tab(
              icon: bottomNavBloc.state.index == 0
                  ? FluentIcons.home_20_filled
                  : FluentIcons.home_20_regular,
              iconColor: bottomNavBloc.state.index == 0
                  ? AppColors.primaryColor
                  : AppColors.grey600,
              onPressed: () {
                bottomNavBloc.add(const OnTabChange(0));
                context.go('/main/0');
              },
              label: 'Principal',
            ),
            _Tab(
              icon: bottomNavBloc.state.index == 1
                  ? FluentIcons.error_circle_20_filled
                  : FluentIcons.error_circle_20_regular,
              iconColor: bottomNavBloc.state.index == 1
                  ? AppColors.primaryColor
                  : AppColors.grey600,
              onPressed: () {
                bottomNavBloc.add(const OnTabChange(1));

                context.go('/main/1');
              },
              label: 'Incidencias',
            ),
            const SizedBox.shrink(),
            _Tab(
              icon: bottomNavBloc.state.index == 3
                  ? FluentIcons.clipboard_task_list_ltr_20_filled
                  : FluentIcons.clipboard_task_list_ltr_20_regular,
              iconColor: bottomNavBloc.state.index == 3
                  ? AppColors.primaryColor
                  : AppColors.grey600,
              onPressed: () {
                bottomNavBloc.add(const OnTabChange(3));
                context.go('/main/3');
              },
              label: 'Tareas',
            ),
            _Tab(
              icon: bottomNavBloc.state.index == 4
                  ? FluentIcons.person_20_regular
                  : FluentIcons.person_20_regular,
              iconColor: bottomNavBloc.state.index == 4
                  ? AppColors.primaryColor
                  : AppColors.grey600,
              onPressed: () {
                bottomNavBloc.add(const OnTabChange(4));
                context.go('/main/4');
              },
              label: 'Perfil',
            )
          ],
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab(
      {required this.icon,
      required this.onPressed,
      required this.iconColor,
      required this.label});

  final IconData icon;
  final void Function()? onPressed;
  final Color iconColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      onPressed: onPressed,
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 26,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: getMediumStyle(color: iconColor, fontSize: FontSize.s10),
          )
        ],
      ),
    );
  }
}
