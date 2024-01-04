import 'dart:io';

import 'package:barcode_image/barcode_image.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as im;
import 'package:path_provider/path_provider.dart' as pp;

import '../../data/services/print_service.dart';
import '../../domain/entities/ticket_android.dart';

class TicketAndroidTemplate {
  final TicketAndroid model;
  final String? imageUrl;

  TicketAndroidTemplate({required this.model, this.imageUrl}) {
    _print();
  }

  void _print() async {
    Printer.bluetoothPrinter.isConnected.then((isConnected) async {
      if (isConnected!) {
        await printImageFromURL();
        Printer.bluetoothPrinter.printCustom(
          model.companyData?[0].description ?? "EMPRESA",
          3,
          1,
        );

        Printer.bluetoothPrinter.printNewLine();

        if (model.companyData?.isNotEmpty ?? false) {
          for (int i = 1; i < model.companyData!.length; i++) {
            if (model.companyData![i].title?.isNotEmpty ?? false) {
              Printer.bluetoothPrinter.printCustom(
                "${model.companyData![i].title} ${model.companyData![i].description}",
                1,
                1,
              );
            } else {
              Printer.bluetoothPrinter.printCustom(
                "${model.companyData?[i].description}",
                1,
                1,
              );
            }
          }
        }

        Printer.bluetoothPrinter.printNewLine();

        if (model.documentHeader?.isNotEmpty ?? false) {
          for (int i = 0; i < model.documentHeader!.length; i++) {
            if (model.documentHeader![i].title?.isNotEmpty ?? false) {
              Printer.bluetoothPrinter.printCustom(
                "${model.documentHeader?[i].title} ${model.documentHeader?[i].description}",
                1,
                0,
              );
            } else {
              Printer.bluetoothPrinter.printCustom(
                "${model.documentHeader?[i].description}",
                1,
                0,
              );
            }
          }
        }

        Printer.bluetoothPrinter.printNewLine();

        if (model.documentBodyHeader?.isNotEmpty ?? false) {
          if (model.documentBodyHeader![0].abbreviation?.length == 1) {
            Printer.bluetoothPrinter.printCustom(
              "${model.documentBodyHeader?[0].abbreviation?[0]}",
              1,
              1,
            );
          }

          if (model.documentBodyHeader![0].abbreviation?.length == 2) {
            Printer.bluetoothPrinter.printLeftRight(
              "${model.documentBodyHeader?[0].abbreviation?[0]}",
              "${model.documentBodyHeader?[0].abbreviation?[1]}",
              0,
              format: "%-8s %8s %n",
            );
          }

          if (model.documentBodyHeader![0].abbreviation?.length == 3) {
            Printer.bluetoothPrinter.print3Column(
              "${model.documentBodyHeader?[0].abbreviation?[0]}",
              "${model.documentBodyHeader?[0].abbreviation?[1]}",
              "${model.documentBodyHeader?[0].abbreviation?[2]}",
              0,
              format: "%-12s %-1s %12s %n",
            );
          }

          if (model.documentBodyHeader![0].abbreviation?.length == 4) {
            Printer.bluetoothPrinter.print4Column(
              "${model.documentBodyHeader?[0].abbreviation?[0]}",
              "${model.documentBodyHeader?[0].abbreviation?[1]}",
              "${model.documentBodyHeader?[0].abbreviation?[2]}",
              "${model.documentBodyHeader?[0].abbreviation?[3]}",
              0,
              format: "%-7s %-7s %-7s %-7s %n",
            );
          }
        }

        Printer.bluetoothPrinter.printCustom("----------------", 2, 1);

        if (model.documentBodyLines?.isNotEmpty ?? false) {
          for (DocumentBodyLine line in model.documentBodyLines!) {
            if (line.title?.length == 1) {
              Printer.bluetoothPrinter.printCustom(
                "${line.title?[0]}",
                0,
                1,
              );
            }
            if (line.title?.length == 2) {
              Printer.bluetoothPrinter.printLeftRight(
                "${line.title?[0]}",
                "${line.title?[1]}",
                0,
                format: "%-8s %8s %n",
              );
            }
            if (line.title?.length == 3) {
              Printer.bluetoothPrinter.print3Column(
                "${line.title?[0]}",
                "${line.title?[1]}",
                "${line.title?[2]}",
                0,
                format: "%-1s %-13s %13s %n",
              );
            }
            if (line.title?.length == 4) {
              Printer.bluetoothPrinter.print4Column(
                "${line.title?[0]}",
                "${line.title?[1]}",
                "${line.title?[2]}",
                "${line.title?[3]}",
                0,
                format: "%-7s %-7s %-7s %-7s %n",
              );
            }

            if (line.description != null) {
              Printer.bluetoothPrinter.printCustom(
                line.description!,
                1,
                0,
              );
            }
          }
        }

        Printer.bluetoothPrinter.printCustom("----------------", 2, 1);

        Printer.bluetoothPrinter.printNewLine();

        if (model.documentNotes?.isNotEmpty ?? false) {
          for (int i = 0; i < model.documentNotes!.length; i++) {
            if (model.documentNotes![i].title != null) {
              Printer.bluetoothPrinter.printCustom(
                "${model.documentNotes?[i].title} ${model.documentNotes?[i].description}",
                1,
                0,
              );
            } else {
              Printer.bluetoothPrinter.printCustom(
                "${model.documentNotes?[i].description}",
                1,
                1,
              );
            }

            Printer.bluetoothPrinter.printNewLine();
          }
        }

        Printer.bluetoothPrinter.printNewLine();

        if (model.documentFooter?.isNotEmpty ?? false) {
          for (var i = 0; i < model.documentFooter!.length; i++) {
            Printer.bluetoothPrinter.printCustom(
              "${model.documentFooter?[i].title} ${model.documentFooter?[i].description}",
              1,
              2,
            );
          }
        }

        Printer.bluetoothPrinter.printNewLine();
        Printer.bluetoothPrinter.printQRcode(
            model.codesToScanner?[0].description ?? "no-data", 200, 200, 1);
        Printer.bluetoothPrinter.printNewLine();
        Printer.bluetoothPrinter.printNewLine();

        final image = im.Image(width: 300, height: 150);

        final temp = await pp.getTemporaryDirectory();

        final path = '${temp.path}/ticketSecure.png';
  

        im.fill(image, color: im.convertColor(im.ColorRgb8.from(im.ColorUint8.rgb(0, 0, 0))));

        drawBarcode(
          image,
          Barcode.code128(),
          model.codesToScanner?[1].description ?? '',
          font: im.arial24,
        );

        File(path).writeAsBytes(im.encodePng(image)).then((v) {
          Printer.bluetoothPrinter.printImage(path);
          Printer.bluetoothPrinter.printNewLine();
          Printer.bluetoothPrinter.printNewLine();
          Printer.bluetoothPrinter.printNewLine();
          Printer.bluetoothPrinter.printNewLine();
        });
      }
    });
  }

  Future<void> printImageFromURL() async {
    try {
      if (imageUrl != null) {
        http.Response response = await http.get(Uri.parse(imageUrl!));
        final byteData = response.bodyBytes;
        await Printer.bluetoothPrinter.printImageBytes(byteData);
      }
    } catch (e) {
      Exception(e);
    }
  }
}

