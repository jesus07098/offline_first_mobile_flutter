import 'dart:convert';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/theme/theme.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    Key? key,
    required this.webController,
    required this.cameraType,
  }) : super(key: key);

  final InAppWebViewController webController;
  final int cameraType;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraDescription? cameraDescription;

  @override
  void initState() {
    super.initState();
    initialCamera();
  }

  Future<void> initialCamera() async {
    final cameras = await availableCameras();

    if (widget.cameraType == 0) {
      cameraDescription = cameras.first;
    } else {
      cameraDescription = cameras[1];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (cameraDescription == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return TakePictureScreen(
      camera: cameraDescription!,
      webController: widget.webController,
    );
  }
}

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen(
      {Key? key, required this.camera, required this.webController})
      : super(key: key);

  final CameraDescription camera;
  final InAppWebViewController webController;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  XFile? imagesPath;
  bool usePhoto = false;
  bool isFlashActive = false;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(
                  _controller,
                );
              } else {
                return const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primaryColor),
                );
              }
            },
          ),
          Positioned(
              top: 14,
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(
                            isFlashActive ? Icons.flash_on : Icons.flash_off,
                            size: 26),
                        color: AppColors.white,
                        onPressed: () {
                          setState(() {
                            isFlashActive = !isFlashActive;
                          });
                          isFlashActive
                              ? _controller.setFlashMode(FlashMode.torch)
                              : _controller.setFlashMode(FlashMode.off);
                        }),
                  ],
                ),
              )),
          Positioned(
            left: 15,
            top: 10,
            child: SafeArea(
                child: ElevatedButton(
              onPressed: () => context.pop(),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
                backgroundColor: AppColors.black,
              ),
              child: const Icon(FluentIcons.ios_arrow_ltr_24_filled,
                  size: 20, color: AppColors.white),
            )),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: usePhoto
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  backgroundColor: AppColors.red500,
                  heroTag: null,
                  onPressed: () async {
                    setState(() {
                      usePhoto = false;
                    });
                  },
                  child: const Icon(FluentIcons.dismiss_20_filled,
                      color: AppColors.white),
                ),
                const SizedBox(width: 50),
                FloatingActionButton(
                  backgroundColor: AppColors.green400,
                  heroTag: null,
                  onPressed: () async {
                    List<int> imageBytes = await imagesPath!.readAsBytes();
                    String base64Image = base64Encode(imageBytes);

                    await widget.webController.evaluateJavascript(
                        source:
                            "resultCamera('$base64Image', 0 ,'company_token')");
                    if (mounted) {
                      context.pop();
                    }
                  },
                  child: const Icon(FluentIcons.checkmark_20_filled,
                      color: AppColors.white),
                ),
              ],
            )
          : Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                heroTag: null,
                backgroundColor: AppColors.primaryColor,
                onPressed: () async {
                  try {
                    await _initializeControllerFuture;
                    imagesPath = await _controller.takePicture();
                    if (!mounted) return;
                    setState(() {
                      usePhoto = true;
                    });
                  } catch (e) {
                    log(e.toString());
                  }
                },
                child: const Icon(
                  Icons.camera_alt,
                  color: AppColors.white,
                  size: 23,
                ),
              ),
            ),
    );
  }
}
