import 'package:flutter/material.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class PrinterProvider extends ChangeNotifier {
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _device;
  bool _connected = false;
  bool _pressed = false;

  List<BluetoothDevice> get getDevices => _devices;
  BluetoothDevice? get getDevice => _device;
  bool get getConnected => _connected;
  bool get getPressed => _pressed;

  Future<bool?> get isConnected async =>
      await BlueThermalPrinter.instance.isConnected;

  set setDevices(List<BluetoothDevice> newDevices) {
    _devices = newDevices;
    notifyListeners();
  }

  set setDevice(BluetoothDevice? newDevice) {
    _device = newDevice;
    notifyListeners();
  }

  set setConnected(bool connected) {
    _connected = connected;
    notifyListeners();
  }

  set setPressed(bool pressed) {
    _pressed = pressed;
    notifyListeners();
  }
}
