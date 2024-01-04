import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  StreamSubscription<Barcode>? listen;
  QRViewController? controller;
  ScannerBloc() : super(const ScannerState()) {
    on<OnLoadingScanner>(
        (event, emit) => emit(state.copyWith(status: StatusScanner.loading)));
    on<OnLoadScanner>((event, emit) => emit(
        state.copyWith(status: StatusScanner.success, qrCode: event.qrCode)));
    on<OnChangeFlash>(
      (event, emit) =>
          emit(state.copyWith(hasFlashActive: !state.hasFlashActive)),
    );
  }

  Future initialQrController(
      QRViewController controller,
      AudioPlayer player,
      InAppWebViewController webController,
      int scannerType,
      String companyToken,
      BuildContext context) async {
    this.controller = controller;
    await this.controller?.pauseCamera();
    await this.controller?.resumeCamera();

    listen = controller.scannedDataStream.listen((qrcode) async {
      if (state.status != StatusScanner.loading && qrcode.code != null) {
        add(const OnLoadingScanner());
        await player.play();
        add(OnLoadScanner(qrcode.code));
        await webController.evaluateJavascript(
            source:
                "getResultScanner('$scannerType', '${qrcode.code}', '$companyToken')");
        if (context.mounted) {
          context.pop();
        }
      }
    });
  }
}
