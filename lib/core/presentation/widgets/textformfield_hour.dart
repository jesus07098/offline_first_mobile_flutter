import 'package:offline_first/core/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TextFormFieldHour extends StatelessWidget {
  const TextFormFieldHour(
      {super.key, required this.initialTime, this.controller, this.onChanged});

  final TimeOfDay initialTime;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldCustom(
      controller: (controller != null) ? controller : null,
      readOnly: true,
      onTap: () async {
        final selectedHour = await showTimePicker(
          context: context,
          initialTime: initialTime,
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: false),
                child: child!);
          },
        );

        if (selectedHour == null) return;
        if (controller != null && context.mounted) {
          controller!.text = selectedHour.format(context).toString();
        }
        if (onChanged != null && context.mounted) {
          onChanged!.call(selectedHour.format(context).toString());
        }
      },
    );
  }
}
