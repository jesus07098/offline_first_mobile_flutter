import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/data/services/location_service.dart';
import '../../domain/entities/entities.dart';
import '../controllers/printer_provider.dart';
import '../controllers/scanner_bloc/scanner_bloc.dart';
import '../templates/templates.dart';

InAppWebViewController? webViewController;

class DetailMenuScreen extends StatefulWidget {
  const DetailMenuScreen({super.key, required this.url});
  final String url;

  @override
  State<DetailMenuScreen> createState() => _DetailMenuScreenState();
}

class _DetailMenuScreenState extends State<DetailMenuScreen> {
  int webviewLoad = 0;
  @override
  Widget build(BuildContext context) {
    final printerProvider = Provider.of<PrinterProvider>(context);
    return BlocProvider(
      create: (context) => ScannerBloc(),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              InAppWebView(
                onLoadError: (webviewController, url, code, message) async {
                  context.push('/no-internet');
                },
        
                initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
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
                  webViewController = controller;

                  webViewController!.addJavaScriptHandler(
                      handlerName: 'normalCamera',
                      callback: (args) async {
                        context.push('/camera', extra: {
                          'cameraType': args[0] ?? 0,
                          'webController': controller
                        });
                      });

                  webViewController!.addJavaScriptHandler(
                      handlerName: 'sharedLink',
                      callback: (args) async {
                        await Share.share(args[1], subject: args[0]);
                      });

                  webViewController!.addJavaScriptHandler(
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
                  webViewController!.addJavaScriptHandler(
                    handlerName: 'viewPrinters',
                    callback: (args) {
                      context.push("/printers-list");
                    },
                  );

                  webViewController!.addJavaScriptHandler(
                      handlerName: 'callPhone',
                      callback: (args) {
                        _makePhoneCall(args[0]);
                      });

                  webViewController!.addJavaScriptHandler(
                    handlerName: 'getLocation',
                    callback: (_) async {
                      final position = await getLocation();

                      webViewController!.evaluateJavascript(
                          source:
                              "document.getElementById('longitude').value = ${position.latitude}");

                      webViewController!.evaluateJavascript(
                          source:
                              "document.getElementById('latitude').value =  ${position.latitude}");
                    },
                  );

                  webViewController!.addJavaScriptHandler(
                    handlerName: 'printTicket',
                    callback: (args) {
                      if (printerProvider.getConnected) {
                        if (Platform.isIOS) {
                          TicketIosTemplate(
                              model: TicketIos.fromJson(json.decode(args[0])));
                        }
                        TicketAndroidTemplate(
                          imageUrl: args[1],
                          model: TicketAndroid.fromMap(json.decode(args[0])),
                        );
                      }
                    },
                  );
                },
                onConsoleMessage: (controller, consoleMessage) {},
              ),
              FloatingAppBarButtons(controller: webViewController),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

class FloatingAppBarButtons extends StatelessWidget {
  const FloatingAppBarButtons({super.key, required this.controller});
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
