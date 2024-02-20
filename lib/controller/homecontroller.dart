import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:logger/logger.dart';

class HomeController extends GetxController {
  RxBool isInitializedCamera = false.obs;
  FaceDetector? _faceDetector;
  late CameraController cameraController;
  var logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );
  final count = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initializeCamera();
    await initializeFaceDetector();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.high);
    await cameraController.initialize();
    cameraController.setFlashMode(FlashMode.always);
    isInitializedCamera.value = true;
    update();
  }

  Future<void> initializeFaceDetector() async {
    _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(performanceMode: FaceDetectorMode.accurate),
    );
  }

  Future<List<CameraDescription>> getAvailableCameras() async {
    return availableCameras();
  }
}