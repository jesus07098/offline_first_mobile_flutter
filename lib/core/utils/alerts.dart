import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AlertsManager {
  //SnackBars
  static showSnackBarCustom(BuildContext context, SnackBar snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static hideSnackBarCustom(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  // BottomSheets
  static showBottomSheetCustom(BuildContext context, Widget widget) {
    showModalBottomSheet(
        context: context,
        builder: (context) => widget,
        isScrollControlled: true);
  }
  
  //Dialogs
  static showDialogCustom(BuildContext context, Widget widget) {
    showDialog(context: context, builder: (context) => widget);
  }

  //Toast 
  static showToastCustom(Widget child) {
    FToast().showToast(
      child: child,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
