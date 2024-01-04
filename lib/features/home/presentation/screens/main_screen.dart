import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:offline_first/features/home/presentation/views/incidents_view.dart';
import 'package:offline_first/features/home/presentation/views/views.dart';
import 'package:offline_first/features/home/presentation/views/profile_view.dart';
import 'package:offline_first/features/home/presentation/views/task_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/data/repositories/local/entity_local_repository_impl.dart';
import '../../../../core/data/repositories/local/vehicle_local_repository_impl.dart';
import '../../../../core/data/repositories/remote/entity_remote_repository_impl.dart';
import '../../../../core/data/repositories/remote/vehicle_remote_repository_impl.dart';
import '../../../../core/presentation/blocs/bottomNavBloc/bottom_nav_bloc.dart';
import '../../../../core/presentation/blocs/entities/entities_bloc.dart';
import '../../../../core/presentation/blocs/vehicles/vehicles_bloc.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../incidents/data/repositories/local/incident_local_repository_impl.dart';
import '../../../incidents/data/repositories/remote/incident_remote_repository_impl.dart';

import '../../../incidents/presentation/blocs/type_incidents/type_incidents_bloc.dart';
import '../widgets/widgets.dart';
import '../../../webviews/presentation/views/main_menu_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.pageIndex});
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
        
      BlocProvider(
          create: (_) => EntitiesBloc(
              entityLocalRepository: EntityLocalRepositoryImpl(),
              entityRemoteRepository: EntityRemoteRepositoryImpl())),
      BlocProvider(
          create: (_) => VehiclesBloc(
              vehicleLocalRepository: VehicleLocalRepositoryImpl(),
              vehicleRemoteRepository: VehicleRemoteRepositoryImpl())),
      BlocProvider(
          create: (_) => TypesIncidentsBloc(
              incidentLocalRepository: IncidentLocalRepositoryImpl(),
              incidentRemoteRepository: IncidentRemoteRepositoryImpl())),
    ], child: _Scaffold(pageIndex: pageIndex));
  }
}

class _Scaffold extends StatefulWidget {
  const _Scaffold({required this.pageIndex});
  final int pageIndex;
  @override
  State<_Scaffold> createState() => _ScaffoldState();
}

class _ScaffoldState extends State<_Scaffold> {
  @override
  void initState() {
    context.read<VehiclesBloc>().add(OnSaveVehicles());
    context.read<EntitiesBloc>().add(OnSaveEmployees());
    context.read<TypesIncidentsBloc>().add(OnSaveTypesIncidents());

    super.initState();
  }

  final viewRoutes = const [
    HomeView(),
    IncidentsView(),
    MainMenuView(),
    TaskView(),
    ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavBloc = context.watch<BottomNavBloc>();

    return ScaffoldCustom(
        isWebview: bottomNavBloc.state.index == 2 ? true : false,
        appBar: const AppBarMain(),
        bottomNavigationBar: const BottomAppBarMain(),
        body: viewRoutes[widget.pageIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _FloatingActionButtonMain(onPressed: () {
          bottomNavBloc.add(const OnTabChange(2));
          context.go('/main/2');
        }));
  }
}

class _FloatingActionButtonMain extends StatelessWidget {
  const _FloatingActionButtonMain({required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: onPressed,
        elevation: 0.0,
        child: const Icon(
          FluentIcons.grid_20_filled,
          color: AppColors.primaryColor,
        ));
  }
}
