import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/theme/app_fonts.dart';
import '../../../../core/presentation/blocs/bottomNavBloc/bottom_nav_bloc.dart';

class AppBarMain extends StatelessWidget implements PreferredSizeWidget {
  const AppBarMain({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: _TitleAppBar(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TitleAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomNavBloc = context.watch<BottomNavBloc>();
    return IndexedStack(
      alignment: Alignment.centerLeft,
      index: bottomNavBloc.state.index,
      children: [
        Image.asset(
          'assets/images/sanel_logo.png',
          width: 140,
          height: 60,
        ),
        const _Text('Incidencias'),
         const _Text('Menú principal'),
        const _Text('Tareas'),
        const _Text('Mi perfil'),
      ],
    );
  }
}

class _Text extends StatelessWidget {
  const _Text(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: getMediumStyle(fontSize: FontSize.s16));
  }
}
