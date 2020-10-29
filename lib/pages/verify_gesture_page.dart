import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/sdf_provider.dart';
import 'package:flutter_demo/routers/application.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gesture_recognition/gesture_view.dart';
import 'package:provider/provider.dart';

class VerifyGesturePage extends StatefulWidget {
  VerifyGesturePage({Key key}) : super(key: key);

  @override
  _VerifyGesturePageState createState() => _VerifyGesturePageState();
}

class _VerifyGesturePageState extends State<VerifyGesturePage> {
  List<int> curResult = [];
  List<int> correctResult = [0, 1, 2, 5, 8, 7, 6];
  GlobalKey<GestureState> gestureStateKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('验证手势密码'),
      ),
      body: Center(
        child: GestureView(
          size: 300,
          immediatelyClear: true,
          key: this.gestureStateKey,
          selectColor: Colors.blue,
          onPanDown: () {},
          onPanUp: (List<int> items) {
            analysisGesture(context, items);
          },
        ),
      ),
    );
  }

  analysisGesture(BuildContext context, List<int> items) async {
    List<int> correctResult =
        Provider.of<SDFProvider>(context, listen: false).gestureCode;
    bool isCorrect = true;
    if (items.length == correctResult.length) {
      for (int i = 0; i < items.length; i++) {
        if (items[i] != correctResult[i]) {
          isCorrect = false;
          break;
        }
      }
    } else {
      isCorrect = false;
    }
    if (isCorrect) {
      Fluttertoast.showToast(msg: '手势密码验证通过', backgroundColor: Colors.grey);
      Application.router.pop(context);
    } else {
      Fluttertoast.showToast(
          msg: '手势密码验证失败，请重试！', backgroundColor: Colors.grey);
    }
  }
}
