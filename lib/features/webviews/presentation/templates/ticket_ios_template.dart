import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';

import '../../data/services/print_service.dart';
import '../../domain/entities/ticket_ios.dart';

class TicketIosTemplate {
  final TicketIos model;
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  TicketIosTemplate({required this.model}) {
    _print();
  }

  void _print() async {
    Map<String, dynamic> config = {};
    List<LineText> list = [];
    Printer.bluetoothPrinter.isConnected.then((isConnected) async {
      if (isConnected!) {
        for (int i = 0; i < model.line.length; i++) {
          list.add(LineText(
              type: LineText.TYPE_TEXT,
              content: model.line[i],
              weight: 0,
              align: LineText.ALIGN_CENTER,
              linefeed: 1));
        }
      }
      await bluetoothPrint.printReceipt(config, list);
    });
  }
}
