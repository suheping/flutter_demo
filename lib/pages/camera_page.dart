import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/camera_provider.dart';
import 'package:flutter_demo/routers/application.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  getCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    return firstCamera;
  }

  @override
  void initState() {
    super.initState();

    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      // widget.camera,
      Provider.of<CameraProvider>(context, listen: false).cameraDescription,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    // Provider.of<CameraProvider>(context, listen: false).setIsRecording(false);R
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return CameraPreview(_controller);
              } else {
                // Otherwise, display a loading indicator.
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: RaisedButton(
              onPressed: () async {
                if (!Provider.of<CameraProvider>(context, listen: false)
                    .isRecording) {
                  // 开始录制
                  try {
                    Provider.of<CameraProvider>(context, listen: false)
                        .setVideoPath('');
                    await _initializeControllerFuture;
                    final path = join(
                      (await getExternalStorageDirectory()).path,
                      '${DateTime.now()}.mp4',
                    );
                    await _controller.startVideoRecording(path);
                    Provider.of<CameraProvider>(context, listen: false)
                        .setIsRecording(true);
                    // 保存视频路径
                    Provider.of<CameraProvider>(context, listen: false)
                        .setVideoPath(path);
                  } catch (e) {
                    print(e);
                  }
                } else {
                  // 结束录制
                  try {
                    Provider.of<CameraProvider>(context, listen: false)
                        .setIsRecording(false);
                    // await _initializeControllerFuture;
                    await _controller.stopVideoRecording();
                    // 展示视频
                    Application.router
                        .navigateTo(context, '/video', replace: true);
                  } catch (e) {
                    print(e);
                  }
                }
              },
              child: Text(!Provider.of<CameraProvider>(context).isRecording
                  ? '录制'
                  : '结束'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // child: Icon(Icons.camera_alt),
        child: Text('拍照'),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package.
            final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );
            print(path);
            // Attempt to take a picture and log where it's been saved.
            await _controller.takePicture(path);

            // await _controller.prepareForVideoRecording();

            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
