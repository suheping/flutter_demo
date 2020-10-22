import 'package:flutter/material.dart';
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

class MyApp extends StatelessWidget {
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
      home: HomePage(),
    );
  }
}
