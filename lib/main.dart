import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/pages/finger_login_page.dart';
import 'package:flutter_demo/pages/home_page.dart';
import 'package:flutter_demo/provider/file_provider.dart';
import 'package:flutter_demo/provider/web_view_provider.dart';
import 'package:flutter_demo/routers/application.dart';
import 'package:flutter_demo/routers/routers.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/provider/counter_provider.dart';
import 'package:flutter_demo/provider/sdf_provider.dart';
import 'package:flutter_demo/provider/refresh_provider.dart';
import 'package:flutter_demo/provider/camera_provider.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:fluro/fluro.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => CounterProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => FileProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => SDFProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => RefreshProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => CameraProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => WebViewProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final JPush jpush = new JPush();
  String debugLable = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    // await Provider.of<SDFProvider>(context, listen: false)
    //     .getFingerLoginEnable();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotification: $message");
        setState(() {
          debugLable = "flutter onReceiveNotification: $message";
        });
      }, onOpenNotification: (Map<String, dynamic> message) async {
        print("flutter onOpenNotification: $message");
        setState(() {
          debugLable = "flutter onOpenNotification: $message";
        });
      }, onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
        setState(() {
          debugLable = "flutter onReceiveMessage: $message";
        });
      }, onReceiveNotificationAuthorization:
              (Map<String, dynamic> message) async {
        print("flutter onReceiveNotificationAuthorization: $message");
        setState(() {
          debugLable = "flutter onReceiveNotificationAuthorization: $message";
        });
      });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    jpush.setup(
      appKey: "ff96737487c82479dc67fbae", //你自己应用的 AppKey
      channel: "theChannel",
      production: false,
      debug: true,
    );
    jpush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    // Platform messages may fail, so we use a try/catch PlatformException.
    jpush.getRegistrationID().then((rid) {
      print("flutter get registration id : $rid");
      setState(() {
        debugLable = "flutter getRegistrationID: $rid";
      });
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      debugLable = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 路由引入固定写法
    final router = FluroRouter();
    Routers.configureRouters(router);
    Application.router = router;
    return new MaterialApp(
      title: 'flutter常用功能集合',
      theme: ThemeData(primaryColor: Colors.blue),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
      home: FingerLoginPage(),
    );
  }
}
