// import 'dart:html';
// import 'package:image_picker/image_picker.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

// class CameraView extends StatefulWidget {
//   const CameraView(
//       {super.key,
//       required this.title,
//       this.customPaint,
//       this.text,
//       this.onImage,
//       required this.initialDirection});
//   final String title;
//   final CustomPaint? customPaint;
//   final String? text;
//   final Function(InputImage inputImage)? onImage;
//   final CameraLensDirection initialDirection;

//   @override
//   State<CameraView> createState() => _CameraViewState();
// }

// class _CameraViewState extends State<CameraView> {
//   ScreenMode _mode = ScreenMode.live;
//   CameraController? _controller;
//   File? _image;
//   String? _path;
//   ImagePicker? imagePicker;
//   int _cameraIndex = 0;
//   double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;
//   final bool _allowPicker = true;
//   bool _changingCameraLens = false;

//   @override
//   void initState() {
//     imagePicker = ImagePicker();
//     if (cameras.any((element) =>
//         element.lensDirection == widget.initialDirection &&
//         element.sensorDirection == 90)) {
//       _cameraIndex = cameras.indexOf(cameras.firstWhere((element) =>
//           element.lensDirection == widget.initialDirection &&
//           element.sensorDirection == 90));
//     } else {
//       _cameraIndex = cameras.indexOf(cameras.firstWhere(
//           (element) => element.lensDirection == widget.initialDirection));
//     }

//     _startLive();
//     super.initState();
//   }

//   Future _startLive() async {
//     final camera = cameras[_cameraIndex];
//     _controller = CameraController(
//       camera,
//       ResolutionPreset.high,
//       enableAudio: false,
//     );
//     _controller?.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       _controller?.getMaxZoomLevel().then((value) {
//         maxZoomLevel = value;
//         minZoomLevel = value;
//       });
//       _controller?.startImageStream((_processCameraImage));
//       setState(() {});
//     });
//   }

//   Future _processCameraImage(final CameraImage image) async {
//     final WriteBuffer allbytes = WriteBuffer();
//     for (final Plane plane in image.planes) {
//       allbytes.putUint8List(plane.bytes);
//     }
//     final bytes = allbytes.done().buffer.asUint8List();
//     final Size imageSize =
//         Size(image.width.toDouble(), image.height.toDouble());
//     final camera = cameras[_cameraIndex];
//     final imageRotation =
//         InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
//             InputImageRotation.nv21;
//     final planeData = image.planes.map(
//       (Plane plane) {
//         return InputImagePlaneMetadata(
//           bytesPerRow: plane.bytesPerRow,
//           height: plane.height,
//           width: plane.width,
//         );
//       },
//     ).toList();
//     final inputImageData() = InputImageData(
//       size: imageSize,
//       inputImageFormat: InputImageFormat,
//       planeData: planeData,
//       imageRotation: imageRotation,
//     );
//     final inputImage =
//         InputImage.fromBytes(bytes: bytes, InputImageData: inputImageData);
//     widget.onImage(inputImage);
//   }

//   @override
//   Widget build(BuildContext context) {
//     void _switchScreenMode() {
//       _image = null;
//       if (_mode == ScreendMode.live) {
//         _mode = ScreenMode.gallery;
//         _stopLive();
//       } else {
//         _mode = ScreenMode.live;
//         _startLive();
//       }
//       setState(() {});
//     }

//     Future _stopLive() async{

//       await _controller?.stopImageStream();
//       await _controller?.dispose();
//       _controller = null;
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Camera"),
//         actions: [
//           if (_allowPicker)
//             Padding(
//               padding: const EdgeInsets.only(right: 20.0),
//               child: GestureDetector(
//                   onTap: _switchScreenMode,
//                   child: Icon(_mode == ScreenMode.live
//                       ? Icons.photo_library_rounded
//                       : Icons.camera)),
//             ),
//         ],
//       ),
//     );
//   }
// }
