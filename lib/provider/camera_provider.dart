import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraProvider with ChangeNotifier {
  CameraDescription _cameraDescription;
  CameraDescription get cameraDescription => _cameraDescription;

  bool _isRecording = false;
  bool get isRecording => _isRecording;

  String _videoPath = '';
  String get videoPath => _videoPath;

  setCameraDesc(CameraDescription cameraDescription) {
    _cameraDescription = cameraDescription;
    notifyListeners();
  }

  setIsRecording(bool isRecording) {
    _isRecording = isRecording;
    notifyListeners();
  }

  setVideoPath(String path) {
    _videoPath = path;
    notifyListeners();
  }
}
