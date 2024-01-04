import 'package:offline_first/core/config/theme/app_values.dart';
import 'package:flutter/material.dart';

class ScaffoldCustom extends StatelessWidget {
  const ScaffoldCustom(
      {super.key,
      this.appBar,
      this.body,
      this.bottomNavigationBar,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.bottomSheet,
      this.backgroundColor,
      this.resizeToAvoidBottomInset = false,
      this.isWebview = false});
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final bool isWebview;
  @override
  Widget build(BuildContext context) {
    final screenMargins = isWebview ? 0.0 : AppPadding.p18;
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomSheet: bottomSheet,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Padding(
        padding: EdgeInsets.only(
            left: screenMargins, right: screenMargins, top: screenMargins),
        child: body,
      ),
    );
  }
}
