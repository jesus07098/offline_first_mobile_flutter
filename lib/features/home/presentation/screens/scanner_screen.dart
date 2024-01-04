import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../widgets/qr_scanner_overlay.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool _screenOpened = false;
  MobileScannerController cameraController =
      MobileScannerController(torchEnabled: false, facing: CameraFacing.back);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black.withOpacity(0.5),
      appBar: AppBarCustom(titleText: 'Escanear Código QR', actions: [
        IconButton(
          color: Colors.white,
          icon: ValueListenableBuilder(
            valueListenable: cameraController.torchState,
            builder: (context, torchState, _) {
              switch (torchState) {
                case TorchState.off:
                  return const Icon(FluentIcons.flash_off_20_filled,
                      color: AppColors.grey400, size: 23);
                case TorchState.on:
                  return const Icon(FluentIcons.flash_20_filled,
                      color: Colors.yellow, size: 23);
              }
            },
          ),
          iconSize: 32.0,
          onPressed: () => cameraController.toggleTorch(),
        ),
      ]),
      body: Stack(
        children: [
          MobileScanner(
              onDetect: _foundBarCode,
              fit: BoxFit.cover,
              controller: cameraController),
          const QRScannerOverlay()
        ],
      ),
    );
  }

  void _foundBarCode(BarcodeCapture capture) {
    if (!_screenOpened) {
      final List<Barcode> barcodes = capture.barcodes;
      // final Uint8List? image = capture.image;
      for (final barcode in barcodes) {
        debugPrint('Barcode found! ${barcode.rawValue}');
      }
      _screenOpened = false;
    }
  }
}
