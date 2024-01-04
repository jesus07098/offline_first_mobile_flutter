import 'dart:developer';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/utils.dart';
import '../../presentation/controllers/printer_provider.dart';


class Printer {
  static final BlueThermalPrinter bluetoothPrinter =
      BlueThermalPrinter.instance;

  static Future<void> initPlatformState(BuildContext context) async {
    final printerProvider =
        Provider.of<PrinterProvider>(context, listen: false);

    try {
      printerProvider.setDevices = await bluetoothPrinter.getBondedDevices();
    } catch (e) {
      log('Ocurrió un error al listar los dispositivos bluetooh disponibles $e');
    }

    bluetoothPrinter.onStateChanged().listen((state) async {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          printerProvider.setConnected = true;
          printerProvider.setPressed = false;
          break;
        case BlueThermalPrinter.DISCONNECTED:
          printerProvider.setConnected = false;
          printerProvider.setPressed = false;
          break;
        case BlueThermalPrinter.STATE_TURNING_ON:
        case BlueThermalPrinter.STATE_ON:
          // final printer = LocalDatabase.printerStorage.get("printer");
          // if (printer != null) {
          // printerProvider.setDevice = BluetoothDevice.fromMap(printer);
          // printerProvider.getDevice!.connected = printer["connected"];
          await bluetoothPrinter
              .connect(printerProvider.getDevice!)
              .then((value) {
            printerProvider.setConnected = true;
            printerProvider.setPressed = false;
          }).catchError((error) {
            final messageError = (error as PlatformException).message;
            if (messageError == 'already connected') {
              printerProvider.setConnected = true;
              printerProvider.setPressed = false;
            }
          });
          // }

          break;
        default:
          debugPrint(state.toString());
          break;
      }
    });
  }

  static void connect(BuildContext context) async {
    final printerProvider =
        Provider.of<PrinterProvider>(context, listen: false);

    if (printerProvider.getDevice == null) {
      show('No hay un dispositivo seleccionado', context);
    } else {
      bluetoothPrinter.isConnected.then((isConnected) {
        if (!isConnected!) {
          bluetoothPrinter.connect(printerProvider.getDevice!).then((value) {
            Map<String, dynamic> printMap = printerProvider.getDevice!.toMap();
            printMap["connected"] = true;
            // LocalDatabase.printerStorage.put('printer', printMap);
          }).catchError((error) {
            printerProvider.setPressed = false;
          });
          printerProvider.setPressed = true;
        }
      });
    }
  }

  static Future show(String message, BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (context.mounted) {
      AlertsManager.showSnackBarCustom(context, SnackBar(content: Text(message)));
    }
  }

  static void disconnect(BuildContext context) {
    final printerProvider =
        Provider.of<PrinterProvider>(context, listen: false);
    bluetoothPrinter.disconnect();
    // LocalDatabase.printerStorage.delete("printer");
    printerProvider.setPressed = true;
  }
}
