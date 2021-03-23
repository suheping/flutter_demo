import 'package:flutter_demo/pages/chewie_demo_page.dart';
import 'package:flutter_demo/pages/home_page.dart';
import 'package:flutter_demo/pages/provider_demo_page.dart';
import 'package:flutter_demo/pages/signature_demo_page.dart';
import 'package:flutter_demo/pages/shared_preferences_demo_page.dart';
import 'package:flutter_demo/pages/easy_refresh_demo.dart';
import 'package:flutter_demo/pages/camera_page.dart';
import 'package:flutter_demo/pages/video_player_page.dart';
import 'package:flutter_demo/pages/drag_demo_page.dart';
import 'package:flutter_demo/pages/web_view_page.dart';
import 'package:flutter_demo/pages/local_auth_page.dart';
import 'package:flutter_demo/pages/login_page.dart';
import 'package:flutter_demo/pages/gesture_page.dart';
import 'package:flutter_demo/pages/set_gesture_page.dart';
import 'package:flutter_demo/pages/verify_gesture_page.dart';
import 'package:flutter_demo/pages/dio_page.dart';
import 'package:flutter_demo/pages/welcome_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_demo/pages/yun_note_pages/yun_note_group_page.dart';
import 'package:flutter_demo/pages/yun_note_pages/yun_note_page.dart';

Handler homeHandler = Handler(
  handlerFunc: (context, parameters) {
    return HomePage();
  },
);

Handler providerDemoHander = Handler(
  handlerFunc: (context, parameters) {
    return ProverDemoPage();
  },
);

Handler signDemoHander = Handler(
  handlerFunc: (context, parameters) {
    return SignDemoPage();
  },
);

Handler sdfDemoHander = Handler(
  handlerFunc: (context, parameters) {
    return SDFDemoPage();
  },
);
Handler easyRefreshDemoHander = Handler(
  handlerFunc: (context, parameters) {
    return EasyRefreshDemo();
  },
);
Handler cameraHander = Handler(
  handlerFunc: (context, parameters) {
    return TakePictureScreen();
  },
);

Handler videoHander = Handler(
  handlerFunc: (context, parameters) {
    return VideoPlayerPage();
  },
);
Handler dragHander = Handler(
  handlerFunc: (context, parameters) {
    return DragDemoPage();
  },
);
Handler chewieHander = Handler(
  handlerFunc: (context, parameters) {
    return ChewieDemoPage();
  },
);

Handler webHander = Handler(
  handlerFunc: (context, parameters) {
    return WebViewPage();
  },
);

Handler localAuthHander = Handler(
  handlerFunc: (context, parameters) {
    return LocalAuthPage();
  },
);

Handler fingerLoginHander = Handler(
  handlerFunc: (context, parameters) {
    return LoginPage();
  },
);

Handler gestureHander = Handler(
  handlerFunc: (context, parameters) {
    return GesturePage();
  },
);

Handler setGestureHander = Handler(
  handlerFunc: (context, parameters) {
    return SetGesturePage();
  },
);

Handler verifyGestureHander = Handler(
  handlerFunc: (context, parameters) {
    return VerifyGesturePage();
  },
);

Handler dioHander = Handler(
  handlerFunc: (context, parameters) {
    return DioPage();
  },
);

Handler welcomeHander = Handler(
  handlerFunc: (context, parameters) {
    return WelcomePage();
  },
);

Handler yunNoteGroupHandler = Handler(
  handlerFunc: (context, parameters) {
    return YunNoteGroupPage();
  },
);

Handler yunNoteHandler = Handler(
  handlerFunc: (context, parameters) {
    return YunNotePage();
  },
);
