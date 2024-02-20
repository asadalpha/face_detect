// import 'dart:html';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:flutter/material.dart';

// class FaceDetectorPage extends StatefulWidget {
//   const FaceDetectorPage({super.key});

//   @override
//   State<FaceDetectorPage> createState() => _FaceDetectorPageState();
// }

// class _FaceDetectorPageState extends State<FaceDetectorPage> {
//   final FaceDetector _faceDetector = FaceDetector(
//     options: FaceDetectorOptions(
//       enableContours: true,
//       enableClassification: true,
//     ),
//   );

//   bool _canProcess = true;
//   bool _isBusy = false;
//   CustomPaint? _customPaint;
//   String? _text;
//   @override

//   void dispose() {
//     _canProcess = false;
//     _faceDetector.close();
//     super.dispose();
//   }
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
