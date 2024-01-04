import 'dart:async';
import 'dart:io';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/services/print_service.dart';

part 'bluetooth_state.dart';
part 'blu_event.dart';

enum BluetoothStatusConnection { actived, disconnect }

class BluetoothBloc extends Bloc<BluEvent, BluetoothState> {
  StreamSubscription? bluetoothServiceSubscription;

  BluetoothBloc() : super(const BluetoothDisconnectState()) {
    on<BluStatusEvent>(
        (event, emit) => emit(BluetoothChangeState(status: event.status)));
  }

  Future<void> init(BuildContext context) async {
    if (Platform.isAndroid) {
      bluetoothServiceSubscription =
          BlueThermalPrinter.instance.onStateChanged().listen((event) async {
        final isEnabled =
            (event == 1 || event == 11 || event == 12) ? true : false;

        if (isEnabled) {
          await Printer.initPlatformState(context);
        }

        add(BluStatusEvent(
          status: isEnabled
              ? BluetoothStatusConnection.actived
              : BluetoothStatusConnection.disconnect,
        ));
      });
    }
  }

  @override
  Future<void> close() {
    bluetoothServiceSubscription?.cancel();
    return super.close();
  }
}
