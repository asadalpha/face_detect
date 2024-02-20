import 'dart:io';

import 'package:face_detection/controller/facedeteoctorgallerycontroller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';



class FaceDetectorGalleryView extends GetView<FaceDetectorGalleryController> {
  const FaceDetectorGalleryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(FaceDetectorGalleryController());
    return GetBuilder<FaceDetectorGalleryController>(
      builder: (context) {
        return Scaffold(
          body: controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : (controller.imageFile == null)
              ? Center(child: Text('No image selected'))
              : Center(
            child: FittedBox(
              child: SizedBox(
                width: controller.image?.width.toDouble(),
                height: controller.image?.height.toDouble(),
                child: CustomPaint(
                  painter: FacePainter(controller.image!, controller.faces!),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: controller.getImageAndDetectFaces,
            tooltip: 'Pick Image',
            child: Icon(Icons.add_a_photo),
          ),
        );
      }
    );
  }
}