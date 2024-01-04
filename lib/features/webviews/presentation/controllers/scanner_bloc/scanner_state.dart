part of 'scanner_bloc.dart';

enum StatusScanner { initial, loading, success, failed }

class ScannerState extends Equatable {
  const ScannerState({
    this.status = StatusScanner.initial,
    this.hasFlashActive = false,
    this.qrCode,
  });

  final StatusScanner status;
  final bool hasFlashActive;
  final String? qrCode;

  ScannerState copyWith({
    StatusScanner? status,
    bool? hasFlashActive,
    String? qrCode,
  }) =>
      ScannerState(
        status: status ?? this.status,
        hasFlashActive: hasFlashActive ?? this.hasFlashActive,
        qrCode: qrCode ?? this.qrCode
      );

  @override
  List<Object?> get props => [status, hasFlashActive, qrCode];
}
