import 'package:image_picker/image_picker.dart';

CameraDevice obterCamera({required bool usarFrontal}) {
  return usarFrontal ? CameraDevice.front : CameraDevice.rear;
}
