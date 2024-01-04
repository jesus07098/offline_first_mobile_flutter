import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/config/theme/app_values.dart';
import '../services/webview_instance_service.dart';
import '../../../../core/presentation/widgets/widgets.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final webController = WebControllerSingleton().webViewController;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Icon(FluentIcons.wifi_off_24_regular, size: 200),
            ),
            const Text(
                'Sin conexión a Internet. Asegúrate de que el wifi o los datos móviles estén activados, luego inténtalo de nuevo.',
                textAlign: TextAlign.center),
            ElevatedButtonCustom(
                label: 'Intentar de nuevo',
                action: () async {
                  bool result =
                      await InternetConnectionChecker().hasConnection;
                  if (result) {
                    await webController!.reload();
                    if (context.mounted) {
                      context.pop();
                    }
                  }
                })
          ],
        ),
      ),
    );
  }
}
