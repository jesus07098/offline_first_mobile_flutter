import 'package:flutter/material.dart';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:offline_first/core/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../data/services/print_service.dart';

import '../controllers/bluetooth_bloc/bluetooth_bloc.dart';
import '../controllers/printer_provider.dart';

class PrintersListScreen extends StatefulWidget {
  const PrintersListScreen({Key? key}) : super(key: key);

  @override
  State<PrintersListScreen> createState() => _PrintersListScreenState();
}

class _PrintersListScreenState extends State<PrintersListScreen> {
  @override
  Widget build(BuildContext context) {
    final printerProvider = Provider.of<PrinterProvider>(context);
    return BlocBuilder<BluetoothBloc, BluetoothState>(
      builder: (context, state) {
        switch (state.status) {
          case BluetoothStatusConnection.disconnect:
            return const BluetoothAccessLayout();
          case BluetoothStatusConnection.actived:
            return Scaffold(
              appBar: const AppBarCustom(
                titleText: 'Dispositivo de impresión bluetooth',
              ),
              body: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: CustomScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const LabelField(
                              label: 'Seleccione un dispositivo para imprimir:',
                            ),
                            DropdownButtonHideUnderline(
                              child: Container(
                                width: Size.infinite.width,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                margin: const EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade300,
                                ),
                                child: DropdownButton(
                                  itemHeight: 48.0,
                                  elevation: 0,
                                  borderRadius: BorderRadius.circular(10),
                                  dropdownColor: Colors.grey.shade200,
                                  items: _getDeviceItems(printerProvider),
                                  onChanged: (value) => setState(() =>
                                      printerProvider.setDevice =
                                          (value != null)
                                              ? value
                                              : null),
                                  value: printerProvider.getDevice,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 1000),
                                child: printerProvider.getPressed
                                    ? const Align(
                                        alignment: Alignment.center,
                                        child:
                                            CircularProgressIndicator.adaptive(
                                                strokeWidth: 8),
                                      )
                                    : ElevatedButtonCustom(
                                        label: printerProvider.getConnected
                                            ? 'Desconectar'
                                            : 'Conectar',
                                        action: printerProvider.getConnected
                                            ? () => Printer.disconnect(context)
                                            : () => Printer.connect(context),
                                      ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
              ),
            );
        }
      },
    );
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems(
      PrinterProvider printerProvider) {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (printerProvider.getDevices.isEmpty) {
      items.add(const DropdownMenuItem(
        child: Text('Ninguno'),
      ));
    } else {
      for (BluetoothDevice device in printerProvider.getDevices) {
        items.add(DropdownMenuItem(
          value: device,
          child: Text(
            device.name!,
            style: const TextStyle(fontSize: 14),
          ),
        ));
      }
    }
    return items;
  }
}

class BluetoothAccessLayout extends StatelessWidget {
  const BluetoothAccessLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: _EnableBluetoothMessage(),
      ),
    );
  }
}

class _EnableBluetoothMessage extends StatelessWidget {
  const _EnableBluetoothMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(FluentIcons.bluetooth_32_filled, size: 36),
        SizedBox(height: 10),
        Text(
          'Debe de habilitar el Bluetooth',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
