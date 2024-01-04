import 'package:offline_first/features/auth/presentation/screens/check_auth_status_screen.dart';
import 'package:offline_first/features/incidents/presentation/screens/documents_screen.dart';
import 'package:offline_first/features/webviews/presentation/screens/camera_screen.dart';
import 'package:offline_first/features/webviews/presentation/screens/detail_menu_screen.dart';
import 'package:offline_first/features/webviews/presentation/screens/printers_list_screen.dart';
import 'package:offline_first/features/webviews/presentation/screens/scanner_qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:offline_first/features/incidents/presentation/screens/incident_form_screen.dart';
import 'package:offline_first/features/tasks/presentation/screen/task_form_screen.dart';

import '../../../features/auth/presentation/screens/login_screen.dart';
import '../../../features/auth/presentation/screens/register_screen.dart';
import '../../../features/incidents/presentation/screens/audios_screen.dart';
import '../../../features/incidents/presentation/screens/incident_details_screen.dart';
import '../../../features/incidents/presentation/screens/photos_screen.dart';
import '../../../features/inspection/presentation/screens/screens.dart';
import '../../../features/webviews/presentation/views/main_menu_view.dart';
import '../../../features/home/presentation/screens/main_screen.dart';
import '../../../features/webviews/presentation/screens/no_internet_screen.dart';
import '../../../features/home/presentation/screens/scanner_screen.dart';
import '../../../features/tasks/presentation/screen/task_list_screen.dart';

class Routers {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static bool isSameScreen(String route) {
    final navigatorKey = Routers.navigatorKey;
    final screens = (navigatorKey.currentWidget as Navigator?)?.pages;
    final screen = (screens?.last as Widget).toString();
    return (screen == route);
  }

  static final appRouter = GoRouter(
      navigatorKey: Routers.navigatorKey,
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const CheckAuthStatusScreen(),
        ),
        GoRoute(
            path: '/login', builder: (context, state) => const LoginScreen()),
        GoRoute(
            path: '/register',
            builder: (context, state) => const RegisterScreen()),
        GoRoute(
            path: '/scanner',
            name: 'scanner',
            builder: (context, state) => const ScannerScreen()),
        GoRoute(
          path: '/task-form',
          name: 'task-form',
          builder: (context, state) => const TaskFormScreen(),
        ),
        GoRoute(
            path: '/photos',
            name: 'photos',
            builder: (context, state) => PhotosScreen(
                  incidentContext: (state.extra as Map)['context'],
                  recordId: (state.extra as Map)['id'],
                )),
        GoRoute(
            path: '/documents',
            name: 'documents',
            builder: (context, state) => DocumentsScreen(
                  incidentContext: (state.extra as Map)['context'],
                  recordId: (state.extra as Map)['id'],
                )),
        GoRoute(
            name: 'audios',
            path: '/audios',
            builder: (context, state) => AudiosScreen(
                  incidentContext: (state.extra as Map)['context'],
                  recordId: (state.extra as Map)['id'],
                )),
        GoRoute(
            path: '/incident-form/:id',
            name: 'incident-form',
            builder: (context, state) {
              return IncidentFormScreen(
                incident: (state.extra as Map)['incident'],
              );
            }),
        GoRoute(
            path: '/printer-list',
            name: 'printer-list',
            builder: (context, state) => const PrintersListScreen()),
        GoRoute(
            path: '/no-internet',
            name: 'no-internet',
            builder: (context, state) => const NoInternetScreen()),
        GoRoute(
            path: '/camera',
            name: 'camera',
            builder: (context, state) => CameraScreen(
                  webController: (state.extra as Map)['webController'],
                  cameraType: (state.extra as Map)['cameraType'],
                )),
        GoRoute(
            path: '/scannerQr',
            name: 'scannerQr',
            builder: (context, state) => ScannerQrScreen(
                  backButton: (state.extra as Map)['backButton'],
                  webController: (state.extra as Map)['webController'],
                  scannerType: (state.extra as Map)['scannerType'],
                  companyToken: (state.extra as Map)['companyToken'],
                )),
        GoRoute(
            path: '/detail-menu',
            name: 'detail-menu',
            builder: (context, state) {
              return DetailMenuScreen(
                url: (state.extra as Map)['url'],
              );
            }),
        GoRoute(
          path: '/main/:view',
          name: 'main',
          builder: (context, state) {
            final pageIndex = int.parse(state.pathParameters['view'] ?? '0');
            return MainScreen(pageIndex: pageIndex);
          },
          routes: [
            GoRoute(
              path: 'incident-details/:incidentId',
              builder: (context, state) => IncidentsDetailsScreen(
                  incidentId: state.pathParameters['incidentId'] ?? 'no-id'),
            ),
            GoRoute(
                path: 'main-menu',
                name: 'main-menu',
                builder: (context, state) => const MainMenuView()),
            GoRoute(
              path: 'incident-list',
              name: 'incident-list',
              builder: (context, state) => const IncidentsListScreen(),
            ),
            GoRoute(
                path: 'inspections-type',
                routes: [
                  GoRoute(
                      path: 'vehicles-list',
                      builder: (context, state) => const VehiclesListScreen(),
                      routes: [
                        GoRoute(
                            path: 'inspection-form',
                            builder: (context, state) =>
                                const InspectionScreen()),
                      ]),
                ],
                builder: (context, state) => const InspectionsTypeScreen()),
          ],
        ),
        GoRoute(
          path: '/',
          redirect: (_, __) => '/',
        ),
      ]);
}
