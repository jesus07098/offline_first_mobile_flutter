import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'core/config/constants/environment.dart';
import 'core/config/router/app_router.dart';
import 'core/config/theme/app_theme.dart';
import 'core/data/repositories/local/vehicle_local_repository_impl.dart';
import 'core/data/services/key_value_storage_service_impl.dart';
import 'core/data/services/local_db_impl.dart';
import 'core/domain/repositories/local/vehicle_local_repository.dart';
import 'core/presentation/blocs/bottomNavBloc/bottom_nav_bloc.dart';
import 'core/presentation/blocs/network/network_bloc.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'features/auth/presentation/blocs/login_form/login_form_bloc.dart';
import 'features/webviews/presentation/controllers/printer_provider.dart';
import 'features/webviews/presentation/controllers/scanner_bloc/scanner_bloc.dart';

void main() async {
  await Environment.initEnvironment();
  await IsarDbImpl().initDb();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<AuthRepository>(
        create: (context) => AuthRepositoryImpl(),
      ),
      RepositoryProvider<VehicleLocalRepository>(
          create: (context) => VehicleLocalRepositoryImpl()),
    ],
    child: MultiBlocProvider(providers: [
      BlocProvider(
          lazy: false,
          create: (_) => LoginFormBloc(
              authRepository: AuthRepositoryImpl(),
              keyValueStorageService: KeyValueStorageServiceImpl())),
      BlocProvider(lazy: false, create: (_) => BottomNavBloc()),
      BlocProvider(create: (_) => ScannerBloc()),
      BlocProvider(create: (_) => NetworkBloc()..add(NetworkObserve())),
      BlocProvider(
          create: (_) => AuthBloc(
              authRepository: AuthRepositoryImpl(),
              keyValueStorageService: KeyValueStorageServiceImpl())),
    ], child: const MainApp()),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(create: (_) => PrinterProvider()),
      ],
      child: MaterialApp.router(
        builder: FToastBuilder(),
        debugShowCheckedModeBanner: false,
        title: 'Sanel Fleet',
        theme: AppTheme().getTheme(),
        routerConfig: Routers.appRouter,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US')
        ],
      ),
    );
  }
}
