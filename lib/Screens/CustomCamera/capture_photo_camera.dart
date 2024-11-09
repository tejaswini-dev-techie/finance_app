// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/loading_util.dart';
import 'package:hp_finance/Utils/print_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:sizer/sizer.dart';

class CapturePhotoCamera extends StatefulWidget {
  final int type;
  const CapturePhotoCamera({
    super.key,
    this.type = 1, //1: Means default 2: Means only picture
  });

  @override
  // ignore: library_private_types_in_public_api
  _CapturePhotoCameraState createState() => _CapturePhotoCameraState();
}

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
    default:
      throw ArgumentError('Unknown lens direction');
  }
}

void logError(String code, String? message) {
  if (message != null) {
    PrintUtil().printMsg('Error: $code\nError Message: $message');
  } else {
    PrintUtil().printMsg('Error: $code');
  }
}

class _CapturePhotoCameraState extends State<CapturePhotoCamera>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<CameraDescription> cameras = [];
  CameraDescription? selectedCamera;

  String txtSelectCamera = "Select a camera first!";
  String? somethingWentWrongText = "Something went wrong!!";

  ValueNotifier<bool> hideAppBar = ValueNotifier(false);

  void getLang() {
    AppLanguageUtil appLanguageUtil = AppLanguageUtil();
    appLanguageUtil.getAppContentDetails().then((resp) {
      setState(() {
        Map<String, dynamic> appContent;
        appContent = resp;
        txtSelectCamera = appContent['custom_camera_v1']['select_camera'] ??
            "Select a camera first!";
        somethingWentWrongText = appContent['action_items']
                ['something_went_wrong'] ??
            "Something went wrong!!";
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getLang();
    getAvaiableCamera();
  }

  getAvaiableCamera() async {
    cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      if (cameras.isNotEmpty) {
        selectedCamera = cameras[1];
        onNewCameraSelected(selectedCamera!);
      } else {
        selectedCamera = cameras[0];
        onNewCameraSelected(selectedCamera!);
      }
    }

    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController cameraController = controller!;

    // App state changed before we got the chance to initialize.
    if (!cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    ToastUtil().showSnackBar(context: context, message: message, isError: true);
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description!);
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    await controller?.dispose();

    final CameraController cameraController = CameraController(
        cameraDescription, ResolutionPreset.medium,
        enableAudio: (widget.type == 2) ? false : true);
    controller = cameraController;
    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) setState(() {});
      if (cameraController.value.hasError) {}
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  backHandle() async {
    controller?.dispose();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => backHandle(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          body: Stack(
            children: [
              Positioned(
                child: Container(
                  alignment: Alignment.center,
                  child: cameraScreen(),
                ),
              ),
              Positioned(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: hideAppBar,
                      builder: (context, snapshot, child) {
                        return (hideAppBar.value == false)
                            ? AppBar(
                                backgroundColor: Colors.black.withOpacity(0.10),
                                automaticallyImplyLeading: false,
                                elevation: 0.0,
                                centerTitle: true,
                                leading: InkWell(
                                  onTap: () async {
                                    backHandle();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(8.sp),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      size: 16.0.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                actions: [cameraSwitch()],
                              )
                            : const SizedBox(
                                width: 0.0,
                                height: 0.0,
                              );
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0.0,
                child: SingleChildScrollView(
                  child: Container(
                    width: SizerUtil.width,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.sp,
                    ),
                    alignment: Alignment.bottomCenter,
                    child: cameraCapture(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cameraScreen() {
    final CameraController cameraController = controller!;
    if (!cameraController.value.isInitialized) {
      return Container(
        width: SizerUtil.width,
        height: SizerUtil.height,
        color: Colors.black,
        child: Center(
          child: LoadingUtil.ballRotate(context),
        ),
      );
    } else {
      return cameraWidgetOldVersion(context, cameraController);
    }
  }

  /* Camera package version v0.7.0 and above */
  Widget cameraWidgetNewVersion(context, cameraController) {
    var camera = cameraController.value;
    // fetch screen size
    final size = MediaQuery.of(context).size;

    // calculate scale depending on screen and camera ratios
    // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation
    var scale = size.aspectRatio * camera.aspectRatio;

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;

    return Transform.scale(
      scale: scale,
      child: Center(
        child: CameraPreview(cameraController),
      ),
    );
  }

  /* Older versions - v0.6.6 and below */
  Widget cameraWidgetOldVersion(context, cameraController) {
    // get screen size
    final size = MediaQuery.of(context).size;

    // calculate scale for aspect ratio widget
    var scale = cameraController.value.aspectRatio / size.aspectRatio;

    // check if adjustments are needed...
    if (cameraController.value.aspectRatio < size.aspectRatio) {
      scale = 1 / scale;
    }

    double defaultRatio = MediaQuery.of(context).size.aspectRatio;

    return Transform.scale(
      scale: 1.0,
      child: AspectRatio(
        aspectRatio: defaultRatio,
        child: OverflowBox(
          alignment: Alignment.center,
          child: FittedBox(
            fit: size.aspectRatio >= defaultRatio
                ? BoxFit.fitHeight
                : BoxFit.fitWidth,
            child: SizedBox(
              width:
                  size.aspectRatio >= defaultRatio ? size.height : size.width,
              height: size.aspectRatio >= defaultRatio
                  ? size.height * cameraController.value.aspectRatio
                  : size.width * cameraController.value.aspectRatio,
              child: Stack(
                children: <Widget>[
                  CameraPreview(cameraController),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget cameraSwitch() {
    final CameraController cameraController = controller!;
    return InkWell(
      onTap: () {
        if (cameraController.value.isInitialized &&
            !cameraController.value.isRecordingVideo) {
          if (cameras.isNotEmpty) {
            if (selectedCamera == cameras[0]) {
              selectedCamera = cameras[1];
              onNewCameraSelected(selectedCamera!);
            } else {
              selectedCamera = cameras[0];
              onNewCameraSelected(selectedCamera!);
            }
          }
        }
        setState(() {});
      },
      child: Padding(
        padding: EdgeInsets.only(right: 16.sp),
        child: Icon(
          Icons.cameraswitch,
          size: 25.sp,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> onCaptureButtonPressed() async {
    hideAppBar.value = true;
    await takePicture();
    if (mounted) setState(() {});
  }

  Future<void> takePicture() async {
    final CameraController cameraController = controller!;

    if (!cameraController.value.isInitialized) {
      showInSnackBar(txtSelectCamera);
      return;
    }

    try {
      XFile? imageXFile = await cameraController.takePicture();

      hideAppBar.value = true;

      Navigator.of(context).pop(
        imageXFile.path.toString(),
      );
    } on CameraException catch (e) {
      _showCameraException(e);
      return;
    }
  }

  Future<XFile?> stopVideoRecording() async {
    final CameraController cameraController = controller!;
    if (!cameraController.value.isRecordingVideo) {
      return null;
    }
    try {
      return await cameraController.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  Widget cameraCapture() {
    final CameraController cameraController = controller!;
    return InkWell(
      onTap: () {
        if (cameraController.value.isInitialized) {
          onCaptureButtonPressed();
        } else {
          showInSnackBar(somethingWentWrongText ?? "");
        }
      },
      child: CustomPaint(
        painter: CircularPaint(
          progressValue: 100.0,
          borderThickness: 2.5,
        ),
        child: Container(
          padding: EdgeInsets.all(
            4.5.sp,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.fromBorderSide(BorderSide(
              color: Colors.transparent,
              width: 3.5.sp,
            )),
          ),
          child: CircleAvatar(
            radius: 18.sp,
            backgroundColor: ColorConstants.whiteColor,
          ),
        ),
      ),
    );
  }
}

double deg2rad(double deg) => deg * math.pi / 180;

class CircularPaint extends CustomPainter {
  /// ring/border thickness, default  it will be 8px [borderThickness].
  final double borderThickness;
  final double progressValue;

  CircularPaint({
    this.borderThickness = 3.5,
    required this.progressValue,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    final rect =
        Rect.fromCenter(center: center, width: size.width, height: size.height);

    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = borderThickness;

    //grey background
    canvas.drawArc(
      rect,
      deg2rad(0),
      deg2rad(360),
      false,
      paint,
    );

    Paint progressBarPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = borderThickness
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: ColorConstants.cameraGradientColor,
      ).createShader(rect);
    canvas.drawArc(
      rect,
      deg2rad(-90),
      deg2rad(360 * progressValue),
      false,
      progressBarPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
