import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torch_light/torch_light.dart';

import '../../../../core/config/theme/theme.dart';
import '../controllers/scanner_bloc/scanner_bloc.dart';


class ScannerQrButtons extends StatelessWidget {
  const ScannerQrButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scannerBloc = context.watch<ScannerBloc>();
    return BlocBuilder<ScannerBloc, ScannerState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () async {
                if (await hasTorch()) {
                  scannerBloc.add(const OnChangeFlash());
                  await scannerBloc.controller?.toggleFlash();
                }
              },
              icon: Icon(
                state.hasFlashActive ? Icons.flash_on : Icons.flash_off,
                size: 22,
                color: AppColors.white,
              ),
            ),
            IconButton(
              onPressed: () async => await scannerBloc.controller?.flipCamera(),
              icon: const Icon(
                Icons.flip_camera_ios,
                color: AppColors.white,
                size: 26,
              ),
            ),
          ],
        );
      },
    );
  }
}

Future<bool> hasTorch() async {
  try {
    return await TorchLight.isTorchAvailable();
  } on Exception catch (_) {
    return false;
  }
}
