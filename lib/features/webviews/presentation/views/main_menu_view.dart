import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

import '../services/webview_instance_service.dart';
import '../../../auth/presentation/blocs/auth/auth_bloc.dart';
import '../widgets/progress_indicator_custom.dart';

class MainMenuView extends StatefulWidget {
  const MainMenuView({super.key});

  @override
  State<MainMenuView> createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView> {
  int webviewLoad = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Stack(
          children: [
            InAppWebView(
              onLoadError: (webviewController, url, code, message) {
                context.push('/no-internet');
              },
              initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      "https://webview.sanel.com.do/?token=${state.token ?? 'no-token'}")),
              initialOptions: InAppWebViewGroupOptions(
                  ios: IOSInAppWebViewOptions(
                    allowsLinkPreview: false,
                    disableLongPressContextMenuOnLinks: true,
                  ),
                  crossPlatform: InAppWebViewOptions(
                    disableContextMenu: true,
                    horizontalScrollBarEnabled: false,
                    verticalScrollBarEnabled: false,
                  ),
                  android: AndroidInAppWebViewOptions(
                      builtInZoomControls: false,
                      overScrollMode: AndroidOverScrollMode.OVER_SCROLL_NEVER,
                      disabledActionModeMenuItems:
                          AndroidActionModeMenuItem.MENU_ITEM_NONE)),
              onProgressChanged: (controller, progress) {
                if (progress == 100 && mounted) {
                  setState(() {
                    webviewLoad = progress;
                  });
                }
              },
              onWebViewCreated: (InAppWebViewController controller) {
                WebControllerSingleton().webViewController = controller;

                WebControllerSingleton()
                    .webViewController!
                    .addJavaScriptHandler(
                        handlerName: 'detailMenu',
                        callback: (args) async {
                          context.push('/detail-menu', extra: {'url': args[0]});
                        });

                WebControllerSingleton()
                    .webViewController!
                    .addJavaScriptHandler(
                      handlerName: 'scanQR',
                      callback: (args) {
                        int scannerType = args[0] as int;
                        context.push('/scannerQr', extra: {
                          'backButton': true,
                          'companyToken': args[1],
                          'scannerType': scannerType,
                          'webController': controller
                        });
                      },
                    );
              },
              onConsoleMessage: (controller, consoleMessage) {},
            ),
            if (webviewLoad < 100) const ProgressIndicatorCustom()
          ],
        );
      },
    );
  }
}
