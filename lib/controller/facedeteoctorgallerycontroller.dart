import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class FaceDetectorGalleryController extends GetxController {
  var logger = Logger();
  var selectedImagePath = ''.obs;
  var extractedBarcode = ''.obs;
  RxBool isLoading = false.obs;
  XFile? imageFile;
  List<Face>? faces;
  ui.Image? image;

  Future<void> getImageAndDetectFaces() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      isLoading.value = true;
      imageFile = pickedImage;

      final inputImage = InputImage.fromFilePath(pickedImage.path);
      final faceDetector = GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
        performanceMode: FaceDetectorMode.fast,
        enableLandmarks: true,
      ));
      final detectedFaces = await faceDetector.processImage(inputImage);

      faces = detectedFaces;
      await _loadImage(pickedImage);

      isLoading.value = false;
    } catch (e) {
      logger.e('Error detecting faces: $e');
      isLoading.value = false;
    } finally {
      update();
    }
  }

  Future<void> _loadImage(XFile file) async {
    final data = await file.readAsBytes();
    final decodedImage = await decodeImageFromList(data);
    image = decodedImage;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class FacePainter extends CustomPainter {
  final ui.Image image;
  final List<Face> faces;

  FacePainter(this.image, this.faces);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.blue;

    canvas.drawImage(image, Offset.zero, Paint());

    for (final face in faces) {
      final rect = face.boundingBox;
      canvas.drawRect(
        Rect.fromLTRB(
          rect.left,
          rect.top,
          rect.right,
          rect.bottom,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return image != oldDelegate.image || faces != oldDelegate.faces;
  }
}
