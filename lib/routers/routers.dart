import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/routers/handler.dart';

class Routers {
  static Router router;
  static String homePage = '/home';
  static String providerDemoPage = '/provider';
  static String signDemoPage = '/sign';
  static String sdfDemoPage = '/sdf';
  static String easyRefreshDemoPage = '/refresh';
  static String cameraPage = '/camera';
  static String videoPage = '/video';
  static String dragPage = '/drag';
  static String chewiePage = '/chewie';

  static void configureRouters(Router router) {
    router.notFoundHandler = new Handler(
      handlerFunc: (context, parameters) {
        print('route was not found!');
        return null;
      },
    );

    router.define(homePage, handler: homeHandler);
    router.define(providerDemoPage, handler: providerDemoHander);
    router.define(signDemoPage, handler: signDemoHander);
    router.define(sdfDemoPage, handler: sdfDemoHander);
    router.define(easyRefreshDemoPage, handler: easyRefreshDemoHander);
    router.define(cameraPage, handler: cameraHander);
    router.define(videoPage, handler: videoHander);
    router.define(dragPage, handler: dragHander);
    router.define(chewiePage, handler: chewieHander);
  }
}
