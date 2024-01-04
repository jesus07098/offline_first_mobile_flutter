part of 'scanner_bloc.dart';

abstract class ScannerEvent {
  const ScannerEvent();
}

class OnLoadingScanner extends ScannerEvent {
  const OnLoadingScanner();
}

class OnLoadScanner extends ScannerEvent {
  const OnLoadScanner(this.qrCode);
  final String? qrCode;
}

class OnChangeFlash extends ScannerEvent {
  const OnChangeFlash();
}
