import 'dart:io';

import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../core/config/theme/theme.dart';
import '../controllers/scanner_bloc/scanner_bloc.dart';
import '../widgets/progress_indicator_custom.dart';
import '../widgets/scanner_qr_buttons.dart';

class ScannerQrScreen extends StatefulWidget {
  const ScannerQrScreen({
    Key? key,
    required this.backButton,
    required this.scannerType,
    required this.companyToken,
    required this.webController,
  }) : super(key: key);

  final bool? backButton;
  final int scannerType;
  final String companyToken;
  final InAppWebViewController webController;

  @override
  State<ScannerQrScreen> createState() => _ScannerQrScreenState();
}

class _ScannerQrScreenState extends State<ScannerQrScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller?.pauseCamera();
    } else if (Platform.isIOS) {
      await controller?.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scannerBloc = context.watch<ScannerBloc>();
    return BlocBuilder<ScannerBloc, ScannerState>(
      builder: (context, state) {
        switch (state.status) {
          case StatusScanner.loading:
            return WillPopScope(
              onWillPop: () async => false,
              child: const ProgressIndicatorCustom(),
            );
          case StatusScanner.initial:
          case StatusScanner.failed:
          case StatusScanner.success:
            return SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Stack(
                  alignment: Alignment.center,
                  children: [
                    QRView(
                      key: qrKey,
                      onQRViewCreated: (controller) async {
                        final player = AudioPlayer();
                        player
                            .setAsset("assets/audios/barcode_scanner_beep.wav");

                        await scannerBloc.initialQrController(
                            controller,
                            player,
                            widget.webController,
                            widget.scannerType,
                            widget.companyToken,
                            context);
                      },
                      overlay: QrScannerOverlayShape(
                        cutOutSize: MediaQuery.of(context).size.width * 0.65,
                        borderLength: 20,
                        borderWidth: 10,
                        borderRadius: 10,
                        borderColor: AppColors.primaryColor,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Visibility(
                        visible: widget.backButton ?? true,
                        child: IconButton(
                          icon: const Icon(
                            FluentIcons.ios_arrow_ltr_24_filled,
                            color: AppColors.white,
                            size: 16,
                          ),
                          onPressed: () => context.pop(),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 10,
                      child: ScannerQrButtons(),
                    ),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
