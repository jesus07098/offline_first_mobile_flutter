import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/theme/theme.dart';
import '../../../webviews/presentation/services/webview_instance_service.dart';
import '../../../webviews/presentation/widgets/progress_indicator_custom.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int webviewLoad = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            InAppWebView(
              onLoadError: (webviewController, url, code, message) {
                context.push('/no-internet');
              },
              initialUrlRequest: URLRequest(
                  url: Uri.parse("https://webview.sanel.com.do/register.php")),
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
                        handlerName: 'closeWebView',
                        callback: (args) async {
                          context.pop();
                        });
              },
              onConsoleMessage: (controller, consoleMessage) {},
            ),
            _FloatingAppBarButtons(
                controller: WebControllerSingleton().webViewController),
            if (webviewLoad < 100) const ProgressIndicatorCustom()
          ],
        ),
      ),
    );
  }
}

class _FloatingAppBarButtons extends StatelessWidget {
  const _FloatingAppBarButtons({required this.controller});
  final InAppWebViewController? controller;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 10,
        right: 10,
        child: Container(
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: AppColors.grey300)),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        if (controller != null) {
                          controller!.evaluateJavascript(
                              source:
                                  "document.getElementById('showDraggableOnWebview').click()");
                        }
                      },
                      icon: const Icon(FluentIcons.more_horizontal_32_filled,
                          color: AppColors.black, size: 20)),
                  const SizedBox(
                      width: 10,
                      height: 10,
                      child:
                          VerticalDivider(width: 2, color: AppColors.grey400)),
                  IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(FluentIcons.dismiss_circle_12_regular,
                          color: AppColors.black, size: 20)),
                ],
              ),
            )));
  }
}
